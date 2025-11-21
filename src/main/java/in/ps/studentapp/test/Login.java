package in.ps.studentapp.test;

import java.util.Scanner;
import in.ps.studentapp.admin.Admin;
import in.ps.studentapp.dao.StudentDAO;
import in.ps.studentapp.dao.StudentDAOImpl;
import in.ps.studentapp.dto.Student;

public class Login {
	public static void login() {
		// To connect to DB
		StudentDAO sdao = new StudentDAOImpl();
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter the mail:");
		String mail = sc.next();
		System.out.println("Enter the password:");
		String password = sc.next();
		Student s = sdao.getStudent(mail, password);

		if (s != null) {
			System.out.println("Login successful");
			if (s.getId() == 1) {
				Admin.admin(s); // admin
			} else {
				App.options(s); // normal user
			}
		} else {
			System.out.println("Failed to login");
		}
	}
}