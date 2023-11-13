package es.jacaranda.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import es.jacaranda.exception.CompanyException;
import es.jacaranda.exception.CompanyProjectException;
import es.jacaranda.exception.DbException;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="company")
public class Company {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	private String name;
	private String address;
	private String city;
	
	//@OneToMany(fetch = FetchType.EAGER, mappedBy="company")
	@OneToMany(mappedBy="company")
	List<Employee> listEmployee;
	
	@OneToMany(mappedBy="company")
	List<CompanyProject> listCompanyProject;

	
	
	public Company() {
		super();
		this.listEmployee = new ArrayList<Employee>();
		this.listCompanyProject = new ArrayList<CompanyProject>();
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	

	public List<Employee> getListEmployee() {
		return listEmployee;
	}

	public List<CompanyProject> getListCompanyProject() {
		return listCompanyProject;
	}

	public void setListEmployee(List<Employee> listEmployee) {
		this.listEmployee = listEmployee;
	}

	

	public void setListCompanyProject(List<CompanyProject> listCompanyProject) {
		this.listCompanyProject = listCompanyProject;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Company other = (Company) obj;
		return id == other.id;
	}
	
	
	
	
	
	
}
