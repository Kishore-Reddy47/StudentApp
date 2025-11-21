package in.ps.studentapp.admin;

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

public class Admin {
	public static void admin(Student s) {
		StudentDAO sdao = new StudentDAOImpl();
		CoursesDAO cdao = new CoursesDAOImpl();
		PaymentsDAO pdao = new PaymentDAOImpl();
		Scanner sc = new Scanner(System.in);
		int choice = 0;
		do {
			System.out.println("1. View All users");
			System.out.println("2. Delete User");
			System.out.println("3. Add Course");
			System.out.println("4. Update Course");
			System.out.println("5. Delete Course");
			System.out.println("6. View Payments");
			System.out.println("7. Approve Payments");
			System.out.println("8. Exit");

			choice = sc.nextInt();
			switch (choice) {
			case 1:
				ArrayList<Student> students = sdao.getStudent();
				for (Student st : students) {
					System.out.println(st);
				}
				break;

			case 2:
				System.out.println("Enter the Id to be deleted:");
				// int id=sc.nextInt();
				boolean result = sdao.deleteStudent(sc.nextInt());
				if (result) {
					System.out.println("Account deleted successfully");
				} else {
					System.out.println("Failed to delete the account!");
				}
				break;

			case 3:
				Courses c = new Courses();
				System.out.println("Enter the name of the course");
				sc.nextLine(); // issues happen while using both sc.next() and sc.nextLine()
				c.setCourseName(sc.nextLine());
				System.out.println("Enter the Course information:");
				c.setCourseInfo(sc.nextLine());
				System.out.println("Enter the duration (in months):");
				c.setMonths(sc.nextInt());
				System.out.println("Enter the Fees:");
				c.setFees(sc.nextDouble());
				boolean res = cdao.insertCourse(c);
				if (res) {
					System.out.println("Course Added");
				} else {
					System.out.println("Failed to add course");
				}
				break;

			case 4:
				CourseInfo.update();
				break;

			case 5:
				CourseInfo.delete();
				break;

			case 6:
				ArrayList<Payment> payments = pdao.getPayment();
				for (Payment p : payments) {
					System.out.println(p);
				}
				break;

			case 7:
				ArrayList<Payment> payment = pdao.getPayment();
				for (Payment p : payment) {
					System.out.println(p);
				}
				System.out.println("Enter the payment Id to be updated:");
				Payment p = pdao.getPayment(sc.nextInt());
				System.out.println("1. Approve");
				System.out.println("2. Decline");
				int i = sc.nextInt();
				if (i == 1) {
					p.setStatus("successful");
				} else if (i == 2) {
					p.setStatus("failed");
				} else {
					System.out.println("Invalid response");
				}
				boolean results = pdao.updatePayment(p);
				if (results) {
					System.out.println("Payment status updated!");
				} else {
					System.out.println("Failed to update the payment status");
				}

			case 8:
				System.out.println("Going back to main menu>>>");
				break;

			default:
				System.out.println("Invalid choice! Try again");
			}
		} while (choice != 8);
	}
}