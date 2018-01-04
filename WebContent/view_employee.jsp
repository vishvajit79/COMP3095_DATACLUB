<!-- COMP3095 : Assignment 2 - DataClub -->
<%@page import="beans.Employee"%>
<jsp:include page="header.jsp" />

<!-- If the deptId attribute is found then it will run the script and set the dropdown to the previous selection! -->
<%
	if (request.getAttribute("deptId") != null) {
%>
<script type="text/javascript">
	$(document).ready(function() {
		// Get value of paper
		var deptId =
<%=request.getAttribute("deptId")%>
	;

		// Set it as the dropdown value
		$("#deptId").val(deptId);
		$("#departmentId").val(deptId);
	});
</script>
<%
	}
%>
<%@ page import="java.sql.*"%>
<%@ page import="utilities.DatabaseAccess"%>
<%@ page import="java.util.*"%>
<%@ page import="beans.Department"%>
<%@ page import="beans.Attendance"%>
<div class="container">
	<div class="row mx-auto pt-5">
		<div class="col-6 offset-3 text-justify">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="text-center large">View Employee</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<!-- This form searches throught the department table and gets the list of department in the dropdown menu -->
							<form name="viewEmployee" id="viewEmployee"
								method="post" action="ViewData">
								<div class="form-group">
									<label for="deptId">Department</label> <select
										class="form-control" name="deptId" id="deptId" required>
										<%
											Connection myCon = DatabaseAccess.connectDataBase();
											Statement query = myCon.createStatement();

											query.executeQuery("SELECT * FROM department");
											ResultSet rs = query.getResultSet();

											while (rs.next()) {
												String deptId = rs.getString("deptId");
												String deptName = rs.getString("deptName");
										%>
										<option value="<%=deptId%>"><%=deptName%></option>
										<%
											}
										%>
									</select>
								</div>
								<div class="text-center form-control">
									<button name="viewEmployee" type="submit"
										class="btn btn-success">Search</button>
									<button type="reset" class="btn btn-danger">Cancel</button>
								</div>
							</form>
						</td>
					</tr>
				</tbody>
			</table>
			
			<a href="employees.jsp" class="offset-3">	<button name="home" class="btn btn-default"> Back To Employee Page </button></a>
		</div>
		<hr>
		<%
			if (request.getAttribute("empList") != null) {
		%>
		<!-- This form shows the attendance of the employee related to particular department depending on the search query and if not data found, then it will show a message -->
		<div class="col-8 offset-2 text-justify">
			<form id="add_attendance" name="add_attendance" method="post"
				action="AddEntry">
				<%
					ArrayList<Employee> empList = (ArrayList<Employee>) request.getAttribute("empList");
				%>

				<table class="table table-bordered">
					<tbody>
						<tr>
							<td>Employee Lastname</td>
							<td>Employee Firstname</td>
							<td>Employee #</td>
							<td>Hire Year</td>
							<td>Job Position</td>
							<td>Email</td>
						</tr>
						<%
							for (int i = 0; i < empList.size(); i++) {
						%>
						<tr>
							<td>
								<%
									out.println(empList.get(i).getLast_name());
								%>
							</td>
							<td>
								<%
									out.println(empList.get(i).getFirst_name());
								%>
							</td>
							<td>
								<%
									out.println(empList.get(i).getEmployee_id());
								%>
							</td>
							<td>
								<%
									out.println(empList.get(i).getHire_year());
								%>
							</td>
							<td>
								<%
									out.println(empList.get(i).getPosition());
								%>
							</td>
							<td>
								<%
									out.println(empList.get(i).getEmail());
								%>
							</td>
						</tr>

						<%
							}
						%>
						<tr>
							<td colspan=6>
								<%
									if (empList.size() <= 0) {
								%> <span class="text-info">No data found! Please search
									again.</span> <%
 							}
 						%>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<%
			}
		%>
	</div>
</div>

</body>
</html>