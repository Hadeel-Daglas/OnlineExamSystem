package dbconnection;

public class AnswerClass {
	
	private int answerID;
	private String answerText;
	private int correctAnswer;
	private boolean isChecked;
	
	public AnswerClass(){
		answerID = 0;
		answerText = "";
		correctAnswer = 0;
		isChecked = false;
	}
	
	public AnswerClass(int answerID, String answerText, int correctAnswer, boolean isChecked){
		this.answerID = answerID;
		this.answerText = answerText;
		this.correctAnswer = correctAnswer;
		this.isChecked = isChecked;
	}
	
	public void setAnswerID(int answerID){
		this.answerID = answerID;
	}
	
	public int getAnswerID(){
		return answerID;
	}
	
	public void setAnswerText(String answerText){
		this.answerText = answerText;
	}
	
	public String getAnswerText(){
		return answerText;
	}
	
	public void setCorrectAnswer(int correctAnswer){
		this.correctAnswer = correctAnswer;
	}
	
	public int getCorrectAnswer(){
		return correctAnswer;
	}
	
	public void setIsChecked(boolean isChecked){
		this.isChecked = isChecked;
	}
	
	public boolean getIsChecked(){
		return isChecked;
	}
	
	public String toString(){
		return ("AnswerID: " + this.getAnswerID()
				+ " AnswerText: " + this.getAnswerText()
				+ " CorrectAnswer: " + this.getCorrectAnswer());
	}

}
