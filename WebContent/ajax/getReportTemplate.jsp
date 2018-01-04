<!-- COMP3095 : Assignment 2 - DataClub 
This file handle AJAX call and get the report template data based on selected department-->
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="utilities.DatabaseAccess" %>

<%	
	Connection myCon =  DatabaseAccess.connectDataBase();
	String department = request.getParameter("department");
	String repTempId = request.getParameter("id");
	
	
	
	Statement query = myCon.createStatement();
	query.executeQuery("SELECT title FROM report_template_section where rep_temp_id =" + repTempId + " Group by title" );
	ResultSet secSet = query.getResultSet ();

	%>
	<td colspan="3">
	<%
	int j = 0;
	 while (secSet.next()) {
			String title = secSet.getString("title");
	%>
				<h5><%= title %></h5>
			<% 
			Statement query1 = myCon.createStatement();
			query1.executeQuery("SELECT * FROM report_template_section where title ='" + title +"' AND rep_temp_id = " + repTempId + "" );
			 ResultSet secSet1 = query1.getResultSet ();
			 int k=0;
			 while (secSet1.next()) {
				 String criteria_title = secSet1.getString("criteria_title");
				 String criteria_max = secSet1.getString("criteria_max");
				 %>
				 <table class="table">
				 	<tr>
					 	<td></td>
					 	<td><%= criteria_title %></td>
					 	<td>
					 		Evalution <select class="eval" id="eval" name="sec<%= j %>_eval">
					 		<% 
					 			for(int i=Integer.parseInt(criteria_max);i>=0;i--){
					 		%>
					 			<option value="<%= i %>"><%= i %></option>	
					 		<%
					 			}
					 		%>
					 		</select>
					 	</td>
				 	</tr>
				 </table>
			
				 <%
				 k++;
			 }
			 %>
			 <div class="form-group">
			    <label for="conmments">Comments</label>
			    <textarea class="form-control" id="commment<%= j %>" name="commment<%= j %>" rows="3"></textarea>
			  </div>
			 <%
			 j++;
		} 
	
	Statement query2 = myCon.createStatement();
	query2.executeQuery("SELECT sum(criteria_max) as max FROM report_template_section where rep_temp_id =" + repTempId +"" );
 		ResultSet secSet2 = query2.getResultSet ();
 		secSet2.next();
 		String max = secSet2.getString("max");

%>	
	</td>
	<script>$("#max").html(<%= max %>);</script>