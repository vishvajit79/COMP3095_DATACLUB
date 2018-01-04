<!-- COMP3095 : Assignment 2 - DataClub -->
<jsp:include page="header.jsp" />
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="utilities.DatabaseAccess"%>
<%@ page import="beans.Department" %>
<%@ page import="beans.Employee" %>
<%@ page import="beans.GroupEntry" %>
<div class="container">
    <div class="row mx-auto pt-5">
        <div class="col-7 offset-2 text-justify">
            <table class="table table-bordered" >
                <thead>
                <tr>
                    <th class="text-center large">View Groups</th>
                </tr>
                </thead>
                <tbody id="deptTable" >
                <% if (request.getAttribute("viewGroupError") != null) {%>
					<p class="alert alert-danger"> <%= request.getAttribute("viewGroupError") %> </p>
					<%} %>
                <tr>
                    <td>
                        <form id="group" name="group" method="post" action="ViewData">
                        		<div class="form-group">
                                <label for="depName">Department</label>
                                <select class="form-control" name="department" id="department">
                                		<option value="department">Department</option>
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
                             <div class="form-group">
                                <label for="grpName">Group Name</label>
                                <select class="form-control grp_dropdown" name="grpName" id="grpName">
                                		<option disabled="" selected="" value="group">Group</option>
                                </select>
                             </div>
                             <div class="text-center">
	                            <button name="grpSearch" type="submit" class="btn btn-success">Search</button>
	                            <button type="reset" class="btn btn-danger">Cancel</button>
                            </div>
                         </form>
                     </td>
                </tr>
                <tr>
                    <td>
                       <% 
                       	ArrayList<GroupEntry> grpList = (ArrayList<GroupEntry>) request.getAttribute("grpList");
                        ArrayList<Department> deptList = (ArrayList<Department>) request.getAttribute("deptList");
                        ArrayList<Employee> empList = (ArrayList<Employee>) request.getAttribute("empList"); %>
                        
                        <table>
                       	<tr> 
                       		<td> Department </td>
                       		<td> Group Name</td>
                       		<td> Employee Lastname</td>
                       		<td> Employee Firstname</td>
                       		<td> Employee#</td>
                       	</tr>
                       	<% 
                       		if (request.getAttribute("grpList") != null) { 
                        		for(int i = 0; i < grpList.size() ; i++){ 
                           		%>
                           			<tr>
                           				<td> <% out.println(deptList.get(i).getDeptName());%></td>
                           				<td> <% out.println(grpList.get(i).getGroup_name());%> </td>
                           				<td> <% out.println(empList.get(i).getLast_name());%> </td>
                           				<td> <% out.println(empList.get(i).getFirst_name());%> </td>
                           				<td> <% out.println(empList.get(i).getEmployee_id());%> </td>
                           			</tr>
                           		
                           	<% } } %>
                           	<tr>
								<td colspan=5>
								<%if (grpList == null) {
									%> <span class="text-info">No data found! Please search again.</span> <%
									}%>
								</td>			
							</tr> 
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
            <a href="groups.jsp" class="offset-3">	<button name="home" class="btn btn-default"> Back To GroupEntry Page </button></a>
                
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
$('.grp_dropdown').prop('disabled', true); 
$(document).on('change', 'select#department', function(e) {
	var dept = $(this).val();
	if(dept != "department"){
		$('.grp_dropdown').prop('disabled', false); 
		$.post("/COMP3095_DATACLUB/ajax/getGroups.jsp", {id: dept},
		  	    function(data){
		  	        $('.grp_dropdown')
		  	        		.empty()
		  	        		.append(data);
		  	    });
		    
		    e.preventDefault(); //prevent multiple request
	}
});
$('select#department').trigger("change"); 
</script>
</html>