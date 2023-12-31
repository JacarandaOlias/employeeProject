<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="es.jacaranda.model.Project"%>
<%@ page import="es.jacaranda.db.ProjectRepository"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ver detalles proyecto</title>
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
	Project project= null;
	Integer idInteger;
	if (request.getParameter("id") != null) {
		String id = request.getParameter("id");

		try{
			idInteger = Integer.parseInt(id);
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Debe introducir un número para identificar a la compañía");
			return;
		}
		try{
			project = ProjectRepository.find(Project.class,idInteger);
		}catch(Exception e){
			response.sendRedirect("../error.jsp?msg=Error al acceder a la BD");
			return;
		}
		if (project == null) {
			response.sendRedirect("../error.jsp?msg=Imposible encontrar la compañía con id=" + id);
			return;
		}

	}else{
		response.sendRedirect("../error.jsp?msg=Es necesario enviar id");
		return;
	}
	%>
	<div style="padding-top: 40px;">
		<div class="container ">
			<div class="row justify-content-center align-items-center">
				<div class="col-md-4 border border-primary">
					<form>
						<h1 class="text-center mb-4">Ver proyecto</h1>
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
								<input id="id" name="id" type="text" class="form-control"
									readonly value='<%=project.getName()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Presupuesto</label>
							<div class="col-8 mb-4">
								<input id="id" name="id" type="text" class="form-control"
									readonly value='<%=project.getButget() %>'>

							</div>
						</div>
						
						
					</form>
				</div>
			</div>
		</div>
	</div>
</html>