package in.ps.studentapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import in.ps.studentapp.connection.Connector;
import in.ps.studentapp.dto.Payment;

public class PaymentDAOImpl implements PaymentsDAO {
	private Connection con;

	public PaymentDAOImpl() {
		this.con = Connector.requestConnection();
	}

	@Override
	public boolean insertPayment(Payment p) {
		String query = "INSERT INTO PAYMENT VALUES(0,?,?,?,?,'Pending',?,sysdate())";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, p.getStudentId());
			ps.setInt(2, p.getCourseId());
			ps.setLong(3, p.getTransactionId());
			ps.setString(4, p.getMethod());
			ps.setString(5, p.getPath());
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override

	public boolean updatePayment(Payment p) {
		String query = "UPDATE PAYMENT SET STUDENTID=?,COURSEID=?,METHOD=?,STATUS=? WHERE PAYMENTID=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, p.getStudentId());
			ps.setInt(2, p.getCourseId());
			ps.setString(3, p.getMethod());
			ps.setString(4, p.getStatus());
			ps.setInt(5, p.getPaymentId());
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean deletePayment(int paymentId) {
		String query = "DELETE FROM PAYMENT WHERE PAYMENTID=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, paymentId);
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Payment getPayment(int paymentId) {

		Payment p = null;
		String query = "SELECT * FROM PAYMENT WHERE PAYMENTID=?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, paymentId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				p = new Payment();
				p.setPaymentId(rs.getInt("paymentId"));
				p.setStudentId(rs.getInt("studentId"));
				p.setCourseId(rs.getInt("CourseId"));
				p.setTransactionId(rs.getLong("transactionId"));
				p.setMethod(rs.getString("method"));
				p.setStatus(rs.getString("status"));
				p.setPath(rs.getString("path"));
				p.setPayment_date(rs.getString("date"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return p;
	}

	@Override
	public ArrayList<Payment> getPaymentByStudentId(int studentId) {
		ArrayList<Payment> payments = new ArrayList<>();
		Payment p = null;
		String query = "SELECT * FROM PAYMENT WHERE STUDENTID=?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, studentId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				p = new Payment();
				p.setPaymentId(rs.getInt("paymentId"));
				p.setStudentId(rs.getInt("studentId"));
				p.setCourseId(rs.getInt("CourseId"));
				p.setTransactionId(rs.getLong("transactionId"));
				p.setMethod(rs.getString("method"));
				p.setStatus(rs.getString("status"));
				p.setPath(rs.getString("path"));
				p.setPayment_date(rs.getString("date"));
				payments.add(p);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return payments;
	}

	@Override
	public ArrayList<Payment> getPayment() {
		ArrayList<Payment> payments = new ArrayList<>();
		Payment p = null;
		String query = "SELECT * FROM PAYMENT";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				p = new Payment();
				p.setPaymentId(rs.getInt("paymentId"));
				p.setStudentId(rs.getInt("studentId"));
				p.setCourseId(rs.getInt("CourseId"));
				p.setTransactionId(rs.getLong("transactionId"));
				p.setMethod(rs.getString("method"));
				p.setStatus(rs.getString("status"));
				p.setPath(rs.getString("path"));
				p.setPayment_date(rs.getString("date"));
				payments.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return payments;
	}
}
