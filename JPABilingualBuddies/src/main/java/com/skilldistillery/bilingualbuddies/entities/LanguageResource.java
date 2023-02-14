package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "language_resource")
public class LanguageResource {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@Column(name = "resource_url")
	private String resourceUrl;

	private String description;

	// languageId
	
	@JoinColumn(name = "language_id")
	@ManyToOne
	private Language language;

	@CreationTimestamp
	@Column(name = "create_date")
	private LocalDateTime createDate;
	
	@ManyToOne
	@JoinColumn(name = "added_by")
	private User addedBy;

	public LanguageResource() {
		super();
	}


	public LanguageResource(int id, String name, String resourceUrl, String description, Language language,
			LocalDateTime createDate, User addedBy) {
		super();
		this.id = id;
		this.name = name;
		this.resourceUrl = resourceUrl;
		this.description = description;
		this.language = language;
		this.createDate = createDate;
		this.addedBy = addedBy;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getResourceUrl() {
		return resourceUrl;
	}

	public void setResourceUrl(String resourceUrl) {
		this.resourceUrl = resourceUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Language getLanguage() {
		return language;
	}

	public void setLanguage(Language language) {
		this.language = language;
	}
	

	public User getAddedBy() {
		return addedBy;
	}

	public void setAddedBy(User addedBy) {
		this.addedBy = addedBy;
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
		LanguageResource other = (LanguageResource) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "LanguageResource [id=" + id + ", name=" + name + ", resourceUrl=" + resourceUrl + ", description="
				+ description + ", language=" + language + ", createDate=" + createDate + ", addedBy=" + addedBy + "]";
	}



}
