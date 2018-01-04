<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- COMP3095 : Assignment 2 - DataClub 
This jsp file is used to navigate through the website-->

<div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">DATACLUB</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="department.jsp" id="departments">Departments <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item" id="employees">
                    <a class="nav-link" href="employees.jsp">Employees</a>
                </li>
                <li class="nav-item" id="groups">
                    <a class="nav-link" href="groups.jsp">Groups</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="create_report_template.jsp">Reports</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="add_attendance.jsp">Attendance</a>
                </li>

            </ul>
            <form action="Logout" method="post" class="form-inline my-2 my-lg-0">
                Welcome, Admin!&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="logout" value="true">Logout</button>
            </form>
        </div>
    </nav>
</div>