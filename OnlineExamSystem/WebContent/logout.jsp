<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
	<form action = "Logout" method = "post">
		<%
		response.sendRedirect("homepage.jsp");
		%>
	</form>
</body>
</html>