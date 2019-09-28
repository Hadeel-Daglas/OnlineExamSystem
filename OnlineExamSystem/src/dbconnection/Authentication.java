package dbconnection;

import java.sql.*;

public class Authentication {
	
	//method to check if the user exist or not depend on the user role
	public String authenticateUser(UsersClass users){
		
		String userName = users.getUserName();
		String userPassword = users.getUserPassword();
		
		//connect to database
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;
		
		//create instance variables and initialize them to the default value
		String username = "";
		String password = "";
		int roleID = 0;
		int userID = 0;
		int examID = 0;
		String examName = "";
		
		try{
			con = DBConnection.getConnection();
			//retrieve all fields in Users Table from database
			statement = con.createStatement();
			resultSet = statement.executeQuery("select * from Users");
			
			while(resultSet.next()){
				//get the fields from database form users table
				username = resultSet.getString("UserName");
				password = resultSet.getString("UserPassword");
				roleID = resultSet.getInt("UserRole");
				userID = resultSet.getInt("UserID");
				examID = resultSet.getInt("ExamID");
				examName = resultSet.getString("ExamName");
				
				//check if the user name and password that get from input field and that get from database
				//and check if the role id equal 1 set all data in users object then return Admin
				if(userName.equals(username) && userPassword.equals(password) && roleID == 1){
					users.setUserName(username);
					users.setUserPassword(userPassword);
					users.setUserRole(roleID);
					users.setUserID(userID);
					users.setExamID(examID);
					users.setExamName(examName);
					return "Admin";
				}
				//check if the user name and password that get from input field and that get from database
				//and check if the role id equal 2 set all data in users object then return Student
				else if(userName.equals(username) && userPassword.equals(password) && roleID == 2){
					users.setUserName(username);
					users.setUserPassword(userPassword);
					users.setUserRole(roleID);
					users.setUserID(userID);
					users.setExamID(examID);
					users.setExamName(examName);
					return "Student";
				}
			}
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		//if the user not exist
		return "Invalid User";
	}

}
