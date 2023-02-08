package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDateTime;
import java.time.LocalTime;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Meetup {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "meetup_date")
	private LocalDateTime meetupDate;

	private String content;
	
	@ManyToOne
	 @JoinColumn(name = "address_id")
	 private Address address;
	
	private Boolean enabled;
	
	@ManyToOne
	@JoinColumn(name = "owner_id")
	private User owner;
		
	@ManyToOne
	@JoinColumn(name = "team_id")
	private Team team;
	
	@ManyToMany
	@JoinTable(name="user_has_meetup", 
		joinColumns=@JoinColumn(name = "user_id"),
		inverseJoinColumns=@JoinColumn(name="event_id"))
	private List<User> attendees;
	
	
	@Column(name = "start_time")
	private LocalTime startTime;

	@Column(name = "end_time")
	private LocalTime endTime;

	@Column(name = "created_date")
	@CreationTimestamp
	private LocalDateTime createdDate;

	@Column(name = "image_url")
	private String imgUrl;

	private String title;

	public Meetup() {
		super();
	}

	public Meetup(int id, LocalDateTime meetupDate, String content, Address address, Boolean enabled, Team team,
			LocalTime startTime, LocalTime endTime, LocalDateTime createdDate, String imgUrl, String title) {
		super();
		this.id = id;
		this.meetupDate = meetupDate;
		this.content = content;
		this.address = address;
		this.enabled = enabled;
		this.team = team;
		this.startTime = startTime;
		this.endTime = endTime;
		this.createdDate = createdDate;
		this.imgUrl = imgUrl;
		this.title = title;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getMeetupDate() {
		return meetupDate;
	}

	public void setMeetupDate(LocalDateTime meetupDate) {
		this.meetupDate = meetupDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public LocalTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}

	public LocalTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalTime endTime) {
		this.endTime = endTime;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
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
		Meetup other = (Meetup) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Meetup [id=" + id + ", meetupDate=" + meetupDate + ", content=" + content + ", address=" + address
				+ ", enabled=" + enabled + ", startTime=" + startTime + ", endTime=" + endTime + ", createdDate="
				+ createdDate + ", imgUrl=" + imgUrl + ", title=" + title + "]";
	}

}
