<%@ page import="dbconnection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	if (session.getAttribute("userName") == null) {
		response.sendRedirect("homepage.jsp");
	} else {
		String Role = (String) session.getAttribute("role");
		if (Role.equals("2")) {
			response.sendRedirect("studenthomepage.jsp");
		}
	}

	Connection connection = DBConnection.getConnection();
	Statement selectGrade = connection.createStatement();
	String examID = session.getAttribute("examID").toString();
	//select Student ID and Grade from Grades according to Exam ID
	ResultSet selectGrades = selectGrade
			.executeQuery("Select StudentID, Grade from Grades where ExamID = " + examID);
	Statement selectStudentName = connection.createStatement();
	ResultSet studentName = null;
	List<Grades> grades = new ArrayList<Grades>();
%>

<%@ page language="java" contentType="text/html; charset = ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Grades</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale = 1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="navbarstyle.css">
</head>
<body>
	<nav class="navbar">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span>
				</button>
				<label><%=session.getAttribute("userName")%></label>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="logout.jsp">
					<span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="sidenav">
		<a href="instructorhomepage.jsp" class="active">Home</a> 
		<a href="uploadexam.jsp">Upload Exam</a> 
		<a href="instructorgrades.jsp">Students Grade</a>
		<a href="examprivilege.jsp">Exam Privilege</a>
	</div>

	<div class="content1">
		<label>Students Grades</label>
	</div>
	<form method="post" action="report.jsp">
		<div class="col-md-7 content">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Student ID</th>
						<th scope="col">Student Name</th>
						<th scope="col">Grade</th>
					</tr>
				</thead>
				<tbody>
					<%
						int count = 0;
						while (selectGrades.next()) {
							Grades grade = new Grades();
					%>
					<tr>
						<th scope="row"><%= ++count%></th>
						<td><%=selectGrades.getInt("StudentID")%></td>
						<%
							int userID = selectGrades.getInt("StudentID");
						    //select User Name from Users according to User ID
						    studentName = selectStudentName.executeQuery("Select UserName from Users where UserID = " + userID);
							while (studentName.next()) {
						%>
						<td><%=studentName.getString("UserName")%></td>
						<%
							grade.setStudentName(studentName.getString("UserName"));
						    }
						%>
						<td><%= selectGrades.getDouble("Grade") %></td>
					</tr>
					<%
						grade.setStudentID(selectGrades.getInt("StudentID"));
						grade.setGrade(selectGrades.getInt("Grade"));
						grades.add(grade);
						}
						//to store grades in grades list
						session.setAttribute("Grades", grades);
					%>
				</tbody>
			</table>
			<input type="submit" value="Extract to Excel" class="btn btn-primary"
				style="float: right;" />
		</div>
	</form>
</body>
</html>