<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="es.jacaranda.model.Employee"%>
<%@ page import="es.jacaranda.db.DbRepository"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Empleados</title>
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<%
	if (session.getAttribute("idEmployee")== null){
		response.sendRedirect("../index.jsp?msg=Necesitas estar logueado");
		return;
	}
%>
<%@include file="../menu.jsp"%>
<%


	ArrayList<Employee> listEmployee=null;
	try{
		listEmployee =  DbRepository.findAll(Employee.class);

	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg="+e.getMessage());
		return;
	}
%>
<div style="padding-top: 40px;">
<table class="table table-bordered">
  <caption>Lista de Empleados</caption>
  <thead>
    <tr class="table-primary">
      <th scope="col">Empleados</th>
      <th>Nombre</th>
      <th></th>
       <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
  <%
 

     for(Employee c: listEmployee){
  %>
    <tr>
      <td><%= c.getId() %></td>
      <td><%= c.getFirstName()  %></td>
      <td><a href="show.jsp?id=<%= c.getId() %>" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Ver</a></td>
      <% if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
      	<td><a href="edit.jsp?id=<%= c.getId() %>" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Editar</a></td>
	  
	  <%}
      if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
	  	  <td><a href="delete.jsp?id=<%= c.getId() %>" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Borrar</a></td>
    </tr>
    <%
    	}
     }
    %>
 
  </tbody>
</table>
</div>
</body>
</html>