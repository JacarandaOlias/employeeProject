package es.jacaranda.db;



import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import es.jacaranda.exception.DbException;
import es.jacaranda.exception.EmployeeException;
import es.jacaranda.exception.EmployeeProjectException;
import es.jacaranda.model.Employee;
import es.jacaranda.model.EmployeeProject;

public class EmployeeRepository extends DbRepository{

	public static ArrayList<EmployeeProject> getEmployeeProjects(Integer idEmployee) throws  DbException, EmployeeProjectException {
		ArrayList<EmployeeProject> listEmployeeProject = null;
		Session session=null;
		
		if (idEmployee == null ) {
			throw new EmployeeProjectException("Es necesario identificador la compañía");
		}
		try {
			session = DbUtil.getSessionFactory().openSession();
			SelectionQuery<EmployeeProject> queryEmployeeProject = session.createSelectionQuery("From EmployeeProject,Employee where Empoyee.id = ?1", EmployeeProject.class);
			queryEmployeeProject.setParameter(1,idEmployee);
			listEmployeeProject =  (ArrayList<EmployeeProject>) queryEmployeeProject.getResultList();
			
		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
		session.close();
		return listEmployeeProject;
	}
	
	public static void delete(Employee employee) throws DbException, EmployeeException  {
		if (employee == null || employee.getId() == null) {
			throw new EmployeeException("Es necesario identificador la compañía");
		}
		Transaction transaction = null;
		Session session;
		try {
			session = DbUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new DbException("Error al conectar con la base de datos");
		}
		try {
			
			ArrayList<EmployeeProject> listEmployeeProject = (ArrayList<EmployeeProject>) employee.getListEmployeeProject();
			for (EmployeeProject employeeProject : listEmployeeProject) {
				session.remove(employeeProject);
			}
			session.remove(employee);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			session.close();
			throw new DbException("Error al borrar el objeto: " + e.getMessage());
		}
		session.close();

	}
		
}

