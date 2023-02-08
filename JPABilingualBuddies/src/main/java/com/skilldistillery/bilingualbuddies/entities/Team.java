package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

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

	private Boolean enabled;

	@OneToMany(mappedBy = "team")
	private List<Meetup> meetups;

	public Team() {
		super();
	}

	public Team(int id, String content, String imageUrl, String name, LocalDateTime createdAt, Boolean enabled,
			List<Meetup> meetups) {
		super();
		this.id = id;
		this.content = content;
		this.imageUrl = imageUrl;
		this.name = name;
		this.createdAt = createdAt;
		this.enabled = enabled;
		this.meetups = meetups;
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
		this.createdAt = createdAt;
	}

	public List<Meetup> getMeetups() {
		return meetups;
	}

	public void setMeetups(List<Meetup> meetups) {
		this.meetups = meetups;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
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

	@Override
	public String toString() {
		return "Team [id=" + id + ", content=" + content + ", imageUrl=" + imageUrl + ", name=" + name + ", createdAt="
				+ createdAt + ", enabled=" + enabled + ", meetups=" + meetups + "]";
	}

}
