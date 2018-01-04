<!-- COMP3095 : Assignment 2 - DataClub 
This file handle AJAX call and get the report data based on selected report template-->
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="utilities.DatabaseAccess" %>

<%	
	Connection myCon =  DatabaseAccess.connectDataBase();
	String department = request.getParameter("department");

	
	String rep_temp_id = request.getParameter("id");
	Statement query1 = myCon.createStatement();

	query1.executeQuery("SELECT department_id FROM report_template where id =" + rep_temp_id +"");
	
	 ResultSet empSet = query1.getResultSet ();
	
	 while (empSet.next()) {
		 
			String department_id = empSet.getString("department_id");
			Statement query2 = myCon.createStatement();
			query2.executeQuery("SELECT deptName FROM department where deptId =" + department_id +"");
			 ResultSet depSet = query2.getResultSet ();
			 depSet.next();
			 String dep_name = depSet.getString("deptName");
			%>
				<option value="<%= department_id %>"><%= dep_name %></option>	
			<% 
		} 
%>