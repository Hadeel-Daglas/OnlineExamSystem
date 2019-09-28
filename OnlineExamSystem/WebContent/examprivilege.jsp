<%@ page import="dbconnection.*"%>
<%@ page import="java.sql.*"%>

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
	Statement selectPrivilege = connection.createStatement();
	String examID = session.getAttribute("examID").toString();
	//to allow student to retest by change the flag from 0 to 1
	ResultSet selectPrivileges = selectPrivilege
			.executeQuery("Select UserID, flag from Privilege where flag = 0 and ExamID = " + examID);
	Statement selectStudentName = connection.createStatement();
	ResultSet studentName = null;
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Change Privilege</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="navbarstyle.css">
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
      <label><%=session.getAttribute("userName")%></label>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

	<div class="sidenav">
		<a href="instructorhomepage.jsp" class="active">Home</a> 
		<a href="uploadexam.jsp">Upload Exam</a> 
		<a href="instructorgrades.jsp">StudentsGrade</a> 
		<a href="examprivilege.jsp">Exam Privilege</a>
	</div>

	<div class="content1">
		<label>Exam Privilege</label>
	</div>
	<form action="ExamPrivilege" method="post">
		<div class="col-md-7 content">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Student ID</th>
						<th scope="col">Student Name</th>
						<th scope="col">Privilege</th>
					</tr>
				</thead>
				<tbody>
					<%
						int count = 0;
						while (selectPrivileges.next()) {
					%>
					<tr>
						<th scope="row"><%= ++count%></th>
						<td><%= selectPrivileges.getInt("UserID") %></td>
						<%
							int userID = selectPrivileges.getInt("UserID");
								studentName = selectStudentName.executeQuery("Select UserName from Users where UserID = " + userID);
								while (studentName.next()) {
						%>
						<td><%=studentName.getString("UserName")%></td>
						<%
							}
								String check = "";
								int flag = selectPrivileges.getInt("flag");
								if (flag == 1) {
									check = "checked";
								} else {
									check = "";
								}
						%>
						<td><input type="checkbox" value="<%=userID%>"
							name="privilege" style="text-align: center;" <%=check%>></td>
					</tr>
					<%}%>
				</tbody>
			</table>
			<input id="startBtn" type="submit" class="btn btn-primary"
				style="float: right;" value="Save">
		</div>
	</form>
</body>
</html>