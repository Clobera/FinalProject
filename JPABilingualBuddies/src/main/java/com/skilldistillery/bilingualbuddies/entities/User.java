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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

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

	@JsonIgnore
	@OneToOne(mappedBy = "owner")
	private Team myTeam;

	@ManyToMany(mappedBy = "members")
	private List<Team> memberOfTeams;
	
	@JsonIgnore
	@ManyToMany(mappedBy="owner")
	private List<Meetup> myMeetups;

	
	@ManyToMany(mappedBy="attendees")
	private List<Meetup> memberOfMeetups;

	@ManyToOne
	@JoinColumn(name = "origin_country")
	private Country country;
	
	@ManyToMany(mappedBy="users")
	private List<Language> languages;

	@OneToMany(mappedBy = "user")
	private List<Comment> comments;

	@OneToMany(mappedBy = "user")
	private List<Post> posts;

	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;
	
	@OneToMany(mappedBy="sender")
	private List<Alert> sentAlert;

	@OneToMany(mappedBy="receiver")
	private List<Alert> alerts;
	
	@OneToMany(mappedBy = "addedBy")
	private List<LanguageResource> languageResource;
	
	
	// MTO/OTM add remove methods
	public void addComment(Comment comment) {
		if (comments == null ) {
			comments = new ArrayList<>();
		}
		if (! comments.contains(comment)) {
			comments.add(comment);
			comment.getUser().removeComment(comment);
		}
		comment.setUser(this);
	}
	
	public void removeComment(Comment comment) {
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setUser(null);
		}
	}
	
	
	//MTM add remove methods
	public void addMeetup(Meetup member) {
		if(memberOfMeetups == null) {
			memberOfMeetups = new ArrayList<>();
		}
		if (! memberOfMeetups.contains(member)) {
			memberOfMeetups.add(member);
			member.addMeetup(this);
		}
	}
	
	public void removeMeetup(Meetup member) {
		if (memberOfMeetups != null && memberOfMeetups.contains(member)) {
			memberOfMeetups.remove(member);
			member.removeMeetup(this);
		}
	}

	public User() {
		super();
	}

	public User(int id, String email, String username, String password, LocalDateTime dateCreated,
			LocalDateTime lastLogin, boolean enabled, String role, boolean sponsor, String firstName, String lastName,
			String imageUrl, String bio, Country country, List<Comment> comments, Address address) {
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
		this.country = country;
		this.comments = comments;
		this.address = address;
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

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public Team getMyTeam() {
		return myTeam;
	}

	public void setMyTeam(Team myTeam) {
		this.myTeam = myTeam;
	}

	public List<Team> getMemberOfTeams() {
		return memberOfTeams;
	}

	public void setMemberOfTeams(List<Team> memberOfTeams) {
		this.memberOfTeams = memberOfTeams;
	}

	
	public List<Language> getLanguages() {
		return languages;
	}

	public void setLanguages(List<Language> languages) {
		this.languages = languages;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	
	

	public List<Alert> getSentAlert() {
		return sentAlert;
	}

	public void setSentAlert(List<Alert> sentAlert) {
		this.sentAlert = sentAlert;
	}

	public List<Alert> getAlerts() {
		return alerts;
	}

	public void setAlerts(List<Alert> alerts) {
		this.alerts = alerts;
	}
	

	public List<LanguageResource> getLanguageResource() {
		return languageResource;
	}

	public void setLanguageResource(List<LanguageResource> languageResource) {
		this.languageResource = languageResource;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	public List<Meetup> getMyMeetups() {
		return myMeetups;
	}

	public void setMyMeetups(List<Meetup> myMeetups) {
		this.myMeetups = myMeetups;
	}

	public List<Meetup> getMemberOfMeetups() {
		return memberOfMeetups;
	}

	public void setMemberOfMeetups(List<Meetup> memberOfMeetups) {
		this.memberOfMeetups = memberOfMeetups;
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
				+ imageUrl + ", bio=" + bio + ", myTeam=" + myTeam + ", memberOfTeams=" + memberOfTeams + ", country="
				+ country + ", languages=" + languages + ", comments=" + comments + ", address=" + address
				+ ", sentAlert=" + sentAlert + ", alerts=" + alerts + ", languageResource=" + languageResource + "]";
	}

}
