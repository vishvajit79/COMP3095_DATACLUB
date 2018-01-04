<!-- COMP3095 : Assignment 2 - DataClub 
This file handle AJAX call and get the group data based on selected department-->
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="utilities.DatabaseAccess" %>

<%	
	Connection myCon =  DatabaseAccess.connectDataBase();
	String department = request.getParameter("department");
	String deptId = request.getParameter("id");
	
    Statement query1 = myCon.createStatement();
	query1.executeQuery("SELECT group_name FROM `group_entry` where department_name ="+ deptId +"");
	 ResultSet grpSet = query1.getResultSet ();
	 
	
	 %>
	  <option disabled="" selected="" value="group">Group</option> 
	 <%
	 while (grpSet.next()) {
			String grpName = grpSet.getString("group_name");
			%>
				<option value="<%=grpName %>"><%=grpName%></option>	
			<% 
		} 
%>