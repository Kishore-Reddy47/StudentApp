package in.ps.studentapp.test;

import java.util.Random;

public class TransactionID {
	public static long generateID() {
		Random rd = new Random();
		long val = rd.nextLong();

		long num = 0, ans = 0;
		if (val < 0) {
			val = val * -1;
		}
		while (num < 15) {
			long rem = val % 10;
			ans = ans * 10 + rem;
			val = val / 10;
			num += 1;
		}
		return ans;
	}
}