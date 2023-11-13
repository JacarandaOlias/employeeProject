<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="es.jacaranda.model.Company"%>
<%@ page import="es.jacaranda.db.CompanyRepository"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Compañías</title>
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


	ArrayList<Company> listCompany=null;
	try{
		listCompany =  CompanyRepository.findAll(Company.class);

	}catch(Exception e){
		response.sendRedirect("../error.jsp?msg="+e.getMessage());
		return;
	}
%>
<div style="padding-top: 40px;">
<table class="table table-bordered">
  <caption>Lista de Companías</caption>
  <thead>
    <tr class="table-primary">
      <th scope="col">Companías</th>
      <th>Nombre</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
  <%
 

     for(Company company: listCompany){
  %>
    <tr>
      <td><%= company.getId() %></td>
      <td><%= company.getName()  %></td>
      <td><a href="show.jsp?id=<%= company.getId() %>" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Ver</a></td>
      <% if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
      	<td><a href="edit.jsp?id=<%= company.getId() %>" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Editar</a></td>
	  
	  <%}
      if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
	  	  <td><a href="delete.jsp?id=<%= company.getId() %>" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Borrar</a></td>
     <%
    	}
      if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
  	  <td><a href="assignProject.jsp?id=<%= company.getId() %>" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Asignar Proyecto</a></td>
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