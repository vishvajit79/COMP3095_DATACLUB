<jsp:include page="header.jsp" />

<!-- COMP3095 : Assignment 2 - DataClub -->

<div class="container">
    <div class="row mx-auto pt-5">
        <div class="col-6 offset-3 text-justify">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="text-center large">Department Entry</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <form id="dept" name="dept" method="post" action="AddEntry">
                            <div class="form-group deptNameError">
                                <label for="depName">Department Name</label>
                                <input type="text" name="depName" class="form-control" id="depName" aria-describedby="usernamehelp" placeholder="Name" >
                            		<div class="help-block">Department name should not be empty</div>
                            </div>
                            <div class="form-group locationError">
                                <label for="depLocation">Department Location/Floor</label>
                                <input type="text" name="depLocation" class="form-control" id="depLocation" placeholder="Location" >
                            		<div class="help-block">Location should not be empty</div>
                            </div>
                            <div class="text-center">
	                            <button name="dept" type="submit" class="btn btn-success">Submit</button>
	                            <button type="reset" class="btn btn-danger">Cancel</button>
                            </div>
                        </form>
                    </td>
                </tr>
                <tr>
                		<td>
                			<form id="viewDept" name="viewDept" method="post" action="ViewData">
                        		<div class="form-group text-center">
	                            <button name="viewDept" type="submit" class="btn btn-default">View Department</button>
                            </div>
                        </form>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>
</div>
<script type="text/javascript">
	// validates whether department name and location are empty
	$( document ).ready(function() {
	$(document).on('submit', 'form#dept', function(e) {
			var deptName = $("input#depName").val();
			var location = $("input#depLocation").val();
			var validate = true;
			$(".help-block").hide();
			if(!deptName) {
				$(".deptNameError .help-block").show();
				validate = false;
			}
			if(!location){
				$(".locationError .help-block").show();
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