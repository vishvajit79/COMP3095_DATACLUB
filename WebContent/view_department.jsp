<!-- COMP3095 : Assignment 2 - DataClub -->
<jsp:include page="header.jsp" />
<%@ page import="java.util.*" %>
<%@ page import="beans.Department" %>
<div class="container">
    <div class="row mx-auto pt-5">
        <div class="col-6 offset-3 text-justify">
            <table class="table table-bordered" >
                <thead>
                <tr>
                    <th class="text-center large">View Departments</th>
                </tr>
                </thead>
                <tbody id="deptTable" class="text-center">
                <tr>
                    <td>
                       <table>
                       	<tr> 
                       		<td> Department Name </td>
                       		<td> Department Location/(Floor)</td>
                       	</tr>
                      	<% ArrayList<Department> deptList = (ArrayList<Department>) request.getAttribute("deptList");
                       		for(int i = 0; i < deptList.size() ; i++){ %>
                       			<tr>
                       				<td> <% out.println(deptList.get(i).getDeptName());%></td>
                       				<td> <% out.println(deptList.get(i).getDeptLocation());%> </td>
                       			</tr>
                       		
                       	<% } %> 
                       </table>
                    </td>
                </tr>
               
                </tbody>
            </table>
            <a href="department.jsp" class="offset-5">	<button name="home" class="btn btn-default"> Back To Department Page </button></a>
                
        </div>
    </div>
</div>
</body>
</html>