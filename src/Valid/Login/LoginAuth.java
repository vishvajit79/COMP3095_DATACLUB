/* COMP3095 : Assignment 1
 * This servlet is used to check login authentication
 * 
 */

package Valid.Login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

import java.sql.*;

import utilities.DatabaseAccess;


@WebServlet("/LoginAuth")
public class LoginAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginAuth() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// connect with database
			Connection myCon =  DatabaseAccess.connectDataBase();
			response.setContentType("text/html");
			PrintWriter pw = response.getWriter();
			Statement query = myCon.createStatement();
			ResultSet myRs = query.executeQuery("select * from users");
			
			// checks for valid user name and password
			while(myRs.next()){
				if(request.getParameter("username").equals(myRs.getString("username")) && request.getParameter("pass").equals(myRs.getString("password"))){
					HttpSession session=request.getSession(); 
			        session.setAttribute("user",myRs.getString("username"));  
					response.sendRedirect("department.jsp");
				}else{
					pw.print("Sorry, username or password error!");  
				}
			}
					
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
