package com.skilldistillery.bilingualbuddies.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Language {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	@OneToMany(mappedBy = "language")
	private List<LanguageResource> resources;

	public Language() {
		super();
	}

	public Language(int id, String name, String description, List<LanguageResource> resources) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.resources = resources;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<LanguageResource> getResources() {
		return resources;
	}

	public void setResources(List<LanguageResource> resources) {
		this.resources = resources;
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
		Language other = (Language) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Language [id=" + id + ", name=" + name + ", description=" + description + ", resources=" + resources
				+ "]";
	}

}
