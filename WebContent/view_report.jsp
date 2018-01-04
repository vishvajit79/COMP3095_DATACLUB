<jsp:include page="header.jsp" />
<!-- COMP3095 : Assignment 2 - DataClub -->

<%@ page import="java.util.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="utilities.DatabaseAccess" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="beans.Report"%>


<% DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new Date()); %>
<div class="container">
   <div class="row mx-auto pt-5">
      <div class="col-8 offset-2 text-justify">
        <% if (request.getAttribute("reportSuccess") != null) {%>
		<p class="alert alert-success"> <%= request.getAttribute("reportSuccess") %> </p>
		<%} %>
		<% if (request.getAttribute("success") != null) {%>
		<p class="alert alert-success"> <%= request.getAttribute("success") %> </p>
		<%} %>
      <form id="viewReport" name="viewReport" method="post" action="ViewData">
         <table class="table">
            <thead>
               <tr>
                  <th></th>
                  <th class="text-center large">View Report</th>
                  <th></th>
               </tr>
            </thead>
            <tbody>
               
                  <tr>
                     <td>
                        <div class="form-group">
                           <label for="reportTemplate"><b>Quick Filter </b></label>
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <td>
                        <div class="form-group locationError">
                           <label for="reportTemplate">Report Template</label>
                           <select class="form-control" name="reportTemplate_id" id="report_template">
                            <option value="" disabled="" selected>Report Template</option>
                              <%
                                 Connection myCon =  DatabaseAccess.connectDataBase();
                                 Statement query = myCon.createStatement();
                                 
                                 query.executeQuery("SELECT * FROM report_template");
                                 ResultSet rs = query.getResultSet ();
                                 
                                 while (rs.next()) {
                                 	String repID = rs.getString("id");
                                 	String repName = rs.getString("name");%>
                              <option value="<%=repID %>"><%=repName %></option>
                              <% 
                                 } 
                                 %>
                           </select>
                        </div>
                     </td>
                  
                     <td>
                        <div class="form-group locationError">
                           <div class="form-group">
                                <label for="dep">Department</label>
                                <select name="dep_id" class="form-control dep_dropdown" id="dep_dropdown" name ="dep"></select>
                             </div>
                        </div>
                     </td>
                     <td>
                        <div class="form-group locationError">
                           <div class="form-group">
                                <label for="dep">Report Title</label>
                                <select name="rep_id" id="rep_dropdown" class="form-control rep_dropdown" name ="rep"></select>
                             </div>
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <td colspan="3">
                        <div class="text-center">
                           <button name="report" type="submit" class="btn btn-success">View</button>
                           <button type="reset" class="btn btn-danger">Cancel</button>
                        </div>
                     </td>
                  </tr>
               <tr>
                  <td colspan="3">
                         Total: <span id="sum"></span>/<span id="max">${ eval_max }</span>
                  </td>
               </tr>
            </tbody>
         </table>
          </form>
          <%
			if (request.getAttribute("report") != null) {
				
			%>
	      <form id="report" name="report" method="post" action="UpdateEntry">
			
           <fieldset>
		  	  <legend>Report:</legend>
				<table class="table">
         			<tr>
         				<td colspan="2"><h5>Details</h5></td>
         			</tr>
         			<tr>
	         			<td>Report</td>
	         			<td>${ report.reportTemplate }</td>
         			</tr>
         			<tr>
	         			<td>Report Title</td>
	         			<td>${ report.reportTitle }</td>
         			</tr>
         			<tr>
	         			<td>Date Created</td>
	         			<td>${ report.dateCreated }</td>
         			</tr>
         			<tr>
	         			<td>Department</td>
	         			<td>${ report.department }</td>
         			</tr>
       		    </table>
       		    <hr>
       		    <table class="table">
       		    
     		    	<%
     		    	Report report = (Report) request.getAttribute("report");
	       		    int sec_len = Integer.parseInt(request.getAttribute("section_length").toString());
	       		 	
	       		     for(int i =0;i<sec_len;i++){
       		    	 %>
	     		    	 <tr>
	       		    		<td colspan="3"><h5><% out.print(report.getSections()[i]); %></h5></td>
	       		    		<input type="hidden" name="criteria" value="<% out.print(report.getSections()[i]); %>">
	       		     	 </tr>	
	       		     <%
		       		   for(int j=0;j<report.getSecDetail()[i].length;j++){
		       			   if(report.getSecDetail()[i][j][0] != null){
		       		 %>   
		       		 
			       		 <tr>
						 	<td></td>
						 	<td><% out.println(report.getSecDetail()[i][j][0]); %></td>
	       		    		<input type="hidden" name="criteria_titals" value="<% out.print(report.getSecDetail()[i][j][0]); %>">
						 	<input type="hidden" name="sec_<%= j %>_criteria_tital" value="<% out.print(report.getSecDetail()[i][j][0]); %>">
						 	
						 	<td>
						 		Evalution <select disabled="" class="eval" id="eval" name="sec<%= j %>_eval">
						 		<% 
					 			for(int k=Integer.parseInt(report.getSecDetail()[i][j][2]);k>=0;k--){
					 				if(k==Integer.parseInt(report.getSecDetail()[i][j][1])){
					 			%>
						 			<option selected value="<% out.print(report.getSecDetail()[i][j][1]); %>"><% out.print(report.getSecDetail()[i][j][1]); %></option>	
				 				<% 
				 					}
					 				else{
					 					%>
					 					<option value="<% out.println(k); %>"><% out.println(k); %></option>	
					 					<%
					 				}
					 			}
					 			%>
						 		</select>
						 	</td>
					 	</tr>
       				 <%  
		       			   }
		       		   }
	       		     %>
	       		     	<tr>
	       		     		<td colspan="3">
				       		  <div class="form-group">
							    <label for="conmments">Comments</label>
							    <textarea disabled class="form-control commentTextArea" id="commment<%= i %>" name="commment<%= i %>" rows="3"><% out.print(report.getComments()[i]); %></textarea>
							  </div>
						  <td>
	       		     	</tr>
	       		     <%
	       		     }
	       		    %>
      		    <tr>
	               <td colspan="3">
	                  <div class="text-center">
	                     <button id="reportUpdateBtn" name="reportUpdateBtn" value="updateReport" type="submit" class="btn btn-success">Update</button>
	                  </div>
	               </td>
           	</tr>
       		    </table>
		  </fieldset>
		  <input type="hidden" name="rep_id" value="${ report_id }">
		  </form>
         
          <table class="table">
            <tr>
               <td colspan="3">
                  <div class="text-center">
                     <button id="reportEditBtn" name="reportEditBtn" type="submit" class="btn btn-success">Edit</button>
                     <button id="reportEditCancelBtn" name="reportEditCancelBtn" class="btn btn-danger">Cancel</button>
                  </div>
               </td>
           </tr>
          </table>
           <%
          }
          %>
          
			<a href="create_report_template.jsp" class="offset-3">	<button name="home" class="btn btn-default"> Back To Create Template Page </button></a>
      </div>
   </div>
