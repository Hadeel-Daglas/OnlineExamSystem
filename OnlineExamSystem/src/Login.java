import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbconnection.*;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//method takes a string parameter and does not return anything (returns void).
		//Sets the content type of the response being sent to the client
		response.setContentType("");
		//send character text to the client
		PrintWriter out = response.getWriter();
		
		//get the input data from user name and password field 
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		
		//create object from UsersClass
		UsersClass users = new UsersClass();
		
		//set username and password data that get from the input field
		users.setUserName(userName);
		users.setUserPassword(password);
		
		//create object from Authentication class
		Authentication authenticate = new Authentication();
		
		try{
			String validate = authenticate.authenticateUser(users);
			
			if(validate.equals("Admin")){
				//Returns the current session associated with this request, or if the request does not have a session, creates one.
				HttpSession session = request.getSession();
				//create new session and set user attribute
				session.setAttribute("userName", userName);
				session.setAttribute("password", password);
				session.setAttribute("role", "1");
				session.setAttribute("examID", users.getExamID());
				session.setAttribute("examName", users.getExamName());
				session.setAttribute("userID", users.getUserID());
				
				//interface provides the facility of dispatching the request to another resource it may be html, servlet or jsp.
				request.getRequestDispatcher("instructorhomepage.jsp").forward(request, response);
			}
			
			else if(validate.equals("Student")){
				HttpSession session = request.getSession();
				session.setAttribute("userName", userName);
				session.setAttribute("password", password);
				session.setAttribute("role", "2");
				session.setAttribute("examID", users.getExamID());
				session.setAttribute("examName", users.getExamName());
				session.setAttribute("userID", users.getUserID());
				
				//forward method is used for server side redirection, where an HTTP request for one servlet is routed to another resource (Servlet, JSP file or HTML file) for processing.
				request.getRequestDispatcher("studenthomepage.jsp").forward(request, response);
			}
			else{
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/homepage.jsp");
				
				//alert message display to the user if the username or password is incorrect
				out.println("<div class=\"alert alert-danger alert-dismissible\">" + 
						"  <a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>" + 
						"  <strong>Username or Password is incorrect!</strong>" + 
						"</div>");
				
				//include method is used to load the contents of the specified resource directly into the Servlet's response
				requestDispatcher.include(request, response);
			}
		}
		
		catch(Exception e)
		{
			out.println(e);
		}
	}

}
