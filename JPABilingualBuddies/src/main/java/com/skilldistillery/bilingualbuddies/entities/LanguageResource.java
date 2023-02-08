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

	@JoinColumn(name = "added_by")
	@ManyToOne
	private User user;

	@CreationTimestamp
	@Column(name = "create_date")
	private LocalDateTime createDate;

	public LanguageResource() {
		super();
	}

	public LanguageResource(int id, String name, String resourceUrl, String description, Language language, User user,
			LocalDateTime createDate) {
		super();
		this.id = id;
		this.name = name;
		this.resourceUrl = resourceUrl;
		this.description = description;
		this.language = language;
		this.user = user;
		this.createDate = createDate;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
				+ description + ", language=" + language + ", user=" + user + ", createDate=" + createDate + "]";
	}

}
