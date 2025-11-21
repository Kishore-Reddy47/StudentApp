package in.ps.studentapp.test;

import java.util.ArrayList;
import java.util.Scanner;
import in.ps.studentapp.dao.CoursesDAO;
import in.ps.studentapp.dao.CoursesDAOImpl;
import in.ps.studentapp.dao.PaymentDAOImpl;
import in.ps.studentapp.dao.PaymentsDAO;
import in.ps.studentapp.dao.StudentDAO;
import in.ps.studentapp.dao.StudentDAOImpl;
import in.ps.studentapp.dto.Courses;
import in.ps.studentapp.dto.Payment;
import in.ps.studentapp.dto.Student;

public class App {
	public static void options(Student s) {
		StudentDAO sdao = new StudentDAOImpl();
		PaymentsDAO pdao = new PaymentDAOImpl();
		CoursesDAO cdao = new CoursesDAOImpl();
		Scanner sc = new Scanner(System.in);
		int choice = 0;
		System.out.println("G'day " + s.getName());
		do {
			ArrayList<Payment> payments = pdao.getPaymentByStudentId(s.getId());
			System.out.println("1. VIEW PURCHASED COURSE");
			System.out.println("2. ADD COURSES");
			System.out.println("3. VIEW ACCOUNT");
			System.out.println("4. UPDATE ACCOUNT");
			System.out.println("5. VIEW PAYMENTS AND STATUS");
			System.out.println("6. EXIT");
			choice = sc.nextInt();
			switch (choice) {
			case 1:
				if (payments == null || payments.isEmpty()) {
					System.out.println("No courses found");
				} else {
					for (Payment p : payments) {
						Courses c = cdao.getCourses(p.getCourseId());

						if (p.getStatus().equalsIgnoreCase("Pending")) {
							System.out.println("Cours Name : " + c.getCourseName());
							System.out.println("Status : " + p.getStatus());
							System.out.println("Course will be purchased once admin approves");
						} else {
							System.out.println(c);
						}
					}
				}
				break;
			case 2:
				AddCourse.addCourse(s);
				break;
			case 3:
				System.out.println(s);
				break;
			case 4:
				Update.update(s);
				break;
			case 5:
				for (Payment p : payments) {
					System.out.println(p);
				}
				break;

			}
		} while (choice != 6);
	}
}
