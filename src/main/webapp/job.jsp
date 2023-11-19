<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ page import="es.jacaranda.model.CompanyProject"%>
<%@ page import="es.jacaranda.model.EmployeeProject"%>
<%@ page import="es.jacaranda.db.DbRepository"%>
<%@ page import="es.jacaranda.model.Project"%>
<%@ page import="es.jacaranda.model.Employee"%>
<%@ page import="es.jacaranda.db.DbRepository"%>


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
	HashMap<Integer,LocalDateTime>  mapProjectWorking = null;
	
	if (session.getAttribute("idEmployee")== null){
		response.sendRedirect("index.jsp?msg=Necesitas estar logueado");
		return;
	}
	if (session.getAttribute("mapProjectWorking")== null){
		mapProjectWorking = new HashMap<Integer,LocalDateTime>();	
		session.setAttribute("mapProjectWorking", mapProjectWorking);
	}else{
		mapProjectWorking = (HashMap<Integer,LocalDateTime>) session.getAttribute("mapProjectWorking");
	}
	Integer idEmployeeInteger;
	try{
		idEmployeeInteger  = Integer.parseInt((String)session.getAttribute("idEmployee"));
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg=El identificador del empleado debe ser numérico");
		return;
	}
%>
	<%@include file="menu.jsp"%>
	<%
	if (request.getParameter("action")!= null && request.getParameter("idProject")!= null){
		Integer idProjectInteger;
		Project project=null;
		Employee employee = null;
		try{
			idProjectInteger  = Integer.parseInt((String)request.getParameter("idProject"));
		}catch(Exception e){
			response.sendRedirect("error.jsp?msg=El identificador del proyecto debe ser numérico");
			return;
		}
		
		try{
			project = DbRepository.find(Project.class, idProjectInteger);
		}catch(Exception e){
			response.sendRedirect("error.jsp?msg="+e.getMessage());
			return;
		}
		if (project == null){
			response.sendRedirect("error.jsp?msg=Proyecto no encontrado");
			return;
		}
		try{
			employee = DbRepository.find(Employee.class, idEmployeeInteger);
		}catch(Exception e){
			response.sendRedirect("error.jsp?msg="+e.getMessage());
			return;
		}
		if (employee == null){
			response.sendRedirect("error.jsp?msg=Empleado no encontrado");
			return;
		}
		if (request.getParameter("action").equals("start")){
			if (mapProjectWorking.containsKey(idProjectInteger)){
				response.sendRedirect("error.jsp?msg=Ya esta trabajando en el proyecto");
				return;
			}
			mapProjectWorking.put(idProjectInteger,LocalDateTime.now());
		}else if (request.getParameter("action").equals("stop")){
			if (!mapProjectWorking.containsKey(idProjectInteger)){
				response.sendRedirect("error.jsp?msg=No ha empezado a trabajar en el proyecto");
				return;
			}
			Long timeInSecond = mapProjectWorking.get(idProjectInteger).until(LocalDateTime.now(), ChronoUnit.SECONDS);
			EmployeeProject employeeProject = new EmployeeProject();
			employeeProject.setProject(project);
			employeeProject.setEmployee(employee);
			try{
				employeeProject = DbRepository.find(employeeProject);
				if (employeeProject != null){
					employeeProject.setMinutes(employeeProject.getMinutes()+ timeInSecond.intValue());
					DbRepository.update(employeeProject);
				}else{
					employeeProject = new EmployeeProject();
					employeeProject.setProject(project);
					employeeProject.setEmployee(employee);
					employeeProject.setMinutes(timeInSecond.intValue());
					DbRepository.save(employeeProject);
				}
					
			}catch(Exception e){
				response.sendRedirect("error.jsp?msg="+e.getMessage());
				return;
			}
			
			mapProjectWorking.remove(idProjectInteger);
		}	
	}
	
	List<CompanyProject> listCompanyProject=null;
	try{
		Employee employee = DbRepository.find(Employee.class, idEmployeeInteger);
		listCompanyProject = (List<CompanyProject>) employee.getCompany().getListCompanyProject();
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+e.getMessage());
		return;
	}
%>
	<div style="padding-top: 40px;">
		<table class="table table-bordered">
			<caption>Lista de Proyectos en el que puedes trabajar</caption>
			<thead>
				<tr class="table-primary">
					<th scope="col">Proyecto</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
<%
	
    for(CompanyProject companyProject: listCompanyProject){
  %>
		<tr>
			<td><%= companyProject.getProject().getName() %></td>
			<% if (mapProjectWorking.containsKey(companyProject.getProject().getId())){%>
				<td><a href="job.jsp?idProject=<%= companyProject.getProject().getId() %>&action=stop" 
				    class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Parar</a></td>
			<%}else {%>
				<td><a href="job.jsp?idProject=<%= companyProject.getProject().getId() %>&action=start" 
				    class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Empezar</a></td>
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