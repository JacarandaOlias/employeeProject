package es.jacaranda.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import es.jacaranda.exception.CompanyProjectException;
import es.jacaranda.exception.DbException;
import es.jacaranda.exception.EmployeeProjectException;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "project")
public class Project {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	private String name;
	private String butget;
	
	@OneToMany(mappedBy="project")
	List<CompanyProject> listCompanyProject;

	@OneToMany(mappedBy="project")
	List<EmployeeProject> listEmployeeProject;

	public Project() {
		super();
		this.listCompanyProject = new ArrayList<CompanyProject>();
		this.listEmployeeProject = new ArrayList<EmployeeProject>();
		
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

	public String getButget() {
		return butget;
	}

	public void setButget(String butget) {
		this.butget = butget;
	}

	
	public void setListCompanyProject(List<CompanyProject> listCompanyProject) {
		this.listCompanyProject = listCompanyProject;
	}

	
	public List<CompanyProject> getListCompanyProject() {
		return listCompanyProject;
	}

	public List<EmployeeProject> getListEmployeeProject() {
		return listEmployeeProject;
	}

	public void setListEmployeeProject(List<EmployeeProject> listEmployeeProject) {
		this.listEmployeeProject = listEmployeeProject;
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
		Project other = (Project) obj;
		return id == other.id;
	}
	
	
	

}
