<nav class="navbar navbar-expand-lg navbar-dark bg-primary">

	<div class="container-fluid">
		<a class="navbar-brand" href="/employeeProject/index.jsp">Employee Project</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						Empleados</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="/employeeProject/employee/list.jsp">Listar</a></li>
						<% if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
						<li><a class="dropdown-item" href="/employeeProject/employee/add.jsp">Añadir</a></li>
						<%} %>
					</ul>
				</li>
					
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						Proyectos</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="/employeeProject/project/list.jsp">Listar</a></li>
						<% if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
						<li><a class="dropdown-item" href="/employeeProject/project/add.jsp">Añadir</a></li>
						<%} %>
					</ul>
				</li>
			
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						Compañías</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="/employeeProject/company/list.jsp">Listar</a></li>
						<li><a class="dropdown-item" href="/employeeProject/company/listAdvance.jsp">Listar ampliado</a></li>
						<% if (session.getAttribute("role")!= null && session.getAttribute("role").equals("admin")){ %>
						<li><a class="dropdown-item" href="/employeeProject/company/add.jsp">Añadir</a></li>
						<%} %>
					</ul>
				</li>
				<li><a class="nav-link dropdown-toggle" href="/employeeProject/job.jsp">Trabajar</a></li>
				

			</ul>
			<% if (session.getAttribute("idEmployee")!= null ){ %>
				<a class="navbar-brand" href="/employeeProject/employee/show.jsp?id=<%= session.getAttribute("idEmployee")%>"><%= session.getAttribute("idEmployee")%></a>
				
				
			<%} %>
			<a class="navbar-brand" href="/employeeProject/index.jsp">Salir</a>
			

		</div>
	</div>
</nav>