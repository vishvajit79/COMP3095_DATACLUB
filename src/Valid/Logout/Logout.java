/* COMP3095 : Assignment 1
 * This servlet is used for session destroy when user logged out
 * 
 */
package Valid.Logout;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Logout() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();
		if(request.getParameter("logout").equals("true")){
			HttpSession session=request.getSession();  
            session.invalidate();  
            response.sendRedirect("login.jsp");
            pw.print("logout1");
		}else{
			pw.print("logout");
		}
	}

}
