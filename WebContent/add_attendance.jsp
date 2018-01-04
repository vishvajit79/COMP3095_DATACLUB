<!-- COMP3095 : Assignment 2 - DataClub -->
<%@page import="beans.Employee"%>
<jsp:include page="header.jsp" />
<!-- If the deptId attribute is found then it will run the script and set the dropdown to the previous selection! -->

<%
	if (request.getAttribute("deptId") != null) {
%>
<script type="text/javascript">
	$(document).ready(function() {
		// Get value of deptId
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
						<th class="text-center large">Add Attendance</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<!-- This form searches throught the department table and gets the list of department in the dropdown menu -->

							<form name="search_employee" id="search_employee" method="post"
								action="ViewData">
								<div class="form-group">
									<label for="deptId">Department</label> <select
										class="form-control" name="deptId" id="deptId">
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
								<div class="text-center">
									<button name="search_employee" type="submit"
										class="btn btn-success">Search</button>
									<button type="reset" class="btn btn-danger">Cancel</button>
								</div>
							</form>
						</td>
					</tr>
					<tr>
						<td colspan=4>
							<div class="text-center">
								<input type="text" name="departmentId" id="departmentId"
									hidden=true> <a href="view_attendance.jsp"
									class="btn btn-secondary">View Attendance</a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<hr>
		<%
			if (request.getAttribute("empList") != null) {
		%>
		<!-- This form allows to mark the attendance of the employee related to particular department depending on the search query for a date and if not data found, then it will show a message -->

		<div class="col-6 offset-3 text-justify">
			<form id="add_attendance" name="add_attendance" method="post"
				action="AddEntry">

				<table class="table table-bordered">
					<thead>
						<tr>

							<th class="text-center large" colspan=4><div
									class="dateError">
									Date: <input type="text" placeholder="mm/dd/yyyy"
										class="form-control" id="date" name="date" required>
									<div class="help-block">Please enter valid date of type
										mm/dd/yyyy</div>
								</div></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Employee Lastname</td>
							<td>Employee Firstname</td>
							<td>Employee #</td>
							<td>Present</td>
						</tr>
						<%
							ArrayList<Employee> empList = (ArrayList<Employee>) request.getAttribute("empList");

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
							<td><input type="checkbox" name="present"
								value="<%out.println(empList.get(i).getEmployee_id());%>"></td>
						</tr>

						<%
							}
						%>
						<tr>
							<td colspan=4>
								<%
									if (empList.size() <= 0) {
								%> <span class="text-info" colspan=4>No data found!
									Please search again.</span> <%
 	} else {
 %>
								<div class="text-center">
									<input type="text" name="departmentId" id="departmentId"
										hidden=true>
									<button name="add_attendance" type="submit"
										class="btn btn-success">Enter</button>
								</div> <%
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
<script type="text/javascript">
	//validates add_attendance data fields
	$(document)
			.ready(
					function() {
						$(document)
								.on(
										'submit',
										'form#add_attendance',
										function(e) {
											var date = $("input#date").val();
											var validate = true;
											var expression = /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/;
											$(".help-block").hide();
											if (!date || !expression.test(date)) {
												$(".dateError .help-block")
														.show();
												validate = false;
											}

											if (!validate) {
												return false;
											}

											return true;

										});
					});
</script>
</body>
</html>