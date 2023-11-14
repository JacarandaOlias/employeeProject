<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="es.jacaranda.model.Employee"%>
<%@ page import="es.jacaranda.model.Company"%>
<%@ page import="es.jacaranda.db.EmployeeRepository"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.Date"%>
<%@ page import="org.apache.commons.codec.digest.DigestUtils"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar empleados</title>
<link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<%
	if (session.getAttribute("idEmployee") == null) {
		response.sendRedirect("../index.jsp?msg=Necesitas estar logueado");
		return;
	}else if (!session.getAttribute("role").equals("admin")){
		response.sendRedirect("../index.jsp?msg=Acceso no permitido");
		return;
	}
	%>
	<%@include file="../menu.jsp"%>
	<%
	Employee employee = null;
	ArrayList<Company> listCompany = null;
	Integer idInteger;
	Company companySelected=null;
	if (request.getParameter("id") != null) {
		String id = request.getParameter("id");
		try {
			idInteger = Integer.parseInt(id);
		} catch (Exception e) {
			response.sendRedirect("../error.jsp?msg=Debe introducir un número para identificar al empleado");
			return;
		}
		try {
			employee = EmployeeRepository.find(Employee.class, idInteger);
			listCompany = EmployeeRepository.findAll(Company.class);
		} catch (Exception e) {
			response.sendRedirect("../error.jsp?msg=Error al acceder a la BD");
			return;
		}
		if (employee == null) {
			response.sendRedirect("../error.jsp?msg=Imposible encontrar el empleado con id=" + id);
			return;
		}
		if (request.getParameter("edit") != null) {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String gender = request.getParameter("gender");
			String dateOfBirth = request.getParameter("dateOfBirth");
			String idCompany = request.getParameter("idCompany");
			String password = request.getParameter("password");
			String role = request.getParameter("role");
			int idCompanyInteger;
			Date dateOfBirthDate;
	
			try {
				idCompanyInteger = Integer.parseInt(idCompany);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=Debe introducir un número de compañía del empleado");
				return;
			}
			try {
				dateOfBirthDate = Date.valueOf(dateOfBirth);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=La fecha no tiene el formato correcto");
				return;
			}
			
			try {
				companySelected = EmployeeRepository.find(Company.class, idCompanyInteger);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=Error al acceder a la BD");
				return;
			}
			if (password.length()!=0){
				employee.setPassword(DigestUtils.md5Hex(password));
			}
			employee.setFirstName(firstName);
			employee.setLastName(lastName);
			employee.setEmail(email);
			employee.setGender(gender);
			employee.setDateOfBirth(dateOfBirthDate);
			employee.setCompany(companySelected);
			employee.setRole(role);
			try {
				EmployeeRepository.update(employee);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=Error al acceder a la BD");
				return;
			}
		}
	} else {
		response.sendRedirect("../error.jsp?msg=Es necesario enviar id");
		return;
	}
	%>
	<form>
		<div style="padding-top: 40px;">
			<div class="container ">
				<div class="row justify-content-center align-items-center">
					<div class="col-md-4 border border-primary">
						<h1 class="text-center mb-4">Editar el empleado</h1>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Id</label>
							<div class="col-8 mb-4">
								<input id="id" name="id" type="text" class="form-control"
									readonly value='<%=employee.getId()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Nombre</label>
							<div class="col-8 mb-4">
								<input id="firstName" name="firstName" type="text" class="form-control"
									<%if (request.getParameter("edit") != null){ %>
									readOnly<%} %>
									 value='<%=employee.getFirstName()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Apellido</label>
							<div class="col-8 mb-4">
								<input id="lastName" name="lastName" type="text" class="form-control"
									 <%if (request.getParameter("edit") != null){ %>
									readOnly<%} %> value='<%=employee.getLastName()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">email</label>
							<div class="col-8 mb-4">
								<input id="email" name="email" type="email" class="form-control"
									 <%if (request.getParameter("edit") != null){ %>
									readOnly<%} %> value='<%=employee.getEmail()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Género</label>
							<div class="col-8 mb-4">
								<input id="gender" name="gender" type="text" class="form-control"
									 <%if (request.getParameter("edit") != null){ %>
									readOnly<%} %> value='<%=employee.getGender()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Fecha de nacimiento</label>
							<div class="col-8 mb-4">
								<input id="dateOfBirth" name="dateOfBirth" type="date" class="form-control"
									 <%if (request.getParameter("edit") != null){ %>
									readOnly<%} %> value='<%=employee.getDateOfBirth()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Compañía</label>
							<div class="col-8 mb-4">
							<%if (request.getParameter("edit") != null) {%>
								<input id="idCompany" name="idCompany" type="text" class="form-control"
									readOnly value='<%=companySelected.getName()%>'>
							<%}
							else{%>
							
								<select name="idCompany" id="idCompany">
								<% for (Company company: listCompany){  
									if (company.getId() == employee.getCompany().getId()){%>
										<option value=<%=company.getId()%> selected><%=company.getName()%></option>
									<%}
									else{%>
										<option value=<%=company.getId()%>><%=company.getName()%></option>
									<%}
								}
							}
							%>
							</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Password</label>
							<div class="col-8 mb-4">
								<input id="password" name="password" type="password" class="form-control"
									 <%if (request.getParameter("edit") != null){ %>
									readOnly<%} %> placeholder='*******'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Role</label>
							<div class="col-8 mb-4">
								<input id="role" name="role" type="text" class="form-control"
									 <%if (request.getParameter("edit") != null){ %>
									readOnly<%} %> value='<%=employee.getRole()%>'>

							</div>
						</div>
						<%if (request.getParameter("edit") != null){%>
							<div class="text-center text-lg-start mt-4 pt-2  mb-4">
							 <a href="list.jsp?" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Volver</a>

							</div>
						<%}
						else{%>
							<div class="text-center text-lg-start mt-4 pt-2  mb-4">
							<button type="submit" id="edit" name="edit" value="edit"
								class="btn btn-primary btn-lg"
								style="padding-left: 2.5rem; padding-right: 2.5rem;">Edit</button>
							</div>
						<%} %>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>



