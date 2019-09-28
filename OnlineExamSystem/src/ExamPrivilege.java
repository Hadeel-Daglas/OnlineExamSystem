import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbconnection.*;

/**
 * Servlet implementation class ExamPrivilege
 */
@WebServlet("/ExamPrivilege")
public class ExamPrivilege extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExamPrivilege() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		String examID = session.getAttribute("examID").toString();
		try {
			Connection connection = DBConnection.getConnection();
			//subinterface of Statement used to execute query that has parameter
			PreparedStatement updatePrivilege = connection.prepareStatement("Update Privilege set flag = ? where UserID = ? and ExamID = ?");
			PreparedStatement deleteGrade = connection.prepareStatement("delete from Grade where StudentID = ? and ExamID = ?");
			String userID = null;
		    // for input type checkbox its name is privilege to get the checked values
			/*getting multiple values for any input parameter, this method will retrieve all of it values 
			  and store as string array.*/
			String[] checked = request.getParameterValues("privilege");
			//
			for(int i = 0; i < checked.length; i++) {
				//change the flag to 1 according to user ID and delete the grade of the user ID on specific exam
				userID = checked[i];
				//set parameter value by calling setter method 
				updatePrivilege.setInt(1, 1);
				updatePrivilege.setString(2, userID);
				updatePrivilege.setString(3, examID);
				updatePrivilege.execute();
				deleteGrade.setString(1, userID);
				deleteGrade.setString(2, examID);
				//execute is a method of Statement Interface because it may return multiple results
				deleteGrade.execute();
			}
		} catch (Exception e) {
			
			out.println("Error in ExamPrivilege Servlet " + e.getMessage());
		}
		response.sendRedirect("examprivilege.jsp");
	}

}
