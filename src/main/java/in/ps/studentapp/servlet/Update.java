package in.ps.studentapp.servlet;

import java.io.IOException;
import in.ps.studentapp.dao.StudentDAO;
import in.ps.studentapp.dao.StudentDAOImpl;
import in.ps.studentapp.dto.Student;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update")
public class Update extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		Student s = (Student) session.getAttribute("student");
		s.setName(req.getParameter("name"));
		s.setPhone(Long.parseLong(req.getParameter("phone")));
		s.setMail(req.getParameter("mail"));
		StudentDAO sdao = new StudentDAOImpl();
		boolean res = sdao.updateStudent(s);
		if (res) {
			req.setAttribute("success", "Account updated successfully!");
			RequestDispatcher rd = req.getRequestDispatcher("profile.jsp");
			rd.forward(req, resp);
		} else {
			req.setAttribute("error", "Failed to update the account!");
			RequestDispatcher rd = req.getRequestDispatcher("profile.jsp");
			rd.forward(req, resp);
		}
	}
}