</div>
</body>
<script type="text/javascript">
	
	// AJAX call to get the employee drop down data based on selected department
	$( document ).ready(function() {
		
	    $('.empl_dropdown').prop('disabled', true);       

		$('#repTypeEmployee').click(function(){
		    $('.grp_dropdown').prop('disabled', true);   
		    $('.empl_dropdown').prop('disabled', false);       
		    $('')
		});
		$('#repTypeGroup').click(function(){
			 $('.grp_dropdown').prop('disabled', false);       
		    $('.empl_dropdown').prop('disabled', true);       
		});
		$(document).on('change', 'select#department', function(e) {
			var dept = $(this).val();
		    $.post("/COMP3095_DATACLUB/ajax/getEmployees.jsp", {id: dept},
		  	    function(data){
		  	        $('.empl_dropdown')
		  	        		.empty()
		  	        		.append(data);
		  	    });
		    
		    e.preventDefault(); //prevent multiple request
		});
		$('select#department').trigger("change");
		// validates whether group name  is empty
		$(document).on('submit', 'form#group', function(e) {
			var grpName = $("input#groupName").val();
			$(".help-block").hide();
			if(!grpName) {
				$(".grpNameError .help-block").show();
				return false;
			}
			return true;
		});
		
		
		$(document).on('change', 'select#department', function(e) {
			var dept = $(this).val();
		    $.post("/COMP3095_DATACLUB/ajax/getGroups.jsp", {id: dept},
		  	    function(data){
		  	        $('.grp_dropdown')
		  	        		.empty()
		  	        		.append(data);
		  	    });
		    
		    e.preventDefault(); //prevent multiple request
		});
		$('select#department').trigger("change");
		// validates whether group name  is empty
		$(document).on('submit', 'form#group', function(e) {
			var grpName = $("input#groupName").val();
			$(".help-block").hide();
			if(!grpName) {
				$(".grpNameError .help-block").show();
				return false;
			}
			return true;
		});
		
		/*$(document).on('change', 'select#report_template', function(e) {
			var dept = $(this).val();
		    $.post("/COMP3095_DATACLUB/ajax/getReportTemplate.jsp", {id: dept},
		  	    function(data){
		  	        $('.edata')
		  	        		.empty()
		  	        		.append(data);
		  	    });
		    
		    e.preventDefault(); //prevent multiple request
		});*/
		
		$(document).on('change', 'select#report_template', function(e) {
			var dept = $(this).val();
		    $.post("/COMP3095_DATACLUB/ajax/getDepartments.jsp", {id: dept},
		  	    function(data){
		  	        $('.dep_dropdown')
		  	        		.empty()
		  	        		.append(data);
		  	    });
		    
		    e.preventDefault(); //prevent multiple request
		});
		//$('select#report_template').trigger('change');
		
		$(document).on('change', 'select#dep_dropdown', function(e) {
			var dept = $(this).val();
			var tempID = $('select#report_template').val();
		    $.post("/COMP3095_DATACLUB/ajax/getReports.jsp", {id: dept, tid: tempID},
		  	    function(data){
		  	        $('.rep_dropdown')
		  	        		.empty()
		  	        		.append(data);
		  	    });
		    
		    e.preventDefault(); //prevent multiple request
		});
		
		//$('select#dep_dropdown').trigger('change');
		
		// validates whether group name  is empty
		$(document).on('submit', 'form#group', function(e) {
			var grpName = $("input#groupName").val();
			$(".help-block").hide();
			if(!grpName) {
				$(".grpNameError .help-block").show();
				return false;
			}
			return true;
		});
		var total = 0;
		$(document).on('change', 'select#eval', function(e) {
			total = 0;
		    $.each($("select.eval") ,function() {
		    	total += parseInt($(this).val());
		    });
		     $("#sum").html(total);
		    
		    e.preventDefault(); //prevent multiple request
		});
		$('select#eval').trigger("change");
		
		$('#reportEditCancelBtn').prop('disabled', true);
		$('#reportUpdateBtn').prop('hidden', true);

		
		$('#reportEditBtn').click(function(){
			$('select.eval').prop('disabled', false);
			$('.commentTextArea').prop('disabled', false);
			$('#reportEditCancelBtn').prop('disabled', false);
			$('#reportEditBtn').prop('disabled', true);
			$('#reportUpdateBtn').prop('hidden', false);


		});
		
		$('#reportEditCancelBtn').click(function(){
			$('select.eval').prop('disabled', true);
			$('.commentTextArea').prop('disabled', true);
			$('#reportEditBtn').prop('disabled', false);
			$('#reportEditCancelBtn').prop('disabled', true);
			$('#reportUpdateBtn').prop('hidden', true);

		});
		
	});

</script>
</html>