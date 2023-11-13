<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Project Jacaranda</title>
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<%@include file="menu.jsp"%>
<%
	String error = request.getParameter("msg");
	if (error == null){
		error = "Error inesperado o acceso no permitido";
	}
%>
<div><br><br></div>
<div class="display-1 text-center text-primary"><%=error %></div>

</body>
</html>