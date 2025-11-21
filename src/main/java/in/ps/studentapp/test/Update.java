package in.ps.studentapp.test;

import java.util.Scanner;

import in.ps.studentapp.dao.StudentDAO;
import in.ps.studentapp.dao.StudentDAOImpl;
import in.ps.studentapp.dto.Student;

public class Update {
	public static void update(Student s) {
		Scanner sc = new Scanner(System.in);
		StudentDAO sdao = new StudentDAOImpl();
		System.out.println("Update Account:");
		int choice3 = 0;
		do {
			System.out.println("1. Update Name");
			System.out.println("2. Update Email");
			System.out.println("3. Update Password");
			System.out.println("4. Update Phone");
			System.out.println("5. Upadate and Exit");
			System.out.println("Enter your choice:");
			choice3 = sc.nextInt();
			switch (choice3) {
			case 1:
				System.out.println("Enter new Name:");
				s.setName(sc.next());
				break;
			case 2:
				System.out.println("Enter new Email:");
				s.setMail(sc.next());
				break;
			case 3:
				System.out.println("Enter new Password:");
				s.setPassword(sc.next());
				break;
			case 4:
				System.out.println("Enter new Phone:");
				s.setPhone(sc.nextLong());
				break;
			case 5:
				boolean updated = sdao.updateStudent(s);
				if (updated) {
					System.out.println("Account Updated Successfully");
				} else {
					System.out.println("Failed to Update Account");
				}
				System.out.println("Exiting Account Update...");
				break;
			default:
				System.out.println("Invalid Choice. Please try again.");
				break;
			}
		} while (choice3 != 5);
	}

}
