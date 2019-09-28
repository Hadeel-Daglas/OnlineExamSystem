<%
    // to check validate session
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    //if the user doesn't login --> redirect to homepage 
	if (session.getAttribute("userName") == null) {
		// interface can be used to redirect the response to another resource i.e. it may be a Servlet, 
		// JSP or HTML file. It works on the client side
		response.sendRedirect("homepage.jsp");
	} else {
		//return the role id from the authentication if the user his/her role id equal 2 it means student
		// redirect the user to the student home page
		String Role = (String) session.getAttribute("role");
		if (Role.equals("2")) {
			response.sendRedirect("studenthomepage.jsp");
		}
	}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <title>Instructor Home Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <link rel = "stylesheet" href = "navbarstyle.css">
  <link rel = "stylesheet" href = "user.css">
</head>

<body>
<!-- navigation bar in html5 -->
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
    <!-- side navigation bar contain the main response of the instructor -->
	<div class="sidenav">
		<a href="instructorhomepage.jsp" class="active">Home</a> 
		<a href="uploadexam.jsp">Upload Exam</a> 
		<a href="instructorgrades.jsp">Students Grade</a>
		<a href="examprivilege.jsp">Exam Privilege</a>
	</div>

	<p>Exam Portal - Instructor Home Page</p>
	<div class="user">
		<img src="/static/instructor.png">
	</div>
	<div class="userbox">
		<label>Name: <%=session.getAttribute("userName")%></label>
	</div>

</body>
</html>
