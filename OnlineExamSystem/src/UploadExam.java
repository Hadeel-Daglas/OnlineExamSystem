import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dbconnection.DBConnection;


@WebServlet("/UploadExam")
// to handle multipart/form-data requests and configure various upload settings
@MultipartConfig
public class UploadExam extends HttpServlet{
	private static final long serialVersionUID = 1L;
	static String[] file;
	//directory on the server side to store the uploaded file
	private final String UPLOAD_DIRECTORY = "C:\\temp";
	private String filePath, name, examDate, examStartTime, examEndTime; 
	private int numberOfQuestions, totalMarks; 

	public UploadExam(){
		super();
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html");
		response.getWriter();
		PrintWriter out = response.getWriter();
		
		//check the enctype is the multipart/form-data
		//Check that we have a file upload request
		//commons.fileUpload and commons IO (file Upload depends on IO)
		if(ServletFileUpload.isMultipartContent(request)){
			try{
				
				//file item is represent file or form that recieved within multipart/form-data post
				//commons.fileUpload 
				//ServletFileUpload is handles multiple files per single HTML client side
				/*DiskFileItemFactory is creates FileItem instances which keep their content either in memory, 
				for smaller items, or in a temporary file on disk, for larger items.*/
				//parseRequest to acquire a list of file items associated with a given HTML client side
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				for(FileItem item : multiparts){
					if(!item.isFormField()){
						//upload the file on the specified directory
						//name it means fileName 
						name = new File(item.getName()).getName();
						//String value that OS used to separate file path.
						item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
					}
					//get the fields of the form
					else{
						if(item.getFieldName().equals("examDate")){
							examDate = item.getString();
						}
						if(item.getFieldName().equals("examStartTime")){
							examStartTime = item.getString();
						}
						if(item.getFieldName().equals("examEndTime")){
							examEndTime = item.getString();
						}
						if(item.getFieldName().equals("numberOfQuestions")){
							numberOfQuestions = Integer.parseInt(item.getString());
						}
						if(item.getFieldName().equals("totalMarks")){
							totalMarks = Integer.parseInt(item.getString());
						}
					}
				}
				
				//specifies the file path
				filePath = UPLOAD_DIRECTORY + File.separator + name;
				
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/instructorhomepage.jsp");
				
				//display message when the upload file successfully done
				out.println("<div class=\"alert alert-success alert-dismissible\">" + 
						"  <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" + 
						"  <strong>Exam Uploaded Successfully!</strong>" + 
						"</div>");
				
				requestDispatcher.include(request, response);
			}
			
			catch(Exception e){
				out.println("File Upload Failed due to " + e);
			}
		}
		
		else{
			out.println("Sorry this Servlet only handles file upload request");
		}
		
		HttpSession session = request.getSession();
		String ExamId = session.getAttribute("examID").toString();
		String ExamName = session.getAttribute("examName").toString();

		//read the content of the file
		FileReader fr = new FileReader(filePath);
		BufferedReader br = new BufferedReader(fr);
		String line = null;
		
		int questionsNum;

		PreparedStatement psQuestions = null;
		PreparedStatement psAnswers = null;
		PreparedStatement psStudents = null;
		PreparedStatement questionRows = null;
		PreparedStatement answersRows = null;
		PreparedStatement updateExamsTable = null;
		Connection con = null;

		try {
			con = DBConnection.getConnection();
			psQuestions = con.prepareStatement("Insert into Questions values (?,?,?)");
			psAnswers = con.prepareStatement("Insert into Answers values (?,?,?,?)");
			psStudents = con.prepareStatement("Insert into privilege values(?,?,?,?)");
			questionRows = con.prepareStatement("Select count(*) from Questions");
			answersRows = con.prepareStatement("Select count(*) from Answers");
			updateExamsTable = con.prepareStatement("Update Exams set ExamDate = ?, "
					+ "ExamStartTime = ?, ExamEndTime = ?, NumberOfQuestions = ?, "
					+ "TotalMark = ? Where ExamID = " + ExamId);
			updateExamsTable.setString(1, examDate);
			updateExamsTable.setString(2, examStartTime);
			updateExamsTable.setString(3, examEndTime);
			updateExamsTable.setInt(4, numberOfQuestions);
			updateExamsTable.setInt(5, totalMarks);
			updateExamsTable.execute();

			//split the file 
			//split method breaks a given string around matches of the given regular expression(comma)
			while (((line = br.readLine()) != null)){
				file = line.split(",");
			}
			
			//start Question ID from 1 for the first insertion of questions
			int QID = 1;
			//start Answer ID from 1 for the first insertion of answers
			int AID = 1;
			//the last question Max ID from Questions
			int QmaxID = 1;
			//get the exam ID from session
			int EmaxID = Integer.parseInt(ExamId);
			//the last question Max ID from Questions
			int AmaxID = 1;
			//get the number of questions from the first index of file[]
			questionsNum = Integer.parseInt(file[0]);
			//get the index of the number of student 
			int studentsNumIndex = (questionsNum * 5) + 1;
			//get the ID of the first student
			int firstIndexOfStudentId = studentsNumIndex + 1;
			//get the number of students
			int students = Integer.parseInt(file[studentsNumIndex]);

			//number of Questions Rows
			ResultSet rowsSet = questionRows.executeQuery();
			int rows = 0;
			if (rowsSet.next()){
				// index 1 is the "question ID" column
				rows = rowsSet.getInt(1);
			}

			if (rows == 0){
				QID = 1;
			} 
			else{
				//select the max Question ID from Questions
				String maxIdQueury = "Select max (QuestionID) as MaxId from questions;";
				Statement statement = con.createStatement();
				ResultSet resultset = statement.executeQuery(maxIdQueury);
				
				if (resultset.next()){
					QmaxID = resultset.getInt("MaxId");
					//add 1 to the question Max ID to add after the last index in questions table
					QID = QmaxID + 1;
				}
			}
			
			//number of Answers Rows
			ResultSet rowsSetOfAnswers = answersRows.executeQuery();
			int rowsOfAnswers = 0;
			
			if (rowsSetOfAnswers.next()){
				rowsOfAnswers = rowsSetOfAnswers.getInt(1);
			}

			if (rowsOfAnswers == 0){
				AID = 1;
			} 
			else{
				//select the max Question ID from Questions
				String maxIdQueury = "Select max (AnswerID) as MaxId from Answers;";
				Statement statement = con.createStatement();
				ResultSet resultset = statement.executeQuery(maxIdQueury);
				if (resultset.next()){
					AmaxID = resultset.getInt("MaxId");
					//add 1 to the question Max ID to add after the last index in questions table
					AID = AmaxID + 1;
				}
			}

			questionsNum = Integer.parseInt(file[0]);
			//get the questions and answers from file[]
			for (int i = 1; i <= questionsNum * 5; i++){
				//get the question Text then insert into Questions Table in database
				if (i % 5 == 1){
					psQuestions.setInt(1, QID);
					psQuestions.setString(2, file[i]);
					psQuestions.setInt(3, EmaxID);
					psQuestions.execute();
					QID++;
					String maxIdQueury = "Select max (QuestionID) as MaxId from questions;";
					Statement statement = con.createStatement();
					ResultSet resultset = statement.executeQuery(maxIdQueury);
					if (resultset.next()){
						QmaxID = resultset.getInt("MaxId");
					}
				}

				else{
					//get the correct answer of the question then insert into Answers Table in Database
					if (i % 5 == 2){
						psAnswers.setInt(1, AID);
						psAnswers.setString(2, file[i]);
						psAnswers.setInt(3, 1);
						psAnswers.setInt(4, QmaxID);
						AID++;
						psAnswers.execute();
					} 
					//get the wrong answers of the question then insert into Answers Table in Database
					else{
						psAnswers.setInt(1, AID);
						psAnswers.setString(2, file[i]);
						psAnswers.setInt(3, 0);
						psAnswers.setInt(4, QmaxID);
						AID++;
						psAnswers.execute();
					}
				}
			}

			//insert the student ID in Privilege Table in database
			for (int i = 0; i < students; i++){
				psStudents.setInt(1, Integer.parseInt(file[firstIndexOfStudentId]));
				psStudents.setInt(2, EmaxID);
				psStudents.setInt(3, 1);
				psStudents.setString(4, ExamName);
				firstIndexOfStudentId++;
				psStudents.execute();
			}

		}

		catch (Exception e){
			out.println("Error " + e.getMessage());
		}

		finally{ 
			fr.close();
			try {
				con.close();
			} catch (SQLException e) {
				out.println("Error " + e.getMessage());
			}
		}
	}
}