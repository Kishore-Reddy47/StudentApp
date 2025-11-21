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

@WebServlet("/signup")
public class Signup extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Student s = new Student();
		StudentDAO sdao = new StudentDAOImpl();
		// String name=req.getParameter("name");
		// s.setName(name); 
		s.setName(req.getParameter("name"));
		// String s_phone=req.getParameter("phone");
		// long phone=Long.parseLong(s_phone);
		// s.setPhone(phone);
		s.setPhone(Long.parseLong(req.getParameter("phone")));
		s.setMail(req.getParameter("mail"));

		if (req.getParameter("password").equals(req.getParameter("confirm"))) {
			s.setPassword(req.getParameter("password"));
			boolean res = sdao.insertStudent(s);
			if (res) {
				req.setAttribute("success", "Signup successful");
				RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
				rd.forward(req, resp);
			} else {
				req.setAttribute("error", "Failed to signup");
				RequestDispatcher rd = req.getRequestDispatcher("signup.jsp");

				rd.forward(req, resp);
			}
		}
		req.setAttribute("error", "Password mismatch");
		RequestDispatcher rd = req.getRequestDispatcher("signup.jsp");
		rd.forward(req, resp);
	}
}
