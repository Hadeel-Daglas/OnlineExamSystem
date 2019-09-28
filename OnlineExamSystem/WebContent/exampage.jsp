<%@ page import="dbconnection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

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

	QuestionClass objQ = new QuestionClass();
	AnswerClass objAnswer = new AnswerClass();
	int index = 0;
	String[] answers;
	String checked;
	//to get the Qlist from start Exam(StartExam.java)
	List<QuestionClass> questionsList = (List<QuestionClass>) request.getSession().getAttribute("QList");
	List<AnswerClass> answersList = new ArrayList<AnswerClass>();

	if (questionsList != null && questionsList.size() > 0) {

		//hidden field that has the index of the questionsList
		String x = request.getParameter("to");
		//index equal 0 .. get the question in index 0
		if (x == null) {
            
			objQ = questionsList.get(0);
			index = 0;
			//set the value of index in hidden value
			request.setAttribute("value", index);
		} else {
            //get the value of index that store in hidden field 
			index = Integer.parseInt(request.getParameter("to"));
            //get the checked radio button value by name
			String answer = request.getParameter("answer");

			//check if there is a checked radio button
			if (answer != null) {
                //get the answers of the question according to the index
				for (int i = 0; i < questionsList.get(index).getAnswers().size(); i++) {

					//get answer ID of selected option then set checked to this radio button
					if (questionsList.get(index).getAnswers().get(i).getAnswerID() == Integer
							.parseInt(answer)) {

						questionsList.get(index).getAnswers().get(i).setIsChecked(true);

						//check if the selected radio button is true or false && checked if it is the correct answer
						//if the condition true set result = true else set result = false
						if (questionsList.get(index).getAnswers().get(i).getIsChecked() == true
								&& questionsList.get(index).getAnswers().get(i).getCorrectAnswer() == 1) {
							questionsList.get(index).setResult(true);
						} else {
							questionsList.get(index).setResult(false);
						}
						//set the other radio buttons not checked
					} else {

						questionsList.get(index).getAnswers().get(i).setIsChecked(false);
					}
				}
                //store the QList in session with checked answers
				request.getSession().setAttribute("QList", questionsList);
			}

			//if next button pressed then increse the index by 1 
			//and get the question of this index and store the new value in hidden field
			if (request.getParameter("Next") != null) {

				index = index + 1;
				objQ = questionsList.get(index);
				request.setAttribute("value", index);
				//if previous button pressed then decrese the index by 1 
				//and get the question of this index and store the new value in hidden field
			} else if (request.getParameter("Previous") != null) {

				index = index - 1;
				objQ = questionsList.get(index);
				request.setAttribute("value", index);
				
				//if finish button pressed set 0 to the index and redirect to the result page
			} else if (request.getParameter("Finish") != null) {

				index = 0;
				objQ = questionsList.get(index);
				request.setAttribute("value", index);
				response.sendRedirect("result.jsp");
			}
		}
	}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href = "exampage.css" rel = "stylesheet">
<link href = "navbarstyle.css" rel = "stylesheet">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Exam Page</title>
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
      <label style="margin-left:100px;"><%=session.getAttribute("examName")%> Exam</label>
    </div>
  </div>
</nav>

	<div class="sidenav" style = "margin-top:0;"></div>

	<form name="#" method="post" autocomplete="off">
		<div class="container">
			<div class="row" style = "margin-left: 350px;">
				<div class="col-md-9">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">
							<!-- question text format numberOfQuestion ) index + 1 -->
								<label id="<%=objQ.getQuestionID()%>"><%=(index + 1) + " ) "%><%=objQ.getQuestionText()%></label>
								<!-- hidden field to store the index value -->
								<input type="hidden" name="to" value="${value}"> 
								<input type="hidden" name="QID" value="<%=objQ.getQuestionID()%>">
							</h3>
						</div>
						<div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
									<div class="radio">
										<input type="radio" name="answer"
											value="<%=objQ.getAnswers().get(0).getAnswerID()%>"
											<%=objQ.getAnswers().get(0).getIsChecked() ? "checked" : ""%>>
										<label for="0"><%=objQ.getAnswers().get(0).getAnswerText()%></label>
									</div>
								</li>
							</ul>
						</div>
						<div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
									<div class="radio">
										<input type="radio" name="answer"
											value="<%=objQ.getAnswers().get(1).getAnswerID()%>"
											<%=objQ.getAnswers().get(1).getIsChecked() ? "checked" : ""%>>
										<label for="1"><%=objQ.getAnswers().get(1).getAnswerText()%></label>
									</div>
								</li>
							</ul>
						</div>
						<div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
									<div class="radio">
										<input type="radio" name="answer"
											value="<%=objQ.getAnswers().get(2).getAnswerID()%>"
											<%=objQ.getAnswers().get(2).getIsChecked() ? "checked" : ""%>>
										<label for="2"><%=objQ.getAnswers().get(2).getAnswerText()%></label>
									</div>
								</li>
							</ul>
						</div>
						<div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
									<div class="radio">
										<input type="radio" name="answer"
											value="<%=objQ.getAnswers().get(3).getAnswerID()%>"
											<%=objQ.getAnswers().get(3).getIsChecked() ? "checked" : ""%>>
										<label for="3"><%=objQ.getAnswers().get(3).getAnswerText()%></label>
									</div>
								</li>
							</ul>
						</div>
						<%
						    // if the index equal the questionslist size - 1 enable the finish button 
						    //disable next button
							if (index == questionsList.size() - 1) {
						%>
						<input type="submit" name="Finish" id="FinishExam" value="Finish"
							class="btn btn-primary" style="float: right;">
						<%
							} else {
						%>
						<input type="submit" name="Next" value="Next" id="NextButton"
							class="btn btn-primary" style="float: right;">
						<%
							}
						%>
						<% 
						    //if the question is the first question enable next button and disable the previous button
							if (index == 0) {
						%>
						<input type="submit" name="Previous" value="Previous"
							id="PreviousButton" style="display: none">
						<%
							} else {
						%>
						<input type="submit" name="Previous" value="Previous"
							id="PreviousButton" class="btn btn-primary" style="float: left;">
						<%}%>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>