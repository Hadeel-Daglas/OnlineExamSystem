package dbconnection;

import java.util.*;

public class QuestionClass {
	
	private int questionID;
	private String questionText;
	private boolean result;
	private List<AnswerClass> Answers = new ArrayList<AnswerClass>(); 
	
	public QuestionClass(){
		this.questionID = 0;
		this.questionText = "";
		this.result = false;
		this.Answers = null;
	}
	
	public QuestionClass(int questionID, String questionText, boolean result, List<AnswerClass> Answers){
		this.questionID = questionID;
		this.questionText = questionText;
		this.result = result;
		this.Answers = Answers;
	}
	
	public void setQuestionID(int questionID){
		this.questionID = questionID;
	}
	
	public int getQuestionID(){
		return questionID;
	}
	
	public void setQuestionText(String questionText){
		this.questionText = questionText;
	}
	
	public String getQuestionText(){
		return questionText;
	}
	
	public List<AnswerClass> getAnswers(){
		return Answers;
	}
	
	public void setAnswers(List<AnswerClass> Answers){
		this.Answers = Answers;
	}
	
	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}
	
	public String toString(){
		return ("QuestionID: " + this.getQuestionID() 
				+ " QuestionText: " + this.getQuestionText()
				+ " Answers: " + this.getAnswers());
	}
}
