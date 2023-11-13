package es.jacaranda.db;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import es.jacaranda.exception.CompanyException;
import es.jacaranda.exception.CompanyProjectException;
import es.jacaranda.exception.DbException;
import es.jacaranda.model.Company;
import es.jacaranda.model.CompanyProject;
import es.jacaranda.model.Employee;

public class CompanyRepository extends DbRepository{

	public static ArrayList<Employee> getEmployee(Integer idCompany) throws CompanyException, DbException {
		ArrayList<Employee> listEmployee = null;
		Session session=null;

		if (idCompany == null) {
			throw new CompanyException("Es necesario identificador la compañía");
		}
		try {
			session = DbUtil.getSessionFactory().openSession();
			SelectionQuery<Employee> queryEmployee = session
					.createNativeQuery("Select * From employee where idCompany = ?1", Employee.class);
			queryEmployee.setParameter(1, idCompany);
			listEmployee = (ArrayList<Employee>) queryEmployee.getResultList();

		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
		session.close();
		return listEmployee;
	}

	public static ArrayList<CompanyProject> getCompanyProject(Integer idCompany)
			throws CompanyProjectException, DbException {
		ArrayList<CompanyProject> listCompanyProject = null;
		Session session=null;

		if (idCompany == null) {
			throw new CompanyProjectException("Es necesario identificador la compañía");
		}
		try {
			session = DbUtil.getSessionFactory().openSession();
			SelectionQuery<CompanyProject> queryCompanyProject = session
					.createNativeQuery("Select * From companyProject where idCompany = ?1", CompanyProject.class);
			queryCompanyProject.setParameter(1, idCompany);
			listCompanyProject = (ArrayList<CompanyProject>) queryCompanyProject.getResultList();

		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
		session.close();
		return listCompanyProject;
	}

	public static void delete(Company company) throws CompanyProjectException, DbException {
		if (company.getId() == null) {
			throw new CompanyProjectException("Es necesario identificador la compañía");
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
			ArrayList<CompanyProject> listCompanyProject = (ArrayList<CompanyProject>) company.getListCompanyProject();
			for (CompanyProject companyProject : listCompanyProject) {
				session.remove(companyProject);
			}
			ArrayList<Employee> listEmployee = (ArrayList<Employee>) company.getListEmployee();
			for (Employee employee : listEmployee) {
				session.remove(employee);
			}
			session.remove(company);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			throw new DbException("Error al borrar el objeto: " + e.getMessage());
		}

	}

}
