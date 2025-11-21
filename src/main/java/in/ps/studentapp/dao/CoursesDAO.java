package in.ps.studentapp.dao;

import java.util.ArrayList;

import in.ps.studentapp.dto.Courses;

public interface CoursesDAO {
	public boolean insertCourse(Courses c);

	public boolean updateCourse(Courses c);

	public boolean deleteCourse(int CourseId);

	public Courses getCourses(int courseId);

	public ArrayList<Courses> getCourses();
}
