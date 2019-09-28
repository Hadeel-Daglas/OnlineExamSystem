package dbconnection;

public class Grades {

	private int studentID;
	private String studentName;
	private double grade;
	
	
	public Grades() {
		this.studentID = 0;
		this.studentName = "";
		this.grade = 0;
	}
	public Grades(int studentID, String studentName, double grade) {
		this.studentID = studentID;
		this.studentName = studentName;
		this.grade = grade;
	}
	public int getStudentID() {
		return studentID;
	}
	public void setStudentID(int studentID) {
		this.studentID = studentID;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "Grades [getStudentID()=" + getStudentID() + ", getStudentName()=" + getStudentName() + ", getGrade()="
				+ getGrade() + "]";
	}
	
	
}
