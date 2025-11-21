package in.ps.studentapp.test;

import java.util.Scanner;
import in.ps.studentapp.dao.StudentDAO;
import in.ps.studentapp.dao.StudentDAOImpl;
import in.ps.studentapp.dto.Student;

public class Password {
	public static void forgot() {
		StudentDAO sdao = new StudentDAOImpl();
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter your phone number:");
		long phone = sc.nextLong();
		System.out.println("Enter the mail ID:");
		String mail = sc.next();
		Student s = sdao.getStudent(phone, mail);
		if (s != null) {
			System.out.println("Enter the password to be updated:");
			String password = sc.next();
			System.out.println("Confirm the password");
			String confirmPassword = sc.next();
			if (password.equals(confirmPassword)) {
				s.setPassword(confirmPassword);
				boolean result = sdao.updateStudent(s);
				if (result) {
					System.out.println("Password updated successfully!");
				} else {
					System.out.println("Failed to update the password");
				}
			} else {
				System.out.println("password mismatch!");
			}
		} else {
			System.out.println("Account doesnot exist");
		}
	}
}