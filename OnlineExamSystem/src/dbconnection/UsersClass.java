package dbconnection;

public class UsersClass{	
	private int userID;
	private String userName;
	private String userPassword;
	private int userRole;
	private int examID;
	private String examName;
	
	public UsersClass(){
		this.userID = 0;
		this.userName = "";
		this.userPassword = "";
		this.userRole = 0;
		this.examID = 0;
		this.examName = "";
	}
	
	public void setUserID(int userID){
		this.userID = userID;
	}
	
	public int getUserID(){
		return userID;
	}
	
	public void setUserName(String userName){
		this.userName = userName;
	}
	
	public String getUserName(){
		return userName;
	}
	
	public void setUserPassword(String userPassword){
		this.userPassword = userPassword;
	}
	
	public String getUserPassword(){
		return userPassword;
	}
	
	public void setUserRole(int userRole){
		this.userRole = userRole;
	}
	
	public int getUserRole(){
		return userRole;
	}
	
	public void setExamID(int examID){
		this.examID = examID;
	}
	
	public int getExamID(){
		return examID;
	}
	
	public void setExamName(String examName){
		this.examName = examName;
	}
	
	public String getExamName(){
		return examName;
	}
}
