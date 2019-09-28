<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="login.css" />
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href = "homepage.css" rel = "stylesheet" />
<meta charset="ISO-8859-1">
<title>Exams Portal</title>
</head>
<body>
<div class="row justify-content-end">
<p>Exam Portal</p>
</div>
<div class="container">
        <div id="login-row" class="row justify-content-end" style = "margin-right:25px;">
            <div id="login-column" class="col-md-5">
                <div class="box">
                    <div class="shape1"></div>
                    <div class="shape2"></div>
                    <div class="shape3"></div>
                    <div class="shape4"></div>
                    <div class="shape5"></div>
                    <div class="shape6"></div>
                    <div class="shape7"></div>
                    <div class="float">
                    <!-- login form where user fill his/her username and password -->
                        <form class="form" action="Login" method = "post">
                            <div class="form-group">
                                <label for="username" class="text-blue">Username:</label><br>
                                <input type="text" name="username" id="username" class="form-control" autocomplete = "off" required>
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-blue">Password:</label><br>
                                <input type="password" name="password" id="password" class="form-control" autocomplete = "off" required>
                            </div>
                            <div class="form-group">
                                <input type="submit" name="submit" class="btn btn-primary btn-md" value="submit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>