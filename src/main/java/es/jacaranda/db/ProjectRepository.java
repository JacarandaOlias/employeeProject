package es.jacaranda.db;



import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import es.jacaranda.exception.CompanyProjectException;
import es.jacaranda.exception.DbException;
import es.jacaranda.exception.EmployeeProjectException;
import es.jacaranda.exception.ProjectException;
import es.jacaranda.model.CompanyProject;
import es.jacaranda.model.EmployeeProject;
import es.jacaranda.model.Project;

public class ProjectRepository extends DbRepository{

	
	
	public static ArrayList<EmployeeProject> getEmployeeProjects(Integer idProject) throws EmployeeProjectException, DbException  {
		ArrayList<EmployeeProject> listEmployeeProject = null;
		Session session=null;
		
		if (idProject == null ) {
			throw new EmployeeProjectException("Es necesario identificador el projecto");
		}
		try {
			session = DbUtil.getSessionFactory().openSession();
			SelectionQuery<EmployeeProject> queryEmployeeProject = session
					.createNativeQuery("Select * From employeeProject where idProject = ?1", EmployeeProject.class);

			queryEmployeeProject.setParameter(1,idProject);
			listEmployeeProject = (ArrayList<EmployeeProject>) queryEmployeeProject.getResultList();
			
		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
		session.close();
		return listEmployeeProject;
	}

	
	public static ArrayList<CompanyProject> getCompanyProjects(Integer idProject) throws CompanyProjectException, DbException {
		ArrayList<CompanyProject> listCompanyProject = null;
		Session session=null;
		
		if (idProject == null ) {
			throw new CompanyProjectException("Es necesario identificar el projecto");
		}
		try {
			session = DbUtil.getSessionFactory().openSession();
			SelectionQuery<CompanyProject> queryCompanyProject = session
					.createNativeQuery("Select * From companyProject where idProject = ?1", CompanyProject.class);
			queryCompanyProject.setParameter(1,idProject);
			listCompanyProject =  (ArrayList<CompanyProject>) queryCompanyProject.getResultList();
			
		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
		session.close();
		return listCompanyProject;
	}
		
	public static void delete(Project project) throws DbException, ProjectException  {
		if (project.getId() == null) {
			throw new ProjectException("Es necesario identificador la compañía");
		}
		Transaction transaction = null;
		Session session=null;
		try {
			session = DbUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new DbException("Error al conectar con la base de datos");
		}
		try {
			ArrayList<CompanyProject> listCompanyProject = (ArrayList<CompanyProject>) project.getListCompanyProject();
			for (CompanyProject companyProject : listCompanyProject) {
				session.remove(companyProject);
			}
			ArrayList<EmployeeProject> listEmployeeProject = (ArrayList<EmployeeProject>) project.getListEmployeeProject();
			for (EmployeeProject employeeProject : listEmployeeProject) {
				session.remove(employeeProject);
			}
			session.remove(project);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			session.close();
			throw new DbException("Error al borrar el objeto: " + e.getMessage());
		}

	}

}

