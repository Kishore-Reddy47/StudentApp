package in.ps.studentapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import in.ps.studentapp.connection.Connector;
import in.ps.studentapp.dto.Student;

public class StudentDAOImpl implements StudentDAO {
	private Connection con;

	public StudentDAOImpl() {
		this.con = Connector.requestConnection();
	}

	@Override
	public boolean insertStudent(Student s) {
		String query = "INSERT INTO STUDENT VALUES (0,?,?,?,?,SYSDATE())";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, s.getName());
			ps.setLong(2, s.getPhone());
			ps.setString(3, s.getMail());
			ps.setString(4, s.getPassword());
			i = ps.executeUpdate();
		} catch (SQLException e) {

			// TODO Auto-generated catch block e.printStackTrace();
		}
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean updateStudent(Student s) {
		String query = "UPDATE STUDENT SET NAME=?,PHONE=?,MAIL=?,PASSWORD=? WHERE ID=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, s.getName());
			ps.setLong(2, s.getPhone());
			ps.setString(3, s.getMail());
			ps.setString(4, s.getPassword());
			ps.setInt(5, s.getId());
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
	public boolean deleteStudent(int id) {
		String query = "DELETE FROM STUDENT WHERE ID=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);
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
	public Student getStudent(String mail, String password) {
		Student s = null;
		String query = "SELECT * FROM STUDENT WHERE MAIL=? AND PASSWORD=?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, mail);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				s = new Student();
				// int id=rs.getInt("id");
				// s.setId(id);
				s.setId(rs.getInt("id"));
				s.setName(rs.getString("name"));
				s.setPhone(rs.getLong("phone"));
				s.setMail(rs.getString("mail"));
				s.setPassword(rs.getString("password"));
				s.setDate(rs.getString("date"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return s;
	}

	@Override
	public Student getStudent(long phone, String mail) {
		Student s = null;
		String query = "SELECT * FROM STUDENT WHERE PHONE=? AND MAIL=?";

		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setLong(1, phone);
			ps.setString(2, mail);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				s = new Student();
				// int id=rs.getInt("id");
				// s.setId(id);
				s.setId(rs.getInt("id"));
				s.setName(rs.getString("name"));
				s.setPhone(rs.getLong("phone"));
				s.setMail(rs.getString("mail"));
				s.setPassword(rs.getString("password"));
				s.setDate(rs.getString("date"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return s;
	}

	@Override
	public ArrayList<Student> getStudent() {
		ArrayList<Student> students = new ArrayList<Student>();
		Student s = null;
		String query = "SELECT * FROM STUDENT";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				s = new Student();
				// int id=rs.getInt("id");
				// s.setId(id);
				s.setId(rs.getInt("id"));
				s.setName(rs.getString("name"));
				s.setPhone(rs.getLong("phone"));
				s.setMail(rs.getString("mail"));
				s.setPassword(rs.getString("password"));
				s.setDate(rs.getString("date"));
				students.add(s);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return students;
	}
}
