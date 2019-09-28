<%@ page import="dbconnection.*"%>
<%@ page import="java.sql.*"%>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>

<%
	if (session.getAttribute("userName") == null) {
		response.sendRedirect("homepage.jsp");
	} else {
		String Role = (String) session.getAttribute("role");
		//if the user his/her role ID equal 1 redirect to instructor home page
		if (Role.equals("1")) {
			response.sendRedirect("instructorhomepage.jsp");
		}
	}
%>

<%
	Connection con = DBConnection.getConnection();
    //select examID and exam name from privilege according to user ID and flag equal 1
	Statement statement = con.createStatement();
	ResultSet resultset = null;
	String userID = session.getAttribute("userID").toString();
	resultset = statement.executeQuery("select ExamID, ExamName from Privilege where UserID = " + userID + " and Flag = 1");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Start Exam</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <link rel = "stylesheet" href = "navbarstyle.css">
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
			<label style = "margin-top: 15px; margin-right: 25px;"><%=session.getAttribute("userName")%></label>
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
	
	<form action="StartExam" method="post">
		<div class="container-fluid text-center">
			<div class="row">
				<div class="col-sm-3 list">
				<!-- the start Exam button will be enable after the user choose the exam -->
					<select class="form-control" id = "examName" onChange = "Enable()">
						<option value = "" disabled selected>Choose Exam</option>
						<%
							while (resultset.next()) {
						%>
						<option value="<%=resultset.getInt("ExamID")%>"><%=resultset.getString("ExamName")%></option>
						<%}%>
					</select>
					<div style = "margin-top: 20px;">
					<button id="startBtn" type="submit" class="btn btn-primary mid-center" disabled="disabled">Start Exam</button>
					</div>
					</div>
				</div>
			</div>
	</form>
</body>
<!-- after the student choose exam name the start button will be enable -->
<script>
function Enable(){
	document.getElementById("startBtn").disabled=false;
	}
</script>
</html>
