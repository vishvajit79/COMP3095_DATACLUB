<jsp:include page="header.jsp" />
<!-- COMP3095 : Assignment 2 - DataClub -->
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="utilities.DatabaseAccess" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<% DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new Date()); %>
<div class="container">
   <div class="row mx-auto pt-5">
      <div class="col-8 offset-2 text-justify">
      <% if (request.getAttribute("reportError") != null) {%>
		<p class="alert alert-danger"> <%= request.getAttribute("reportError") %> </p>
		<%} %>
      <form id="report" name="report" method="post" action="AddEntry">
         <table class="table">
            <thead>
               <tr>
                  <th></th>
                  <th class="text-center large">Enter Report</th>
                  <th></th>
               </tr>
            </thead>
            <tbody>
               
                  <tr>
                     <td>
                        <div class="form-group">
                           <label for="reportTemplate"><b>1. Details </b></label>
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <td>
                        <div class="form-group">
                           <label for="reportTemplate">Report Template</label>
                           <select class="form-control" name="reportTemplate_id" id="report_template">
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
                        <div class="form-group repNameError">
                           <label for="reportTemplate">Report Name</label>
                           <input type="text" name="reportName" class="form-control" id="reportName"  placeholder="Report Name" >
                           <div class="help-block">Report name is required</div>
                        </div>
                     </td>
                     <td>
                        <div class="form-group">
                           <label for="date">Date</label>
                           <input type="text" name="date" class="form-control" id="date" value="<%=formattedDate %>" readonly>
                        </div>
                     </td>
                  </tr>
                  <tr>
                 	 <td colspan="3">
	                     <div class="form-group">
	                        <label for="depName">Department</label>
	                        <select class="form-control department" name="department" id="department">
	                           
	                        </select>
	                     </div>
                     </td>
                  </tr>
                  <tr  class="text-center">
                 	 <td  colspan="3">
	                     <div class="form-check">
							  <input class="form-check-input rd" type="radio" name="repType" id="repTypeGroup" value="Group" checked>
							  <label class="form-check-label" for="repTypeGroup">
							    	Group
							  </label>
						</div>
						<div class="form-check">
							  <input class="form-check-input" type="radio" name="repType" id="repTypeEmployee" value="Employee">
							  <label class="form-check-label rd" for="repTypeEmployee">
							    Employee
							  </label>
						</div>
                     </td>
                  </tr>
                  <tr>
                 	 <td colspan="3" class="text-center">
	                     <div class="form-group">
	                            <label for="grp">Group</label>
	                            <select class="form-control grp_dropdown" name ="grp">
	                            </select>
                         </div>
	                      <div class="form-group">
	                            <label for="emp1">Employee</label>
	                            <select class="form-control empl_dropdown" name ="emp1">
	                            </select>
                         </div>
                     </td>
                  </tr>
                  <tr class="form-group edata"></tr>
                  <tr>
                     <td colspan="3">
                        <div class="text-center">
                           <button name="report" type="submit" class="btn btn-success">Submit</button>
                           <button type="reset" class="btn btn-danger">Cancel</button>
                        </div>
                     </td>
                  </tr>
              
               <tr>
                  <td colspan="3">
                         Total: <span id="sum"></span>/<span id="max"></span>
                  </td>
               </tr>
            </tbody>
         </table>
          </form>
          
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
		$(document).on('submit', 'form#report', function(e) {
			var repName = $("input#reportName").val();
			$(".help-block").hide();
			if(!repName) {
				$(".repNameError .help-block").show();
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
		
		$(document).on('change', 'select#report_template', function(e) {
			var dept = $(this).val();
			
		    $.post("/COMP3095_DATACLUB/ajax/getReportTemplate.jsp", {id: dept},
		  	    function(data){
		  	        $('.edata')
		  	        		.empty()
		  	        		.append(data);
					$('select#department').trigger("change");

		  	    });
		    e.preventDefault(); //prevent multiple request
		});
		
		$(document).on('change', 'select#report_template', function(e) {
			var dept = $(this).val();
		    $.post("/COMP3095_DATACLUB/ajax/getReportDepartment.jsp", {id: dept},
		  	    function(data){
		  	        $('.department')
		  	        		.empty()
		  	        		.append(data);
		  	    });
		    
		    e.preventDefault(); //prevent multiple request
		});
		$('select#report_template').trigger("change");
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
	});

</script>
</html>