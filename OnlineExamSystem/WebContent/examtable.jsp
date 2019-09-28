<%@ page import="dbconnection.*"%>
<%@ page import="java.sql.*"%>

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

	Connection connection = DBConnection.getConnection();
	Statement selectPrivilege = connection.createStatement();
	String userID = session.getAttribute("userID").toString();
	//select the exam of the student that he/she has to do
	ResultSet selectPrivileges = selectPrivilege
			.executeQuery("Select ExamID, ExamName, flag from Privilege where flag = 1 and UserID = " + userID);
	Statement selectExamData = connection.createStatement();
	ResultSet examData = null;
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
<title>Exam Table</title>
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
	
	<div class="content1">
		<label>Exams Table</label>
	</div>
	<div class="col-md-7 content">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Exam Name</th>
					<th scope="col">Exam Date</th>
					<th scope="col">Exam Time</th>
				</tr>
			</thead>
			<tbody>
				<%
					int count = 0;
					while (selectPrivileges.next()) {
				%>
				<tr>
					<th scope="row"><%=++count%></th>
					<td><%=selectPrivileges.getString("ExamName")%></td>
					<%
						int examID = selectPrivileges.getInt("ExamID");
							examData = selectExamData
									.executeQuery("Select ExamDate, ExamStartTime from Exams where ExamID = " + examID);
							while (examData.next()) {
					%>
					<td><%=examData.getString("ExamDate")%></td>
					<td><%=examData.getString("ExamStartTime")%></td>
					<%
						}
					%>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>