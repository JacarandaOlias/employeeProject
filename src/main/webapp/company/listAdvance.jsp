<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="es.jacaranda.model.Company"%>
<%@ page import="es.jacaranda.model.Employee"%>
<%@ page import="es.jacaranda.model.CompanyProject"%>
<%@ page import="es.jacaranda.db.CompanyRepository"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listado completo de Compañías</title>
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<%
	if (session.getAttribute("idEmployee") == null) {
		response.sendRedirect("../index.jsp?msg=Necesitas estar logueado");
		return;
	}
	%>
	<%@include file="../menu.jsp"%>
	<%
	ArrayList<Company> listCompany = null;
	try {
		listCompany = CompanyRepository.findAll(Company.class);

	} catch (Exception e) {
		response.sendRedirect("../error.jsp?msg=" + e.getMessage());
		return;
	}
	%>
	<div style="padding-top: 40px;">
		<table class="table table-bordered">
			<caption>Lista de Companías</caption>
			<thead>

			</thead>
			<tbody>
			<%
			for (Company company : listCompany) {
					ArrayList<Employee> listEmployee = (ArrayList<Employee>) company.getListEmployee();
					ArrayList<CompanyProject> listCompanyProject = (ArrayList<CompanyProject>) company.getListCompanyProject();
				%>
				<tr class="table-primary">
					<th scope="col">Companías</th>
					<th>Nombre</th>
					<th>Número de empleados</th>
					<th>Número de projectos</th>
				</tr>
				<tr>
					<td><%=company.getId()%></td>
					<td><%=company.getName()%></td>
					<td><%=listEmployee.size()%></td>
					<td><%=listCompanyProject.size()%></td>
				<tr>
				<tr class="table-primary">
					<th scope="col">Id</th>
					<th>Nombre</th>
					<th>Apellidos</th>
				</tr>
				<%
				for (Employee employee : listEmployee) {
				%>
				<tr>
					<td><%=employee.getId()%></td>
					<td><%=employee.getFirstName() %></td>
					<td><%=employee.getLastName()%></td>
				<tr>
				<%
	 			}
				%>
				<tr class="table-primary">
					<th scope="col">Id</th>
					<th>Proyecto</th>
					<th>Presupuesto</th>
				</tr>
				<%
				for (CompanyProject companyProject : listCompanyProject) {
				%>
				<tr>
					<td><%=companyProject.getProject().getId()%></td>
					<td><%=companyProject.getProject().getName() %></td>
					<td><%=companyProject.getProject().getButget() %></td>
					
				<tr>
				<%
	 			}
				%>
			<%
			}
			%>
				
			</tbody>
		</table>
		</div>
</body>
</html>