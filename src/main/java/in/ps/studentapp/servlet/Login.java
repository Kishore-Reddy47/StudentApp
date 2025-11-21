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

@WebServlet("/login")
public class Login extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudentDAO sdao = new StudentDAOImpl();
		Student s = sdao.getStudent(req.getParameter("mail"), req.getParameter("password"));
		HttpSession session = req.getSession();
		if (s != null) {
			session.setAttribute("student", s);
			if (s.getId() == 1) {
				req.setAttribute("success", "Login successful! Welcome admin");
				RequestDispatcher rd = req.getRequestDispatcher("admin.jsp");
				rd.forward(req, resp);
			} else {
				req.setAttribute("success", "Login successful!");
				RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
				rd.forward(req, resp);
			}
		} else {
			req.setAttribute("error", "Failed to login!");

			RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
			rd.forward(req, resp);
		}
	}
}
