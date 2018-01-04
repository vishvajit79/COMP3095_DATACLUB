<!-- COMP3095 : Assignment 2 - DataClub 
This file handle AJAX call and get the report data based on selected department and report template-->
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="utilities.DatabaseAccess" %>

<%	
	Connection myCon =  DatabaseAccess.connectDataBase();
	String department = request.getParameter("department");

	
	String dep_id = request.getParameter("id");
	String tid = request.getParameter("tid");
	out.println(tid);
	
	Statement query1 = myCon.createStatement();

	query1.executeQuery("SELECT * FROM report where dep_id = " + dep_id + " and rep_temp_id = " + tid);
	
	 ResultSet empSet = query1.getResultSet ();
	 
	 while (empSet.next()) {
			 String rep_name = empSet.getString("title");
			 String rep_id = empSet.getString("id");
			 out.println(empSet.getString("id"));
			
			%>
				<option value="<%= rep_id %>"><%= rep_name %></option>	
			<% 
		} 
%>