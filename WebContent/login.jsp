<!-- COMP3095 : Assignment 2 - DataClub -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Database Club</title>
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<% if (session.getAttribute("user") == null) { %>
   <div class="container">
    <div class="row mx-auto pt-5">
        <div class="col-6 offset-3 text-justify">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="text-center large">Login page</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <form method="post" action="LoginAuth">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" name="username" class="form-control" id="username" aria-describedby="usernamehelp" placeholder="admin" required>
                                <small id="usernameHelp" class="form-text text-muted">We'll never share your username with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" name="pass" class="form-control" id="password" placeholder="admin" required>
                            </div>
                            <div class="form-check">
                                <label class="form-check-label">
                                    <input type="checkbox" class="form-check-input">
                                    Remember Me
                                </label>
                            </div>
                            <button type="submit" class="btn btn-">Submit</button>
                        </form>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>
</div>
<% } else {
	response.sendRedirect("department.jsp");%>
<% }
%>
</body>
</html>