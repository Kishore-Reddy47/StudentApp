package in.ps.studentapp.test;

import java.util.Scanner;

public class Test {
	public static void main(String[] args) {
		int choice = 0;
		Scanner sc = new Scanner(System.in);
		System.out.println("----Student Portal App----");
		do {
			System.out.println("1. SIGNUP");
			System.out.println("2. LOGIN");
			System.out.println("3. FORGOT PASSWORD?");
			System.out.println("4. EXIT");

			choice = sc.nextInt();
			switch (choice) {
			case 1:
				Signup.signup();
				break;
			case 2:
				Login.login();
				break;
			case 3:
				Password.forgot();
				break;
			case 4:
				System.out.println("Application terminated");
				break;
			default:
				System.out.println("Invalid choice, Try again");
				break;
			}

		} while (choice != 4);
	}
}