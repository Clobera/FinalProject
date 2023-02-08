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

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Alert {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "sender_id")
	private User sender;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "receiver_id")
	private User receiver;

	@ManyToOne
	@JoinColumn(name = "meetup_id")
	private Meetup meetup;

	private String content;

	@CreationTimestamp
	@Column(name = "notification_date")
	private LocalDateTime notificationDate;

	private Boolean seen;


	public Alert() {
		super();
	}

	public Alert(int id, User sender, User receiver, Meetup meetup, String content, LocalDateTime notificationDate,
			Boolean seen) {
		super();
		this.id = id;
		this.sender = sender;
		this.receiver = receiver;
		this.meetup = meetup;
		this.content = content;
		this.notificationDate = notificationDate;
		this.seen = seen;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public User getReceiver() {
		return receiver;
	}

	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}

	public Meetup getMeetup() {
		return meetup;
	}

	public void setMeetup(Meetup meetup) {
		this.meetup = meetup;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getNotificationDate() {
		return notificationDate;
	}

	public void setNotificationDate(LocalDateTime notificationDate) {
		this.notificationDate = notificationDate;
	}

	public Boolean getSeen() {
		return seen;
	}

	public void setSeen(Boolean seen) {
		this.seen = seen;
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
		Alert other = (Alert) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Alert [id=" + id + ", sender=" + sender + ", receiver=" + receiver + ", meetup=" + meetup + ", content="
				+ content + ", notificationDate=" + notificationDate + ", seen=" + seen + "]";
	}

}
