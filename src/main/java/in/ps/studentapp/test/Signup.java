package in.ps.studentapp.test;

import java.util.Scanner;
import in.ps.studentapp.dao.StudentDAO;
import in.ps.studentapp.dao.StudentDAOImpl;
import in.ps.studentapp.dto.Student;

public class Signup {
	public static void signup() {
		System.out.println("<==Student Signup page==>");
		// create object of POJO class
		Student s = new Student();
		// collecting data from the user
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter the name:");
		// String name=sc.next();
		// s.setName(name);
		s.setName(sc.next());
		System.out.println("Enter the Phone:");
		s.setPhone(sc.nextLong());
		System.out.println("Enter the mail:");
		s.setMail(sc.next());
		System.out.println("Set the new Password");
		String password = sc.next();
		System.out.println("Confirm the password");
		String confirmpassword = sc.next();
		if (password.equals(confirmpassword)) {
			s.setPassword(confirmpassword);
			// creating reference of StudentDAO
			StudentDAO sdao = new StudentDAOImpl();
			boolean result = sdao.insertStudent(s);
			if (result) {
				System.out.println("Data saved successfully!");
			} else {
				System.out.println("Failed to save the data");
			}
		} else {
			System.out.println("Password mismatch!");
		}
	}
}