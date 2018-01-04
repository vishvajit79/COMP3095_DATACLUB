<!-- COMP3095 : Assignment 1 - DataClub 
This file handle AJAX call and get the employee data based on selected department-->
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="utilities.DatabaseAccess" %>

<%	
	Connection myCon =  DatabaseAccess.connectDataBase();
	String department = request.getParameter("department");

	Statement query1 = myCon.createStatement();
	String deptId = request.getParameter("id");
	query1.executeQuery("SELECT first_name, last_name FROM employee where deptId =" + deptId +"" );
	
	 ResultSet empSet = query1.getResultSet ();
	 %>
	 <option disabled="" selected="">Employee</option>
	 <%
	 while (empSet.next()) {
			String empfName = empSet.getString("first_name");
			System.out.println(empfName);
			String emplName = empSet.getString("last_name");
			%>
				<option value="<%=empfName %>"><%=empfName + "," + emplName %></option>	
			<% 
		} 
%>