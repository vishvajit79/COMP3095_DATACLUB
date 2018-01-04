package sql.query;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.Employee;
import utilities.DatabaseAccess;
import utilities.Validation;

/**
 * Servlet implementation class UpdateEntry
 */
@WebServlet("/UpdateEntry")
public class UpdateEntry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateEntry() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	private boolean updateReportComment(int reportid, String title, String comment, HttpServletRequest request, Statement query)
	{
		boolean isValid = false;
			try {
				query.executeUpdate("update `report_section` set comment = '" + comment + "' where title = '" + title + "' AND rep_id = " + reportid + "");
				isValid = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return isValid;
	}
	
	private boolean updateReportEval(int reportid, String title, String criteria_title, String eval, HttpServletRequest request, Statement query)
	{
		boolean isValid = false;
			try {
				int qry = query.executeUpdate("update `report_section` set eval = " + eval + " where title = '" + title + "' AND criteria_title = '" + criteria_title + "' AND rep_id = " + reportid + "");
				System.out.println("update `report_section` set eval = " + eval + " where title = '" + title + "' AND criteria_title = '" + criteria_title + "' AND rep_id = " + reportid + "");
				isValid = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return isValid;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Enumeration<String> params = request.getParameterNames(); 
			while(params.hasMoreElements()){
			 String paramName = params.nextElement();
			 System.out.println("Parameter Name - "+paramName+", Value - "+request.getParameter(paramName));
			}
			
			int rep_id = Integer.parseInt(request.getParameter("rep_id"));
			// connect with the database
			Connection myCon = DatabaseAccess.connectDataBase();
			response.setContentType("text/html");
			PrintWriter pw = response.getWriter();
			Statement query = myCon.createStatement();
			HttpSession session = request.getSession();

			// handles the request from create report form
			if (request.getParameter("reportUpdateBtn") != null) {
				
				String[] eval1 = request.getParameterValues("sec0_eval");
				String[] eval2 = request.getParameterValues("sec1_eval");
				String[] eval3 = request.getParameterValues("sec2_eval");
				String[] criteria = request.getParameterValues("criteria");
				String[] criteria_titals = request.getParameterValues("criteria_titals");
				String[] sec_0_criteria_tital = request.getParameterValues("sec_0_criteria_tital");
				String[] sec_1_criteria_tital = request.getParameterValues("sec_1_criteria_tital");
				String[] sec_2_criteria_tital = request.getParameterValues("sec_2_criteria_tital");
				
				String[] comments = {request.getParameter("commment0"), request.getParameter("commment1"), request.getParameter("commment2")};
				
				for(int i=0;i<criteria.length;i++){
					String section_title = criteria[i];
					String comment = comments[i];
					Boolean sec1_valid = updateReportComment(rep_id, section_title, comment, request, query);
					if(!sec1_valid) {
						System.out.println("Failed");
						request.setAttribute("section1Error", "Please enter at least one criteria for section I");
					}
					for(int j=0;j<sec_0_criteria_tital.length;j++){
						String criteria_title = sec_0_criteria_tital[j];
						String eval = eval1[j];	
						sec1_valid = updateReportEval(rep_id, section_title, criteria_title, eval, request, query);

						if(!sec1_valid) {
							System.out.println("Failed");
							request.setAttribute("section1Error", "Please enter at least one criteria for section I");
						}
					}
					for(int j=0;j<sec_1_criteria_tital.length;j++){
						String criteria_title = sec_1_criteria_tital[j];
						String eval = eval2[j];	
						sec1_valid = updateReportEval(rep_id, section_title, criteria_title, eval, request, query);

						if(!sec1_valid) {
							System.out.println("Failed");
							request.setAttribute("section1Error", "Please enter at least one criteria for section I");
						}
					}
					for(int j=0;j<sec_2_criteria_tital.length;j++){
						String criteria_title = sec_2_criteria_tital[j];
						String eval = eval3[j];	
						sec1_valid = updateReportEval(rep_id, section_title, criteria_title, eval, request, query);

						if(!sec1_valid) {
							System.out.println("Failed");
							request.setAttribute("section1Error", "Please enter at least one criteria for section I");
						}
					}
				}
				request.setAttribute("success", "Updation Successful");
				request.getRequestDispatcher("view_report.jsp").forward(request, response);
				
			}
						
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
