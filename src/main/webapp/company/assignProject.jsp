<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="es.jacaranda.model.Company"%>
<%@ page import="es.jacaranda.model.Project"%>
<%@ page import="es.jacaranda.model.CompanyProject"%>
<%@ page import="es.jacaranda.db.CompanyRepository"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.Date"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Añadir proyecto a una compañía</title>
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
	Company company = null;
	CompanyProject companyProject=null;
	Integer idCompanyInteger;
	
	if (request.getParameter("id") != null) {
		String id = request.getParameter("id");
		try {
			idCompanyInteger = Integer.parseInt(id);
		} catch (Exception e) {
			response.sendRedirect("../error.jsp?msg=Debe introducir un número para identificar la compañía");
			return;
		}
		try {
			company = CompanyRepository.find(Company.class, idCompanyInteger);
		} catch (Exception e) {
			response.sendRedirect("../error.jsp?msg=Error al acceder a la BD");
			return;
		}
		if (company == null) {
			response.sendRedirect("../error.jsp?msg=Imposible encontrar la compañía con id=" + id);
			return;
		}
		if (request.getParameter("assing") != null) {
			String idProject = request.getParameter("idProject");
			String begin = request.getParameter("begin");
			String end = request.getParameter("end");
			Project projectSelected=null;
			Integer idProjectInteger;
			Date beginDate;
			Date endDate;
			try {
				idProjectInteger = Integer.parseInt(idProject);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=Debe introducir un número para identificar el proyecto");
				return;
			}
			try {
				projectSelected = CompanyRepository.find(Project.class, idProjectInteger);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=Error al acceder a la BD");
		 		return;
			}
			try {
				beginDate = Date.valueOf(begin);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=La fecha inicial no tiene el formato correcto");
				return;
			}
			try {
				endDate = Date.valueOf(end);
			} catch (Exception e) {
				response.sendRedirect("../error.jsp?msg=La fecha inicial no tiene el formato correcto");
				return;
			}
			
			if (beginDate.after(endDate)){
				response.sendRedirect("../error.jsp?msg=La fecha inicial tiene que ser anterior a la fecha final");
				return;
			}
			companyProject = new CompanyProject();
			companyProject.setBegin(beginDate);
			companyProject.setCompany(company);
			companyProject.setProject(projectSelected);
			companyProject.setEnd(endDate);
		 
			
			try {
				CompanyRepository.save(companyProject);
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
						<h1 class="text-center mb-4">Asignar un projecto a la compañía</h1>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Id</label>
							<div class="col-8 mb-4">
								<input id="id" name="id" type="text" class="form-control"
									readonly value='<%=company.getId()%>'>

							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Proyecto</label>
							<div class="col-8 mb-4">
							<%
							if (request.getParameter("assing") != null) {%>
								<input id="idProject" name="idProject" type="text" class="form-control"
									readOnly value='<%=companyProject.getProject().getName()%>'>
							<%}
							else{
								ArrayList<CompanyProject> listCompanyProject = CompanyRepository.getCompanyProject(idCompanyInteger);
								ArrayList<Project> listAllProject = CompanyRepository.findAll(Project.class);
								for (CompanyProject companyProjectEle: listCompanyProject){ 
									if (!companyProjectEle.isFinished()){
										listAllProject.remove(companyProjectEle.getProject());
									}
								}
								%>
								<select name="idProject" id="idProject">
								<% for (Project projectToList: listAllProject){ %> 
									<option value=<%=projectToList.getId()%>><%=projectToList.getName()%></option>
								<%}
							}
							%>
							</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Fecha inicial</label>
							<div class="col-8 mb-4">
								<input id="begin" name="begin" type="date" class="form-control"
									 <%if (request.getParameter("assing") != null){ %>
									readOnly value='<%=companyProject.getBegin()%>'<%} %>>
							</div>
						</div>

						<div class="form-group row">
							<label for="id" class="col-4 col-form-label">Fecha final</label>
							<div class="col-8 mb-4">
								<input id="end" name="end" type="date" class="form-control"
									 <%if (request.getParameter("assing") != null){ %>
									readOnly value='<%=companyProject.getEnd()%>'<%} %>>
							</div>
						</div>
						
						<%if (request.getParameter("assing") != null){%>
							<div class="text-center text-lg-start mt-4 pt-2  mb-4">
							 <a href="list.jsp?" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Volver</a>

							</div>
						<%}
						else{%>
							<div class="text-center text-lg-start mt-4 pt-2  mb-4">
							<button type="submit" id="assing" name="assing" value="assing"
								class="btn btn-primary btn-lg"
								style="padding-left: 2.5rem; padding-right: 2.5rem;">Asignar</button>
							</div>
						<%
						}%>
						
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>



