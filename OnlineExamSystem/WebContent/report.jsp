<%@ page import="dbconnection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Report</title>
</head>
<body>
	<table border="1">
		<thead>
			<tr>
				<th>#</th>
				<th>Student ID</th>
				<th>Student Name</th>
				<th>Grade</th>
			</tr>
		</thead>
		<tbody>
			<%
			    //set the content type of response to excel sheet
			    //using apache POI
				response.setContentType("application/vnd.ms-excel");
			    //content disposition: downloaded and saved excel file locally
			    //inline: can be displayed inside the Web page, or as the Web page
				response.setHeader("Content-Disposition", "inline; filename = grades.xls");
				int count = 0;
				List<Grades> grades = (ArrayList<Grades>) session.getAttribute("Grades");
				for (Grades grade : grades) {
			%>
			<tr>
				<th><%= ++count%></th>
				<td><%= grade.getStudentID()%></td>
				<td><%= grade.getStudentName()%></td>
				<td><%= grade.getGrade()%></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>