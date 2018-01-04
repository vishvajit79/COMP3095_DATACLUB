<!-- COMP3095 : Assignment 2 - DataClub -->
<jsp:include page="header.jsp" />

<%@ page import="java.sql.*" %>
<%@ page import="utilities.DatabaseAccess" %>
<%@ page import="java.io.PrintWriter" %>

	<div class="container">
    <div class="row mx-auto pt-5">
        <div class="col-6 offset-3 text-justify">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="text-center large">Group Entry</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <form id="group" name="group" method="post" action="AddEntry">
                        		<div class="form-group">
                                <label for="depName">Department</label>
                                <select class="form-control" name="department" id="department">
                                		<%
	                                		Connection myCon =  DatabaseAccess.connectDataBase();
	                                		Statement query = myCon.createStatement();
                                			
                                			query.executeQuery("SELECT * FROM department");
                                			ResultSet rs = query.getResultSet ();
                                			
                                			
                                			while (rs.next()) {
                                				String deptId = rs.getString("deptId");
                                				String deptName = rs.getString("deptName");%>
                                				<option value="<%=deptId %>"><%=deptName %></option>
                                				<% 
                                				
                                			} 
                                		%>
                                </select>
                             </div>
                            <div class="form-group grpNameError">
                                <label for="groupName">Group Name</label>
                                <input type="text" name="groupName" class="form-control" id="groupName" aria-describedby="usernamehelp" placeholder="Group Name">
                                <div class="help-block">Group name should not be empty</div>
                            </div>
                            <div class="form-group">
                                <label for="emp1">Employee 1</label>
                                <select class="form-control empl_dropdown" name ="emp1"></select>
                             </div>
                             <div class="form-group">
                                <label for="emp2">Employee 2</label>
                                <select class="form-control empl_dropdown" name ="emp2"></select>
                             </div>
                             <div class="form-group">
                                <label for="emp3">Employee 3</label>
                                <select class="form-control empl_dropdown" name ="emp3"></select>
                             </div>
                             <div class="form-group">
                                <label for="emp4">Employee 4</label>
                                <select class="form-control empl_dropdown" name ="emp4"></select>
                             </div>
                             <div class="form-group">
                                <label for="emp5">Employee 5</label>
                                <select class="form-control empl_dropdown" name ="emp5"></select>
                             </div>
                             <div class="form-group">
                                <label for="emp6">Employee 6</label>
                                <select class="form-control empl_dropdown" name ="emp6"></select>
                             </div>
                            <div class="text-center">
	                            <button name="group" type="submit" class="btn btn-success">Submit</button>
	                            <button type="reset" class="btn btn-danger">Cancel</button>
                            </div>
                        </form>
                    </td>
                </tr>
                 <tr>
                		<td>
                			<form id="viewGroup" name="viewGroup" method="post" action="view_groups.jsp">
                        		<div class="form-group text-center">
	                            <button name="viewGroup" type="submit" class="btn btn-default">View Groups</button>
                            </div>
                        </form>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>
</div>
</body>
</html>

<script type="text/javascript">
	
	// AJAX call to get the employee drop down data based on selected department
	$( document ).ready(function() {
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
	});

</script>