/* COMP3095 : Assignment 1
 * Servlet AddEntry is used to handle the all post requests
 * 
 */

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

@WebServlet("/AddEntry")
public class AddEntry extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String present = "0";

	public AddEntry() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	
	private boolean insertSection(String title, String criteria, String max, Integer templateId, HttpServletRequest request, Statement query)
	{
		boolean isValid = false;
		String[] criteriaArr = request.getParameterValues(criteria);
		String[] maxArr = request.getParameterValues(max);
		
		for(int j = 0; j < criteriaArr.length; j++)
		{
			String maxStr = maxArr[j];
			String criteriaStr = criteriaArr[j].trim();
			System.out.println(criteriaStr);
			if(!criteriaStr.equals("") && criteriaStr != null) {
				try {
					query.executeUpdate("insert into `report_template_section` values(null,'" + title + "','" + criteriaStr + "','" + maxStr + "','" + templateId +"')");
					isValid = true;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return isValid;
	}

	private boolean insertReportSection(String title, String criteria, String max, int templateId, String eval, String comment, HttpServletRequest request, Statement query)
	{
		boolean isValid = false;
			try {
				query.executeUpdate("insert into `report_section` values(null,'" + title + "','" + criteria + "','" + max + "','" + templateId + "','" + eval + "','" + comment + "')");
				isValid = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return isValid;
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// connect with the database
			Connection myCon = DatabaseAccess.connectDataBase();
			response.setContentType("text/html");
			PrintWriter pw = response.getWriter();
			Statement query = myCon.createStatement();
			HttpSession session = request.getSession();

			// handles the request from department form and adds attendance to the attendance table depending on the department
			if (request.getParameter("add_attendance") != null) {
				if (!Validation.checkDuplicateAttendnace((String) session.getAttribute("deptId"),
						request.getParameter("date"))) {
					query.executeQuery("select * from `employee` where deptId = " + session.getAttribute("deptId"));
					ResultSet rs = query.getResultSet();
					ArrayList<Employee> empList = new ArrayList<Employee>();

					while (rs.next()) {
						Employee empObj1 = new Employee(rs.getString("first_name"), rs.getString("last_name"),
								rs.getInt("employee_id"), rs.getInt("deptId"));
						empList.add(empObj1);
					}
					ArrayList<Employee> empList1 = (ArrayList<Employee>) empList;
					String[] results = request.getParameterValues("present");
					for (int i = 0; i < empList1.size(); i++) {
						for (int j = 0; j < results.length; j++) {
							if (Validation.checkboxSelected(Integer.valueOf(results[j].trim()), empList1.get(i).getEmployee_id())) {
								present = "1";
								break;
							}
							log(results[j].trim() + "------Value = " + String.valueOf(present));

						}
						query.executeUpdate("insert into `attendance` values(null,'" + session.getAttribute("deptId")
								+ "','" + empList1.get(i).getEmployee_id() + "','" + present + "','"
								+ request.getParameter("date") + "')");
						present = "0";

					}

					pw.println("Data Inserted Successfully");
					pw.println("You will be redirected to the page in a few seconds...");

					response.setHeader("Refresh", "5;url=add_attendance.jsp");
				} else {
					pw.println("Data not inserted due to duplicate policy\n");
					pw.println("You will be redirected to the page in a few seconds...");

					response.setHeader("Refresh", "5;url=add_attendance.jsp");
				}
			}
			
			// handles the request from create report template form
			if (request.getParameter("reportTemplate") != null) {
				
				int i = query.executeUpdate("insert into `report_template` values(null,'" + request.getParameter("reportTemplateName") + "','"
						+ request.getParameter("date") + "','" + request.getParameter("department") + "')");
				ResultSet resultId = query.executeQuery("select max(id) from `report_template`");
				int repTempId = 0;
				while(resultId.next()) {
					repTempId = resultId.getInt(1);
					System.out.println(repTempId);
				}
				if(i == 1) {
										
					String sec1_title = request.getParameter("section1").trim();
					String sec2_title = request.getParameter("section2").trim();
					String sec3_title = request.getParameter("section3").trim();
					
					if(Validation.checkDuplicateSection(sec1_title, sec2_title) || Validation.checkDuplicateSection(sec1_title, sec3_title) || Validation.checkDuplicateSection(sec2_title, sec3_title)) {
						request.setAttribute("templateError", "Please enter unique title for each section");
					}
					else {
						Boolean sec1_valid = insertSection(sec1_title, "sec1[criteria]", "sec1[max]", repTempId, request, query);
						if(!sec1_valid) {
							request.setAttribute("section1Error", "Please enter at least one criteria for section I");
						}
						
						Boolean sec2_valid = insertSection(sec2_title, "sec2[criteria]", "sec2[max]", repTempId, request, query);
						if(!sec2_valid) {
							request.setAttribute("section2Error", "Please enter at least one criteria for section II");
						}
						
						Boolean sec3_valid = insertSection(sec3_title, "sec3[criteria]", "sec3[max]", repTempId, request, query);
						if(!sec3_valid) {
							request.setAttribute("section3Error", "Please enter at least one criteria for section III");
						}
						
						if(sec1_valid && sec2_valid && sec3_valid) {
							request.setAttribute("templateSuccess", "Report Template is successfully created");
						}
					}
				}
				else {
					request.setAttribute("templateError", "Something is wrong! Please try again");
				}

				request.getRequestDispatcher("create_report_template.jsp").forward(request, response);
			}
			
			try {
				
				// handles the request from create report form
				if (request.getParameter("reportName") != null) {
					Enumeration<String> params = request.getParameterNames(); 
					while(params.hasMoreElements()){
					 String paramName = params.nextElement();
					 System.out.println("Parameter Name - "+paramName+", Value - "+request.getParameter(paramName));
					}
					
					String[] eval1 = request.getParameterValues("sec0_eval");
					String[] eval2 = request.getParameterValues("sec1_eval");
					String[] eval3 = request.getParameterValues("sec2_eval");
					int totalEvals = eval1.length + eval2.length + eval3.length;
					String[] evals = new String[totalEvals];
					int evalIndex = 0;
					for(int i = 0 ; i < eval1.length; i++ ) {
						System.out.println(eval1[i]);
						evals[evalIndex] = eval1[i];
						evalIndex++;
					}
					for(int i = 0 ; i < eval2.length; i++ ) {
						System.out.println(eval2[i]);
						evals[evalIndex] = eval2[i];
						evalIndex++;
					}
					for(int i = 0 ; i < eval3.length; i++ ) {
						System.out.println(eval3[i]);
						evals[evalIndex] = eval3[i];
						evalIndex++;
					}
	
					for(int i = 0 ; i < evals.length; i++ ) {
						System.out.println(evals[i]);
					}
					
					int i = query.executeUpdate("insert into `report` values(null,'" + request.getParameter("reportName") + "','"
							+ request.getParameter("date") + "','" + request.getParameter("department")  + "','" + request.getParameter("reportTemplate_id")  + "')");
					ResultSet resultId = query.executeQuery("select max(id) as max from `report`");
					int repTempId = 0;
					resultId.next();
					repTempId = Integer.parseInt(resultId.getString("max"));
						
					
					if(i == 1) {
						String title;
						String criteria_title;
						String criteria_max;
						String temp_id = request.getParameter("reportTemplate_id");
						String eval;
						String comment;
						String[] comments = {request.getParameter("commment0"), request.getParameter("commment1"), request.getParameter("commment2")};
						Statement qry = myCon.createStatement();
						qry.executeQuery("SELECT title FROM report_template_section where rep_temp_id =" + temp_id +" Group by title" );
						ResultSet secSet = qry.getResultSet ();
						int z = 0;
						int x=0;
						while (secSet.next()) {
							title = secSet.getString("title");
							comment = comments[z];
							Statement query1 = myCon.createStatement();
							query1.executeQuery("SELECT * FROM report_template_section where title ='" + title +"' AND rep_temp_id = " + temp_id + "" );
							ResultSet secSet1 = query1.getResultSet ();
							
							 while (secSet1.next()) {
								 criteria_title = secSet1.getString("criteria_title");
								 criteria_max = secSet1.getString("criteria_max");
								 eval = evals[x];
								 Boolean sec1_valid = insertReportSection(title, criteria_title, criteria_max, repTempId, eval, comment, request, query);
								if(!sec1_valid) {
									request.setAttribute("section1Error", "Please enter at least one criteria for section I");
								}
								x++;
							 }
							 z++;
						}
						request.setAttribute("reportSuccess", "Report is successfully inserted");
						request.getRequestDispatcher("view_report.jsp").forward(request, response);
						}
					}
				}catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("reportError", "Report name is already exists. Please enter different report name");
				request.getRequestDispatcher("enter_report.jsp").forward(request, response);
			}
			
			// handles the request from department form
			if (request.getParameter("dept") != null) {
				query.executeUpdate("insert into `DEPARTMENT` values(null,'" + request.getParameter("depName") + "','"
						+ request.getParameter("depLocation") + "')");
				pw.println("Data Inserted Successfully");
				pw.println("You will be redirected to the home page in a few seconds...");

				response.setHeader("Refresh", "5;url=department.jsp");
			}
			// handles the request from employee entry form
			else if (request.getParameter("employee") != null) {

				query.executeUpdate("insert into `employee` values(null,'" + request.getParameter("firstname") + "','"
						+ request.getParameter("lastname") + "','" + request.getParameter("employeeid") + "','"
						+ request.getParameter("email") + "','" + request.getParameter("hyear") + "','"
						+ request.getParameter("pos") + "','" + request.getParameter("department") + "')");
				pw.println("Data Inserted Successfully");
				pw.println("You will be redirected to the home page in a few seconds...");

				response.setHeader("Refresh", "5;url=department.jsp");

			}
			// handles the request from group entry form
			else if (request.getParameter("group") != null) {
				String grpName = request.getParameter("groupName");
				String error;
				String[] empArray = { request.getParameter("emp1"), request.getParameter("emp2"),
						request.getParameter("emp3"), request.getParameter("emp4"), request.getParameter("emp5"),
						request.getParameter("emp6") };

				// checks duplication of employee in a single group
				if (Validation.checkDuplicates(empArray)) {
					error = "Same employee can not be added twice in the same groups";
					pw.println("Error: " + error);

				}
				// checks whether group name is already exists in the database
				else {
					query.executeQuery("select group_name from group_entry");
					ResultSet rs = query.getResultSet();
					boolean found = false;
					while (rs.next()) {
						if (grpName.equals(rs.getString("group_name"))) {
							found = true;
							error = "Group name is already exist. Try different group name";
							pw.println("Error: " + error);
						}
					}
					if (!found) {
						query.executeUpdate("insert into `group_entry` values(null,'"
								+ request.getParameter("department") + "','" + grpName + "', '"
								+ request.getParameter("emp1") + "', '" + request.getParameter("emp2") + "', '"
								+ request.getParameter("emp3") + "', '" + request.getParameter("emp4") + "', '"
								+ request.getParameter("emp5") + "', '" + request.getParameter("emp6") + "')");
						pw.println("Data Inserted Successfully");
						pw.println("You will be redirected to the home page in a few seconds...");

						response.setHeader("Refresh", "5;url=department.jsp");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
