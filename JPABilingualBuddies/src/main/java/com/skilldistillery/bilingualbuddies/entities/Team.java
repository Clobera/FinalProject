package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Team {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

//	@Column(name = "owner_id")
//	private int ownerId;

	private String content;

	@Column(name = "image_url")
	private String imageUrl;

	private String name;


	@CreationTimestamp
	@Column(name = "create_date")
	private LocalDateTime createdAt;
	

	public Team() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Team(int id, String content, String imageUrl, String name, LocalDateTime createdAt) {
		super();
		this.id = id;
//		this.ownerId = ownerId;
		this.content = content;
		this.imageUrl = imageUrl;
		this.name = name;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

//	public int getOwnerId() {
//		return ownerId;
//	}

//	public void setOwnerId(int ownerId) {
//		this.ownerId = ownerId;
//	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreateDate(LocalDateTime createdAt) {
		this.createdAt= createdAt;
	}

	@Override
	public String toString() {
		return "Group [id=" + id + ", content=" + content + ", imageUrl=" + imageUrl
				+ ", name=" + name + ", createDate=" + createdAt + "]";
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
		Team other = (Team) obj;
		return id == other.id;
	}

}
