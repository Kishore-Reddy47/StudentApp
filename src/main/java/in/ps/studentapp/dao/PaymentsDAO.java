package in.ps.studentapp.dao;

import java.util.ArrayList;

import in.ps.studentapp.dto.Payment;

public interface PaymentsDAO {
	public boolean insertPayment(Payment p);

	public boolean updatePayment(Payment p);

	public boolean deletePayment(int paymentId);

	public Payment getPayment(int paymentId);

	public ArrayList<Payment> getPaymentByStudentId(int studentId);

	public ArrayList<Payment> getPayment();

}
