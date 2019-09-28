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
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Student Home Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel = "stylesheet" href = "navbarstyle.css">
<link rel = "stylesheet" href = "user.css">
</head>

<body>

<nav class="navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
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

	<p>Exam Portal - Student Home Page</p>
	<div class="user">
		<img src="/static/student.jpg">
	</div>
	<div class="userbox">
		<label>Name: <%=session.getAttribute("userName")%></label>
	</div>

</body>
</html>
