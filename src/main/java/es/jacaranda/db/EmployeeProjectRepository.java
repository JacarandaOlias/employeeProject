package es.jacaranda.db;





import org.hibernate.Session;

import es.jacaranda.exception.DbException;
import es.jacaranda.exception.EmployeeProjectException;
import es.jacaranda.model.EmployeeProject;

public class EmployeeProjectRepository extends DbRepository{

	
	
	
	public static EmployeeProject find(EmployeeProject employeeProject) throws  DbException, EmployeeProjectException {
		
		Session session= null;
		EmployeeProject result = null;
		
		if (employeeProject == null ) {
			throw new EmployeeProjectException("Es necesario identificador el objeto");
		}
		try {
			session = DbUtil.getSessionFactory().openSession();
			result = session.find(EmployeeProject.class, employeeProject);
			
		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
		session.close();
		return result;
	}
		
}

