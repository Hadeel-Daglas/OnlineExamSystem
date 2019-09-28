import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbconnection.*;

import java.sql.*;
import java.util.*;


@WebServlet("/StartExam")
public class StartExam extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public StartExam(){
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		   
		   HttpSession session = request.getSession();

		   QuestionClass objQ = new QuestionClass();
		   int index = 0;
           List <QuestionClass> questionsList = new ArrayList<QuestionClass>();

           Connection con = null;
           try{
        	   //establishes a connection to a database
        	   con = DBConnection.getConnection();
        	   
        	   //select examID from privilege according to userID and flag must be 1
        	   Statement statement1 = con.createStatement();
        	   //select exam name from exams according to exam ID
        	   Statement statement2 = con.createStatement();
        	   //select random questions from questions according to question number specified from Instructor exam upload 
        	   Statement statement3 = con.createStatement();
        	   //select answers orderd randomly according to question ID
        	   Statement statement4 = con.createStatement();
        	   //select number of questions from exams table
        	   Statement statement5 = con.createStatement();
        	   //Java object that contains the results of executing an SQL query usually used with Statement
        	   ResultSet getExamName = null;
        	   ResultSet resultset = null;
        	   ResultSet getQuestions = null;
        	   ResultSet getAnswers = null;
        	   ResultSet getnumberOfQuestions = null;
        	   
        	   int examId = 0;
        	   int QuestionNum = 0;
        	   String userID = session.getAttribute("userID").toString();
        	   resultset = statement1.executeQuery("select ExamID from Privilege where UserID = " + userID + " and flag = 1 ;");
        	   
        	   if (resultset.next()){
        		   examId = resultset.getInt("ExamID");
        	   }
        	   request.getSession().setAttribute("examID", examId);
        	   int questionID = 0;
        	   String questionText = null;
        	   int answerID = 0;
        	   String answerText = null;
        	   int correctAnswer = 0;
        	   String examName = "";
        	   
        	   getExamName = statement2.executeQuery("Select ExamName from Exams where ExamID = " + examId);
        	   if(getExamName.next()) {
        		   examName = getExamName.getString("ExamName");
        	   }
        	   request.getSession().setAttribute("examName", examName);
        	   getnumberOfQuestions = statement5.executeQuery("select NumberOfQuestions from Exams where ExamID = " + examId);
        	   
        	   if (getnumberOfQuestions.next()){
        		   QuestionNum = getnumberOfQuestions.getInt("NumberOfQuestions");
        	   }
        	   
        	   getQuestions = statement3.executeQuery("select top "+ QuestionNum +" QuestionID, QuestionText from Questions where ExamID = " + examId + "Order by NEWID()");
        	   
        	   while(getQuestions.next()){
        		   QuestionClass objQuestion = new QuestionClass();
        		   objQuestion.setQuestionID(getQuestions.getInt("QuestionID"));
        		   objQuestion.setQuestionText(getQuestions.getString("QuestionText"));
        		   
        		   getAnswers = statement4.executeQuery("select AnswerID, AnswerText,correctAnswers from answers where QuestionId = " + objQuestion.getQuestionID() + "Order by NEWID()");
        		   
        		   List<AnswerClass> answersList = new ArrayList<AnswerClass>();
        		   
        		   while(getAnswers.next()){
        			   AnswerClass objAnswer = new AnswerClass();
        			   objAnswer.setAnswerID(getAnswers.getInt("AnswerID"));
        			   objAnswer.setAnswerText(getAnswers.getString("AnswerText"));
        			   objAnswer.setCorrectAnswer(getAnswers.getInt("correctAnswers"));
        			   answersList.add(objAnswer);
        		   }
        		   
        		   objQuestion.setAnswers(answersList);
        		   questionsList.add(objQuestion);
        		   objQ = questionsList.get(0);
               }
        	   //set the retreived questions and their answers from database in QList and store the list in session
        	   request.getSession().setAttribute("QList", questionsList);
           }
           catch(Exception e){
        	   e.printStackTrace();
           }
           //redirect the Student user to exam page to do his/her exam
           response.sendRedirect("exampage.jsp");
	}

}