package in.ps.studentapp.admin;

import java.util.ArrayList;
import java.util.Scanner;
import in.ps.studentapp.dao.CoursesDAO;
import in.ps.studentapp.dao.CoursesDAOImpl;
import in.ps.studentapp.dto.Courses;

public class CourseInfo {
	static CoursesDAO cdao = new CoursesDAOImpl();
	static Scanner sc = new Scanner(System.in);

	public static Courses courseInfo() {
		ArrayList<Courses> courses = cdao.getCourses();
		for (Courses c : courses) {
			System.out.println(c);
		}
		System.out.println("Enter the course Id for further step:");
		Courses c = cdao.getCourses(sc.nextInt());
		return c;
	}

	public static void update() {
		Courses c = courseInfo();
		int choice = 0;
		do {
			System.out.println("Enter the field to be updated:");
			System.out.println("1. Course Name");
			System.out.println("2. Course Info");
			System.out.println("3. Course Duration");
			System.out.println("4. Fees");
			System.out.println("5. Exit");
			choice = sc.nextInt();

			switch (choice) {
			case 1:
				System.out.println("Enter the new name:");
				c.setCourseName(sc.nextLine());
				break;

			case 2:
				System.out.println("Enter the info");
				c.setCourseInfo(sc.nextLine());
				break;

			case 3:
				System.out.println("Enter the duration(in months)");
				c.setMonths(sc.nextInt());
				break;

			case 4:
				System.out.println("Enter the fees");
				c.setFees(sc.nextDouble());
				break;

			case 5:
				System.out.println("Back to admin menu");
				break;

			default:
				System.out.println("Invalid choice!");
			}
			boolean result = cdao.updateCourse(c);
			if (result) {
				System.out.println("Course updated successfully");
			} else {
				System.out.println("Failed to update the course");
			}
		} while (choice != 4);
	}

	public static void delete() {
		Courses c = courseInfo();
		boolean result = cdao.deleteCourse(c.getCourseId());
		if (result) {
			System.out.println("Course deleted successfully");
		} else {
			System.out.println("Failed to delete the course");
		}
	}
}