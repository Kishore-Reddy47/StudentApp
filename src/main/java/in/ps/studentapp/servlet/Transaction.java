package in.ps.studentapp.servlet;

import java.io.IOException;
import in.ps.studentapp.dao.PaymentDAOImpl;
import in.ps.studentapp.dao.PaymentsDAO;
import in.ps.studentapp.dto.Payment;
import in.ps.studentapp.dto.Student;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/transaction")
public class Transaction extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Payment p = new Payment();
		PaymentsDAO pdao = new PaymentDAOImpl();
		HttpSession session = req.getSession();
		Student s = (Student) session.getAttribute("student");

		p.setCourseId(Integer.parseInt(req.getParameter("courseId")));
		p.setStudentId(s.getId());
		p.setTransactionId(Long.parseLong(req.getParameter("tranId")));
		p.setMethod(req.getParameter("method"));
		p.setPath("NA");
		boolean res = pdao.insertPayment(p);
		if (res) {
			req.setAttribute("success", "Payment successful!");
			RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
			rd.forward(req, resp);
		} else {
			req.setAttribute("error", "Payment failed!");
			RequestDispatcher rd = req.getRequestDispatcher("courses.jsp");
			rd.forward(req, resp);
		}
	}
}
