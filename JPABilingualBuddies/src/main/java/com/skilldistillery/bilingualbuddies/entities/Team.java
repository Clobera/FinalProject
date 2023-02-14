package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Team {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	
	@OneToOne
	@JoinColumn(name = "owner_id")
	private User owner;

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

	
	@ManyToMany
	@JoinTable(name = "team_has_member", joinColumns = @JoinColumn(name = "group_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> members;

	public Team() {
		super();
	}

	public Team(int id, User owner, String content, String imageUrl, String name, LocalDateTime createdAt,
			Boolean enabled, List<Meetup> meetups, List<User> members) {
		super();
		this.id = id;
		this.owner = owner;
		this.content = content;
		this.imageUrl = imageUrl;
		this.name = name;
		this.createdAt = createdAt;
		this.enabled = enabled;
		this.meetups = meetups;
		this.members = members;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

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

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public List<Meetup> getMeetups() {
		return meetups;
	}

	public void setMeetups(List<Meetup> meetups) {
		this.meetups = meetups;
	}

	public List<User> getMembers() {
		return members;
	}

	public void setMembers(List<User> members) {
		this.members = members;
	}
	
	//MTM add remove methods
		public void addUser(User user) {
			if(members == null) {
				members = new ArrayList<>();
			}
			if (! members.contains(user)) {
				members.add(user);
				user.addTeam(this);
			}
		}
		
		public void removeUser(User user) {
			if (members != null && members.contains(user)) {
				members.remove(user);
				user.removeTeam(this);
			}
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
		return "Team [id=" + id + ", content=" + content + ", imageUrl=" + imageUrl + ", name="
				+ name + ", createdAt=" + createdAt + ", enabled=" + enabled + ", meetups=" + meetups +"]";
	}

}
