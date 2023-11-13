<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="es.jacaranda.model.Project"%>
<%@ page import="es.jacaranda.db.ProjectRepository"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar proyecto</title>
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
	Project project = null;
	
	Integer idInteger;
	
	if (request.getParameter("id") != null) {
		String id = request.getParameter("id");
		try {
			idInteger = Integer.parseInt(id);
		} catch (Exception e) {
			response.sendRedirect("../error.jsp?msg=Debe introducir un número para identificar el proyecto");
			return;
		}
		try {
			project = ProjectRepository.find(Project.class, idInteger);
		} catch (Exception e) {
			response.sendRedirect("../error.jsp?msg=Error al acceder a la BD");
			return;
		}
		if (project == null) {
			response.sendRedirect("../error.jsp?msg=Imposible encontrar el proyecto con id=" + id);
			return;
		}
		if (request.getParameter("edit") != null) {
			String name = request.getParameter("name");
			String butget = request.getParameter("butget");

			project.setName(name);
			project.setButget(butget);
			
			try {
				ProjectRepository.update(project);
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
						<h1 class="text-center mb-4">Editar el proyecto</h1>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Id</label>
							<div class="col-8 mb-4">
								<input id="id" name="id" type="text" class="form-control"
									readonly value='<%=project.getId()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Nombre</label>
							<div class="col-8 mb-4">
								<input id="name" name="name" type="text" class="form-control"
									<%if (request.getParameter("edit") != null){ %>
									readOnly<%} %>
									 value='<%=project.getName()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Presupuesto</label>
							<div class="col-8 mb-4">
								<input id="butget" name="butget" type="text" class="form-control"
									 <%if (request.getParameter("edit") != null){ %>
									readOnly<%} %> value='<%=project.getButget() %>'>

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



