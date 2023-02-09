package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Meetup {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "meetup_date")
	private LocalDate meetupDate;

	private String content;

	@ManyToOne
	@JoinColumn(name = "address_id")
	private Address address;

	private Boolean enabled;

	@ManyToOne
	@JoinColumn(name = "owner_id")
	private User owner;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "team_id")
	private Team team;

	@ManyToMany
	@JoinTable(name = "user_has_meetup", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "event_id"))
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

	@JsonIgnore
	@OneToMany(mappedBy = "meetup")
	private List<Alert> alerts;

	// MTM add remove methods
	public void addMeetup(User member) {
		if (attendees == null) {
			attendees = new ArrayList<>();
		}
		if (!attendees.contains(member)) {
			attendees.add(member);
			member.addMeetup(this);
		}
	}

	public void removeMeetup(User member) {
		if (attendees != null && attendees.contains(member)) {
			attendees.remove(member);
			member.removeMeetup(this);
		}
	}

	public Meetup() {
		super();
	}

	public Meetup(int id, LocalDate meetupDate, String content, Address address, Boolean enabled, User owner, Team team,
			List<User> attendees, LocalTime startTime, LocalTime endTime, LocalDateTime createdDate, String imgUrl,
			String title, List<Alert> alerts) {
		super();
		this.id = id;
		this.meetupDate = meetupDate;
		this.content = content;
		this.address = address;
		this.enabled = enabled;
		this.owner = owner;
		this.team = team;
		this.attendees = attendees;
		this.startTime = startTime;
		this.endTime = endTime;
		this.createdDate = createdDate;
		this.imgUrl = imgUrl;
		this.title = title;
		this.alerts = alerts;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getMeetupDate() {
		return meetupDate;
	}

	public void setMeetupDate(LocalDate meetupDate) {
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

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	public List<User> getAttendees() {
		return attendees;
	}

	public void setAttendees(List<User> attendees) {
		this.attendees = attendees;
	}

	public List<Alert> getAlerts() {
		return alerts;
	}

	public void setAlerts(List<Alert> alerts) {
		this.alerts = alerts;
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
