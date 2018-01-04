package sql.query;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import beans.Attendance;
import beans.Department;
import beans.Employee;
import beans.GroupEntry;
import beans.Report;
import utilities.DatabaseAccess;
import utilities.Validation;

@WebServlet("/ViewData")
public class ViewData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ViewData() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// connect with the database
			Connection myCon = DatabaseAccess.connectDataBase();
			response.setContentType("text/html");
			Statement query = myCon.createStatement();

			// handles the request from department form
			if (request.getParameter("viewDept") != null) {
				query.executeQuery("select * from `DEPARTMENT`");
				ResultSet rs = query.getResultSet();

				ArrayList<Department> deptList = new ArrayList<Department>();

				while (rs.next()) {
					Department deptObj = new Department(rs.getString("deptName"), rs.getString("location"));
					deptList.add(deptObj);
				}

				request.setAttribute("deptList", deptList);

				RequestDispatcher dispatcher = request.getRequestDispatcher("view_department.jsp");
				dispatcher.forward(request, response);
			}

			// handles the request from search employee form and shows the output
			if (request.getParameter("viewEmployee") != null) {
				log(request.getParameter("deptId"));
				query.executeQuery("select * from `employee` where deptId = " + request.getParameter("deptId"));
				ResultSet rs = query.getResultSet();

				ArrayList<Employee> empList = new ArrayList<Employee>();
				while (rs.next()) {
					Employee empObj1 = new Employee(rs.getString("first_name"), rs.getString("last_name"), rs.getString("email"), rs.getString("hire_year"), rs.getString("position"), rs.getInt("employee_id"));
					empList.add(empObj1);
				}
				request.setAttribute("empList", empList);
				request.setAttribute("deptId", request.getParameter("deptId"));
				HttpSession session = request.getSession();
				session.setAttribute("deptId", request.getParameter("deptId"));
				RequestDispatcher dispatcher = request.getRequestDispatcher("view_employee.jsp");
				dispatcher.forward(request, response);
			}
			
			// handles the request from search attendance form and shows the output
			if (request.getParameter("search_employee") != null) {
				query.executeQuery("select * from `employee` where deptId = " + request.getParameter("deptId"));
				ResultSet rs = query.getResultSet();

				ArrayList<Employee> empList = new ArrayList<Employee>();
				while (rs.next()) {
					Employee empObj1 = new Employee(rs.getString("first_name"), rs.getString("last_name"),
							rs.getInt("employee_id"), rs.getInt("deptId"));
					empList.add(empObj1);
				}
				request.setAttribute("empList", empList);
				request.setAttribute("deptId", request.getParameter("deptId"));
				HttpSession session = request.getSession();
				session.setAttribute("deptId", request.getParameter("deptId"));
				RequestDispatcher dispatcher = request.getRequestDispatcher("add_attendance.jsp");
				dispatcher.forward(request, response);
			}
			
			// handles the request from search attendance form and shows the output
			if (request.getParameter("grpSearch") != null) {
				if(!request.getParameter("department").equals("department")) {
					if(request.getParameter("grpName") != null) {
					query.executeQuery("select * from `employee` inner join `group_entry` on employee.deptId = group_entry.department_name "
							+ "inner join `department` on department.deptId = group_entry.department_name"
							+ " where group_name = '" + request.getParameter("grpName") + "' AND group_entry.department_name = " + request.getParameter("department") );
					ResultSet rs = query.getResultSet();
		
					ArrayList<Employee> empList = new ArrayList<Employee>();
					ArrayList<Department> deptList = new ArrayList<Department>();
					ArrayList<GroupEntry> grpList = new ArrayList<GroupEntry>();
					
					while (rs.next()) {
						String empFname = rs.getString("first_name");
						for( int i = 1; i <=6 ; i++) {
							String fname = "employee_" + i;
							if(Validation.checkDuplicateSection(empFname, rs.getString(fname))) {
								Employee empObj = new Employee(empFname, rs.getString("last_name"),
										rs.getInt("employee_id"), rs.getInt("deptId"));
								Department deptObj = new Department(rs.getString("deptName"), rs.getString("location"));
								GroupEntry grpObj = new GroupEntry(Integer.parseInt(rs.getString("deptId")), rs.getString("group_name"));
								empList.add(empObj);
								deptList.add(deptObj);
								grpList.add(grpObj);
							}
						}
					}
					request.setAttribute("empList", empList);
					request.setAttribute("deptList", deptList);
					request.setAttribute("grpList", grpList);
					}
					else {
						request.setAttribute("viewGroupError", "Please select group");
					}
				}
				else {
					request.setAttribute("viewGroupError", "Please select department and group");
				}
				
				request.getRequestDispatcher("view_groups.jsp").forward(request, response);
			}
			
			// handles the request from search report form
			if (request.getParameter("reportTemplate_id") != null) {
				String dep_id = request.getParameter("dep_id");
				String rep_id = request.getParameter("rep_id");
				String rep_temp_id = request.getParameter("reportTemplate_id");
				System.out.println(rep_temp_id);
				Statement reportTemplateQuery = myCon.createStatement();
				reportTemplateQuery.executeQuery("select * from `report_template` where id = " + rep_temp_id + "");
				ResultSet reportTemplateSet = reportTemplateQuery.getResultSet();
				reportTemplateSet.next();
				
				Statement depQuery = myCon.createStatement();
				depQuery.executeQuery("select * from `department` where deptId = " + dep_id + "");
				ResultSet depSet = depQuery.getResultSet();
				depSet.next();
				
				
				
				
				Statement reportTableQuery = myCon.createStatement();
				reportTableQuery.executeQuery("select * from `report` where dep_id = " + dep_id
						+ " and rep_temp_id = " + rep_temp_id + "");
				ResultSet reportTableSet = reportTableQuery.getResultSet();
				reportTableSet.next();
				
				Report report = new Report();
				
				report.setReportTemplate(reportTemplateSet.getString("name"));
				report.setReportTitle(reportTableSet.getString("title"));
				report.setDateCreated(reportTableSet.getString("date"));
				report.setDepartment(depSet.getString("deptName"));
				
				Statement sectionQuery = myCon.createStatement();
				sectionQuery.executeQuery("select DISTINCT title, comment from `report_section` where rep_id=" + rep_id + "");
				ResultSet sectionSet = sectionQuery.getResultSet();
				
				int i = 0;
				String sections[] = new String[3];
				String comments[] = new String[3];
				String[][][] secDetail = new String[3][5][3];
				while (sectionSet.next()) {
					String title = sectionSet.getString("title");
					String comment = sectionSet.getString("comment");
					
					sections[i] = title;
					comments[i] = comment;
					
					Statement secQuery = myCon.createStatement();
					secQuery.executeQuery("select criteria_title, eval, criteria_max from `report_section` where rep_id = " + rep_id + " and title = '" + title + "'");
					ResultSet secSet = secQuery.getResultSet();
					int j = 0;
					while(secSet.next()){
						String criteria_title = secSet.getString("criteria_title");
						
						String eval = secSet.getString("eval");
						String criteria_max = secSet.getString("criteria_max");
						
						secDetail[i][j][0] = criteria_title;
						secDetail[i][j][1] = eval;
						secDetail[i][j][2] = criteria_max;
						j++;
					}
					i++;
				}
				
				Statement query2 = myCon.createStatement();
				query2.executeQuery("SELECT sum(criteria_max) as max FROM report_section where rep_id =" + rep_id +"" );
		 		ResultSet secSet2 = query2.getResultSet ();
		 		secSet2.next();
		 		String max = secSet2.getString("max");
		 		
				report.setSections(sections);
				report.setComments(comments);
				report.setSecDetail(secDetail);

				request.setAttribute("report", report);
				request.setAttribute("section_length", sections.length);
				request.setAttribute("eval_max", max);
				request.setAttribute("report_id", rep_id);

				HttpSession session = request.getSession();
				session.setAttribute("deptId", request.getParameter("deptId"));
				RequestDispatcher dispatcher = request.getRequestDispatcher("view_report.jsp");
				dispatcher.forward(request, response);
			}
			
			// handles the request from search attendance form
			if (request.getParameter("search_attendance") != null) {
				log(request.getParameter("deptId"));

				query.executeQuery("select * from `attendance` where department_id = " + request.getParameter("deptId")
						+ " and date = '" + request.getParameter("date") + "'");
				ResultSet rs1 = query.getResultSet();
				ArrayList<Attendance> attList = new ArrayList<Attendance>();

				while (rs1.next()) {
					Attendance attObj = new Attendance(rs1.getInt("present"));
					attList.add(attObj);
				}

				query.executeQuery("select * from `employee` where deptId = " + request.getParameter("deptId"));
				ResultSet rs = query.getResultSet();

				ArrayList<Employee> empList = new ArrayList<Employee>();
				while (rs.next()) {
					Employee empObj1 = new Employee(rs.getString("first_name"), rs.getString("last_name"),
							rs.getInt("employee_id"), rs.getInt("deptId"));
					empList.add(empObj1);
				}

				request.setAttribute("empList", empList);
				request.setAttribute("attList", attList);
				request.setAttribute("deptId", request.getParameter("deptId"));
				HttpSession session = request.getSession();
				session.setAttribute("deptId", request.getParameter("deptId"));
				RequestDispatcher dispatcher = request.getRequestDispatcher("view_attendance.jsp");
				dispatcher.forward(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
