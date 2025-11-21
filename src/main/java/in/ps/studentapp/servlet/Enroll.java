package in.ps.studentapp.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.Instant;

import in.ps.studentapp.dao.PaymentDAOImpl;
import in.ps.studentapp.dao.PaymentsDAO;
import in.ps.studentapp.dto.Payment;
import in.ps.studentapp.dto.Student;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/submit")
@MultipartConfig(fileSizeThreshold = 1024 * 100, // 100KB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 15) // 15MB
public class Enroll extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Ensure user is logged in
        HttpSession session = req.getSession(false);
        if (session == null) {
            req.setAttribute("error", "Please login before enrolling.");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
            return;
        }

        Student s = (Student) session.getAttribute("student");
        if (s == null) {
            req.setAttribute("error", "Please login before enrolling.");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
            return;
        }

        String courseIdStr = req.getParameter("courseId");
        String tranIdStr = req.getParameter("tranId");
        String method = req.getParameter("method");

        if (courseIdStr == null || tranIdStr == null || method == null) {
            req.setAttribute("error", "Missing enrollment parameters.");
            RequestDispatcher rd = req.getRequestDispatcher("courses.jsp");
            rd.forward(req, resp);
            return;
        }

        int courseId = 0;
        long tranId = 0L;
        try {
            courseId = Integer.parseInt(courseIdStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid course id.");
            RequestDispatcher rd = req.getRequestDispatcher("courses.jsp");
            rd.forward(req, resp);
            return;
        }
        try {
            tranId = Long.parseLong(tranIdStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid transaction id.");
            RequestDispatcher rd = req.getRequestDispatcher("courses.jsp");
            rd.forward(req, resp);
            return;
        }

        // Handle optional file upload named 'proof'
        String savedPath = "NA";
        try {
            Part proof = req.getPart("proof");
            if (proof != null && proof.getSize() > 0) {
                String submittedFileName = getSubmittedFileName(proof);
                String ext = "";
                if (submittedFileName != null && submittedFileName.contains(".")) {
                    ext = submittedFileName.substring(submittedFileName.lastIndexOf('.'));
                }
                String fileName = "payment_" + s.getId() + "_" + courseId + "_" + Instant.now().toEpochMilli() + ext;

                // Save under webapp/uploads
                String uploadsDir = getServletContext().getRealPath("/") + File.separator + "uploads";
                File uploads = new File(uploadsDir);
                if (!uploads.exists()) {
                    uploads.mkdirs();
                }
                File file = new File(uploads, fileName);

                try (InputStream in = proof.getInputStream()) {
                    Files.copy(in, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }

                // Save relative path for DB (so it can be used to serve the file)
                savedPath = "uploads/" + fileName;
            }
        } catch (Exception ex) {
            // If file handling fails, log and continue with path=NA
            ex.printStackTrace();
        }

        // Create payment object and persist
        Payment p = new Payment();
        p.setCourseId(courseId);
        p.setStudentId(s.getId());
        p.setTransactionId(tranId);
        p.setMethod(method);
        p.setPath(savedPath);

        PaymentsDAO pdao = new PaymentDAOImpl();
        boolean res = pdao.insertPayment(p);
        if (res) {
            req.setAttribute("success", "Enrollment/payment submitted successfully. It will be reviewed shortly.");
            RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
            rd.forward(req, resp);
        } else {
            req.setAttribute("error", "Failed to submit enrollment/payment. Please try again.");
            RequestDispatcher rd = req.getRequestDispatcher("courses.jsp");
            rd.forward(req, resp);
        }
    }

    // Utility method compatible with servlet API to extract submitted file name
    private static String getSubmittedFileName(Part part) {
        if (part == null) return null;
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String cd : header.split(";")) {
            cd = cd.trim();
            if (cd.startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName;
            }
        }
        return null;
    }
}