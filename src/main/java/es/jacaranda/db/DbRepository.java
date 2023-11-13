package es.jacaranda.db;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.jacaranda.exception.DbException;
import es.jacaranda.exception.EmployeeException;
import es.jacaranda.model.Employee;

public class DbRepository {
	
	/**
	 * 
	 * @param idEmployee
	 * @param password
	 * @return
	 * @throws DbException
	 * @throws EmployeeException
	 */
	public static String findUser(String idEmployee, String password) throws DbException, EmployeeException {
		Employee employee = null;
		String role= null;
		int idEmployeeInt;
		if (idEmployee == null || password == null) {
			throw new EmployeeException("Es necesario identificador y password para loguearse");
		}
		try {
			idEmployeeInt = Integer.parseInt(idEmployee);
			
		} catch (Exception e) {
			throw new EmployeeException("El username debe ser un número");

		}
		employee = find(Employee.class, idEmployeeInt);
		if (employee.getPassword().equals(password)) {
			role = employee.getRole();
		}
		
		return role;
	}
	/**
	 * 
	 * @param <E>
	 * @param c
	 * @param id
	 * @return
	 * @throws DbException
	 */
	public static <E> E find(Class c, int id) throws DbException{
		E result=null;
		Session session=null;
		try {
			session = DbUtil.getSessionFactory().openSession();
		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
				
		result = (E) session.find(c, id);

		session.close();
		return result;
	}
	/**
	 * 
	 * @param <E>
	 * @param c
	 * @return
	 * @throws DbException
	 */
	public static <E> ArrayList<E> findAll(Class c) throws DbException{
		ArrayList<E> result=null;
		Session session=null;
		try {
			session = DbUtil.getSessionFactory().openSession();
			result = (ArrayList<E>) session.createSelectionQuery("From "+ c.getName()).getResultList();

		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos. " + e.getMessage());
		}
		session.close();
		return result;
	}

	/**
	 * 
	 * @param <E>
	 * @param object
	 * @return
	 * @throws DbException
	 */
	public static <E> E save(E object) throws DbException{
		E result=null;
		Transaction transaction=null;
		Session session=null;
		try {
			session = DbUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos");
		}		
		
			
		try {
			
			session.persist(object);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			throw new DbException("Error al crear el objeto");
		}	
		
		session.close();
		return result;
	}
	
	
	public static <E> E update(E object) throws DbException{
		E result=null;
		Transaction transaction=null;
		Session session=null;
		try {
			session = DbUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			session.close();
			throw new DbException("Error al conectar con la base de datos");
		}		
		
		try {	
			session.merge(object);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			throw new DbException("Error al modificar el objeto." + e.getMessage());
		}	
		
		session.close();
		return result;
	}
	public static <E> void delete(E object) throws DbException{
		Transaction transaction=null;
		Session session=null;
		try {
			session = DbUtil.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new DbException("Error al conectar con la base de datos");
		}		

		try {
			session.remove(object);
			transaction.commit();
		} catch (Exception e) {
			session.close();
			transaction.rollback();
			throw new DbException("Error al borrar el objeto");
		}
		session.close();
	}
	

}

