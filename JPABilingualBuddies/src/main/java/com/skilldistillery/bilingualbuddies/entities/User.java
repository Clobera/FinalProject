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

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String email;

	private String username;

	private String password;

	@Column(name = "date_created")
	private LocalDateTime dateCreated;

	@Column(name = "last_login")
	private LocalDateTime lastLogin;

	private boolean enabled;

	private String role;

	private boolean sponsor;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	@Column(name = "image_url")
	private String imageUrl;

	private String bio;

	@OneToMany(mappedBy = "post")
	private List<Comment> comments;

	public User() {
		super();
	}

	public User(int id, String email, String username, String password, LocalDateTime dateCreated,
			LocalDateTime lastLogin, boolean enabled, String role, boolean sponsor, String firstName, String lastName,
			String imageUrl, String bio, List<Comment> comments) {
		super();
		this.id = id;
		this.email = email;
		this.username = username;
		this.password = password;
		this.dateCreated = dateCreated;
		this.lastLogin = lastLogin;
		this.enabled = enabled;
		this.role = role;
		this.sponsor = sponsor;
		this.firstName = firstName;
		this.lastName = lastName;
		this.imageUrl = imageUrl;
		this.bio = bio;
		this.comments = comments;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public boolean isSponsor() {
		return sponsor;
	}

	public void setSponsor(boolean sponsor) {
		this.sponsor = sponsor;
	}

	public LocalDateTime getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(LocalDateTime dateCreated) {
		this.dateCreated = dateCreated;
	}

	public LocalDateTime getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(LocalDateTime lastLogin) {
		this.lastLogin = lastLogin;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", email=" + email + ", username=" + username + ", password=" + password
				+ ", dateCreated=" + dateCreated + ", lastLogin=" + lastLogin + ", enabled=" + enabled + ", role="
				+ role + ", sponsor=" + sponsor + ", firstName=" + firstName + ", lastName=" + lastName + ", imageUrl="
				+ imageUrl + ", bio=" + bio + ", comments=" + comments + "]";
	}

}
