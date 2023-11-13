<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="es.jacaranda.db.DbRepository"%>
<%@ page import="es.jacaranda.model.Employee"%>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Project</title>
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if (username == null || password == null){
			response.sendRedirect("index.jsp?msg=Debe introducir username y password");
			return;
		}else {
			try{
				String role = DbRepository.findUser(username, DigestUtils.md5Hex(password));
				if (role != null) {
					session.setAttribute("role", role);
					session.setAttribute("idEmployee", username);
				} else{
					response.sendRedirect("index.jsp?msg=Username o password erróneo");
					return;
				}
			}catch(Exception e){
				response.sendRedirect("index.jsp?msg="+e.getMessage());
				return;
			}
		}
	%>
	<%@include file="menu.jsp"%>
	
</body>
</html>