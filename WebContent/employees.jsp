<!-- COMP3095 : Assignment 2 - DataClub -->
<jsp:include page="header.jsp" />

<%@ page import="java.sql.*" %>
<%@ page import="utilities.DatabaseAccess" %>
	<div class="container">
    <div class="row mx-auto pt-5">
        <div class="col-6 offset-3 text-justify">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="text-center large">Employee Entry</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <form id="emp" name="emp" method="post" action="AddEntry">
                            <div class="form-group fNameError">
                                <label for="firstname">Firstname</label>
                                <input type="text" name="firstname" class="form-control" id="firstname" placeholder="First name" >
                                <div class="help-block">First name should not be empty</div>
                            </div>
                            <div class="form-group lNameError">
                                <label for="lastname">Lastname</label>
                                <input type="text" name="lastname" class="form-control" id="lastname" placeholder="Last Name" >
                                <div class="help-block">Last name should not be empty</div>
                            </div>
                            <div class="form-group empIdError">
                                <label for="employeenum">Employee#:</label>
                                <input type="text" name="employeeid" class="form-control" id="employeenum" placeholder="Employee Id" >
                                <div class="help-block">Please enter valid employee id</div>
                            </div>
                            <div class="form-group emailError">
                                <label for="email">Email ID:</label>
                                <input type="text" name="email" class="form-control" id="email" placeholder="Email" email>
                                <div class="help-block">Please enter valid email</div>
                            </div>
                            <div class="form-group">
                            		<label for="hyear">Hire year</label>
                                <select name="hyear" class="form-control" id="hire-year">
                                	<option>2010</option>
                                	<option>2011</option>
                                	<option>2012</option>
                                	<option>2013</option>
                                	<option>2014</option>
                                	<option>2015</option>
                                	<option>2016</option>
                                	<option>2017</option>
                                </select>
                            </div>
                            <div class="form-group">
                            <label for="hyear">Position</label>
                                <select name="pos" class="form-control" id="position">
                                	<option>HR Manager</option>
                                	<option>business management</option>
                                	<option>Client group supervisor</option>
                                	<option>Director of Sales</option>
                                	<option>Financial Advisor</option>
                                	<option>Executive Vice President</option>
                                	<option>Executive Chief Officer</option>
                                	<option>Senior Developer</option>
                                	<option>Web Programmer</option>
                                	<option>Database Administrator<option>
                                </select>
                            </div>
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
                            <div class="text-center">
	                            <button name="employee" type="submit" name="dept" class="btn btn-success">Submit</button>
	                            <button type="reset" class="btn btn-danger">Cancel</button>
                            </div>
                        </form>
                    </td>
                </tr>
                <tr>
                		<td>
                        		<div class="form-group text-center">
	                            <a href="view_employee.jsp" class="btn btn-secondary">View Employees</a>
                            </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">

//validates employee data fields
$( document ).ready(function() {
	$(document).on('submit', 'form#emp', function(e) {
		var fName = $("input#firstname").val();
		var lName = $("input#lastname").val();
		var empId = $("input#employeenum").val();
		var email = $("input#email").val();
		var validate = true;
		var expression = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		$(".help-block").hide();
		if(!fName) {
			$(".fNameError .help-block").show();
			validate = false;
		}
		if(!lName) {
			$(".lNameError .help-block").show();
			validate = false;
		}
		if(!empId || !$.isNumeric(empId) || empId.length > 11){
			$(".empIdError .help-block").show();
			validate = false;
		}
		if(!email || !expression.test(email)) {
			$(".emailError .help-block").show();
			validate = false;
		}
		
		if(!validate){
			return false;
		}
		
		
		return true;
		
	});
});
</script>
</body>
</html>