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
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel = "stylesheet" href = "navbarstyle.css">
<title>Upload Exam</title>
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
		<a href="instructorgrades.jsp">Students Grade</a> 
		<a href="examprivilege.jsp">Exam Privilege</a>
	</div>

	<div id="upload" class = "upload">
        <div class="container">
            <div id="upload-row" class="row justify-content-center align-items-center">
                <div id="upload-column" class="col-md-5 col-md-offset-3">
                    <div id="upload-box" class="col-md-12">
                        <form id="upload-form" class="form" action="UploadExam" method="post" enctype="multipart/form-data">
                            <h3 class="text-center text-info">Upload <%=session.getAttribute("examName")%> Exam</h3>
                            <div class="form-group">
                                <label for="ExamDate" class="text-info">Exam Date:</label><br>
                                <input type="date" name="examDate" id="examDate" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="ExamStartTime" class="text-info">Start Time:</label><br>
                                <input type="time" name="examStartTime" id="examStartTime" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="ExamEndTime" class="text-info">End Time:</label><br>
                                <input type="time" name="examEndTime" id="examEndTime" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="NumberOfQuestions" class="text-info">Number Of Questions:</label><br>
                                <input type="number" name="numberOfQuestions" id="numberOfQuestions" class="form-control" 
                                       min = "1" max = "100" required>
                            </div>
                            <div class="form-group">
                                <label for="TotalMarks" class="text-info">Total Marks:</label><br>
                                <input type="number" name="totalMarks" id="totalMarks" class="form-control" 
                                       min = "1" max = "100" required>
                            </div>
                            <div class="form-group">
                                <label for="UploadFile" class="text-info">Upload File:</label><br>
                                <input type="file" name="uploadFile" id="uploadFile" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <input type="submit" name="submit" class="btn btn-primary btn-md center-block" value="submit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>