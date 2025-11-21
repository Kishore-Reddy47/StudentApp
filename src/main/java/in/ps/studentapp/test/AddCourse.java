package in.ps.studentapp.test;

import java.util.Scanner;
import in.ps.studentapp.admin.CourseInfo;
import in.ps.studentapp.dao.PaymentDAOImpl;
import in.ps.studentapp.dao.PaymentsDAO;
import in.ps.studentapp.dto.Courses;
import in.ps.studentapp.dto.Payment;
import in.ps.studentapp.dto.Student;

public class AddCourse {
	public static void addCourse(Student s) {
		Scanner sc = new Scanner(System.in);
		PaymentsDAO pdao = new PaymentDAOImpl();
		Courses c = CourseInfo.courseInfo();
		boolean res = false;
		if (c != null) {
			System.out.println("Bill amount is Rs." + c.getFees() + "/-");
			Payment p = new Payment();
			p.setCourseId(c.getCourseId());
			p.setStudentId(s.getId());
			p.setTransactionId(TransactionID.generateID());
			System.out.println("Enter the payment mode:");
			System.out.println("1. Cash");
			System.out.println("2. UPI");
			System.out.println("3. Credit Card");
			System.out.println("4. Debit Card");
			int payment = 0;
			payment = sc.nextInt();
			switch (payment) {
			case 1:
				p.setMethod("Cash");
				break;
			case 2:
				p.setMethod("UPI");
				break;
			case 3:
				p.setMethod("Credit Card");
				break;
			case 4:
				p.setMethod("Debit Card");
				break;
			}
			p.setPath("NA");
			res = pdao.insertPayment(p);
			if (res) {
				System.out.println("Payment successful! Course added to your list");
			} else {
				System.out.println("Payment failed");
			}
		} else {
			System.out.println("Failed to opt the couse");
		}

	}
}