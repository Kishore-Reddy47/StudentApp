package in.ps.studentapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import in.ps.studentapp.connection.Connector;
import in.ps.studentapp.dto.Courses;

public class CoursesDAOImpl implements CoursesDAO {
	private Connection con;

	public CoursesDAOImpl() {
		this.con = Connector.requestConnection();
	}

	@Override
	public boolean insertCourse(Courses c) {
		String query = "INSERT INTO COURSES VALUES (0,?,?,?,?)";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, c.getCourseName());
			ps.setString(2, c.getCourseInfo());
			ps.setInt(3, c.getMonths());
			ps.setDouble(4, c.getFees());
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
	public boolean updateCourse(Courses c) {

		String query = "UPDATE COURSES SET CourseName=?,CourseInfo=?,Month=?,Fees=? WHERE CourseId=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, c.getCourseName());
			ps.setString(2, c.getCourseInfo());
			ps.setInt(3, c.getMonths());
			ps.setDouble(4, c.getFees());
			ps.setInt(5, c.getCourseId());
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
	public boolean deleteCourse(int CourseId) {
		String query = "DELETE FROM COURSES WHERE CourseId=?";
		int i = 0;
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, CourseId);
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

	public Courses getCourses(int courseId) {
		Courses c = null;
		String query = "SELECT * FROM COURSES WHERE COURSEID=?";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, courseId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				c = new Courses();
				c.setCourseId(rs.getInt("courseId"));
				c.setCourseName(rs.getString("courseName"));
				c.setCourseInfo(rs.getString("courseInfo"));
				c.setMonths(rs.getInt("month"));
				c.setFees(rs.getDouble("fees"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return c;
	}

	@Override
	public ArrayList<Courses> getCourses() {
		ArrayList<Courses> courses = new ArrayList<Courses>();
		Courses c = null;
		String query = "SELECT * FROM COURSES";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				c = new Courses();
				c.setCourseId(rs.getInt("courseId"));
				c.setCourseName(rs.getString("courseName"));
				c.setCourseInfo(rs.getString("courseInfo"));
				c.setMonths(rs.getInt("month"));
				c.setFees(rs.getDouble("fees"));
				courses.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return courses;
	}
}
