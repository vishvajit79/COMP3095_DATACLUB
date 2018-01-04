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
            <table class="table">
                <thead>
                <tr>
                    <th colspan=2 class="text-center large">Create Report Template</th>
                </tr>
                </thead>
                <tbody>
	                <% if (request.getAttribute("templateSuccess") != null) {%>
					<p class="alert alert-success"> <%= request.getAttribute("templateSuccess") %> </p>
					<%} %>
					<% if (request.getAttribute("templateError") != null) {%>
					<p class="alert alert-danger"> <%= request.getAttribute("templateError") %> </p>
					<%} %>
					<% if (request.getAttribute("section1Error") != null) {%>
					<p class="alert alert-danger"> <%= request.getAttribute("section1Error") %> </p>
					<%} %>
					<% if (request.getAttribute("section2Error") != null) {%>
					<p class="alert alert-danger"> <%= request.getAttribute("section2Error") %> </p>
					<%} %>
					<% if (request.getAttribute("section3Error") != null) {%>
					<p class="alert alert-danger"> <%= request.getAttribute("section3Error") %> </p>
					<%} %>
                <form id="reportTemplate" name="reportTemplate" method="post" action="AddEntry">
                <tr>
                    <td colspan=2>
                    		<div class="form-group">
                            <label for="reportTemplate"><b>1. Details </b></label>
                        </div>
                    </td>
               </tr>
               <tr>
                   <td>
	                   <div class="form-group repTempError">
	                       <label for="reportTemplate">Report Template</label>
	                       <input type="text" name="reportTemplateName" class="form-control" id="reportTemplateName"  placeholder="Report Template Name" >
	                       <div class="help-block">Report template name is required</div>
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
                		<td colspan=2 class="text-center">
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
                          			<% } %>
                          </select>
                      </div>
                    </td>
                </tr>
  				<tr>
  					<td>
 						<div class="form-group">
                           <label for="section1"><b>2. Section-I </b></label>
                       </div>
                    </td>
                    <td>
                    		<div class="form-group sec1Error">
                            <input type="text" name="section1" class="form-control" id="section1"  placeholder="Section Title" >
                            <div class="help-block">Section title is required</div>
                        </div>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec1_criteria1">Criteria 1</label>
                            <input type="text" name="sec1[criteria]" class="form-control" id="sec1_criteria1">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec1[max]" id="sec1_criteria1_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec1_criteria2">Criteria 2</label>
                            <input type="text" name="sec1[criteria]" class="form-control" id="sec1_criteria2">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec1[max]" id="sec1_criteria2_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec1_criteria3">Criteria 3</label>
                            <input type="text" name="sec1[criteria]" class="form-control" id="sec1_criteria3">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec1[max]" id="sec1_criteria3_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec1_criteria4">Criteria 4</label>
                            <input type="text" name="sec1[criteria]" class="form-control" id="sec1_criteria4">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec1[max]" id="sec1_criteria4_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec1_criteria5">Criteria 5</label>
                            <input type="text" name="sec1[criteria]" class="form-control" id="sec1_criteria5">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec1[max]" id="sec1_criteria5_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
 						<div class="form-group">
                           <label for="section2"><b>3. Section-II </b></label>
                       </div>
                    </td>
                    <td>
                    		<div class="form-group sec2Error">
                            <input type="text" name="section2" class="form-control" id="section2"  placeholder="Section Title" >
                            <div class="help-block">Section title is required</div>
                        </div>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec2_criteria1">Criteria 1</label>
                            <input type="text" name="sec2[criteria]" class="form-control" id="sec2_criteria1">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec2[max]" id="sec2_criteria1_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec2_criteria2">Criteria 2</label>
                            <input type="text" name="sec2[criteria]" class="form-control" id="sec2_criteria2">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec2[max]" id="sec2_criteria2_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec2_criteria3">Criteria 3</label>
                            <input type="text" name="sec2[criteria]" class="form-control" id="sec2_criteria3">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec2[max]" id="sec2_criteria3_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
 						<div class="form-group">
                           <label for="section3"><b>4. Section-III </b></label>
                       </div>
                    </td>
                    <td>
                    		<div class="form-group sec3Error">
                            <input type="text" name="section3" class="form-control" id="section3"  placeholder="Section Title" >
                            <div class="help-block">Section title is required</div>
                        </div>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec3_criteria1">Criteria 1</label>
                            <input type="text" name="sec3[criteria]" class="form-control" id="sec3_criteria1">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec3[max]" id="sec3_criteria1_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec3_criteria2">Criteria 2</label>
                            <input type="text" name="sec3[criteria]" class="form-control" id="sec3_criteria2">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec3[max]" id="sec3_criteria2_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
  				<tr>
  					<td>
                        <div class="form-group">
                            <label for="sec3_criteria3">Criteria 3</label>
                            <input type="text" name="sec3[criteria]" class="form-control" id="sec3_criteria3">
                        </div>
  					</td>
  					<td>
  						<div class="form-group">
                            <label for="maximum">Maximum</label>
                            <select class="form-control" name="sec3[max]" id="sec3_criteria3_max">
                            		<option value="5">5</option>
                            		<option value="4">4</option>
                            		<option value="3">3</option>
                            		<option value="2">2</option>
                            		<option value="1">1</option>
                            </select>
                            
                        </div>
  					</td>
  				</tr>
                <tr>
                		<td colspan=2>
                			<div class="text-center">
	                         <button name="reportTemplate" type="submit" class="btn btn-success">Create</button>
	                         <button type="reset" class="btn btn-danger">Cancel</button>
                        </div>
                		</td>
                <tr>
                </form>
                <tr>
               		<td colspan=3 class="text-center">
               			 <a href="view_report.jsp"><button class="btn btn-default">View Report</button></a>
                       
                       <a href="enter_report.jsp"><button class="btn btn-default">Enter Report</button></a>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>
</div>
<script type="text/javascript">
	// validates whether report template name is empty
	$( document ).ready(function() {
	$(document).on('submit', 'form#reportTemplate', function(e) {
			var repTempName = $("input#reportTemplateName").val();
			var sec1 = $("input#section1").val();
			var sec2 = $("input#section2").val();
			var sec3 = $("input#section3").val();
			var validate = true;
			$(".help-block").hide();
			if(!repTempName) {
				$(".repTempError .help-block").show();
				document.getElementById("reportTemplateName").focus();
				validate = false;
			}
			if(!sec1) {
				$(".sec1Error .help-block").show();
				document.getElementById("section1").focus();
				validate = false;
			}
			if(!sec2) {
				$(".sec2Error .help-block").show();
				document.getElementById("section2").focus();
				validate = false;
			}
			if(!sec3) {
				$(".sec3Error .help-block").show();
				document.getElementById("section3").focus();
				validate = false;
			}
			
			if(!validate)
				return false;
			
			return true;
		});
	});
</script>
</body>
</html>