<%@ page import="dbconnection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	if (session.getAttribute("userName") == null) {
		response.sendRedirect("homepage.jsp");
	} else {
		String Role = (String) session.getAttribute("role");
		if (Role.equals("1")) {
			response.sendRedirect("instructorhomepage.jsp");
		}
	}

	List<QuestionClass> questionsList = (List<QuestionClass>) request.getSession().getAttribute("QList");
	int countCorrect = 0, countWrong = 0;
	int totalMark = 0;
	double grade = 0;

	//count correct and wrong answers
	for (int i = 0; i < questionsList.size(); i++) {
		if (questionsList.get(i).isResult() == true) {
			countCorrect++;
		} else {
			countWrong++;
		}
	}

	Connection connection = DBConnection.getConnection();
	String userID = session.getAttribute("userID").toString();
	int examID = 0;
	String examName = "";
	Statement statement = connection.createStatement();
	Statement getExamID = connection.createStatement();
	ResultSet examIDresultSet = null;
	examIDresultSet = getExamID.executeQuery("Select ExamID, ExamName from Privilege where flag = 1 and UserID = " + userID);
	if(examIDresultSet.next()){
		examID = examIDresultSet.getInt("ExamID");
		examName = examIDresultSet.getString("ExamName");
	}
	//insert grade to grades table in database and update flag to 0 in privilege table
	PreparedStatement insertGrade = connection
			.prepareStatement("Insert into Grades (StudentID, ExamID, Grade) values(?,?,?)");
	PreparedStatement updatePrivilege = connection
			.prepareStatement("Update privilege set Flag = ? where UserID = ? and ExamID = ?");
	ResultSet resultSet = null;
	resultSet = statement.executeQuery("Select TotalMark from Exams where ExamID = " + examID);
	if (resultSet.next()) {
		totalMark = resultSet.getInt("TotalMark");
	}

	//calculating the grade 
	grade = (double) countCorrect / (double) questionsList.size() * (double) totalMark;
	//formatted to display the grade by 2 decimal
	String grades = String.format("%.2f", grade);
	insertGrade.setString(1, userID);
	insertGrade.setInt(2, examID);
	insertGrade.setString(3, grades);
	insertGrade.execute();
	updatePrivilege.setInt(1, 0);
	updatePrivilege.setString(2, userID);
	updatePrivilege.setInt(3, examID);
	updatePrivilege.execute();
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel = "stylesheet" href = "navbarstyle.css">
<title>Result Page</title>
</head>

<body>

	<nav class="navbar">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<label><%=session.getAttribute("userName")%></label>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="logout.jsp"><span
							class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="sidenav">
		<a href="studenthomepage.jsp" class="active">Home</a> 
		<a href="examtable.jsp">Exams Table</a> 
		<a href="studentgrade.jsp">Grades</a>
		<a href="startexam.jsp">Start Exam</a>
	</div>
	
	<form action="exampage.jsp" method="get">
	
		<%
		//if the grade greater than of equal the totalMark / 2 display pass photo
			if (grade >= (totalMark / 2)) {
		%>
		<div class="image">
			<img alt="pass" src="/static/pass.jpg" width="200px" height="300px">
		</div>
		<%
		//if the grade less than the totalMark / 2 display fail photo
			} else {
		%>
		<div class="image">
			<img alt="pass" src="/static/fail.jpg" width="200px" height="300px">
		</div>
		<%
			}
		%>
		<div class="box">
			<label>Your Result: <%=grades%> / <%=totalMark%></label><br /> 
			<label style="color: green;">Your Correct Answers: <%=countCorrect%></label><br />
			<label style="color: red;">Your Wrong Answers: <%=countWrong%></label>
		</div>
	</form>
</body>
</html>