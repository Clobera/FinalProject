package com.skilldistillery.bilingualbuddies.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Alert {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	// Sender ID User Many to one mapping goes here
	@OneToMany
	@JoinColumn(name="sender_id")
	private User sender;
	
	
	// reciever ID User Many to one mapping goes here
	@OneToMany
	@JoinColumn(name="receiver_id")
	private User receiver;
	
	
	
	// meetup ID many to one mapping goes here
	@OneToMany
	@JoinColumn(name="meetup_id")
	private Meetup meetup;
	
	
	private String content;
	
	@CreationTimestamp
	@Column(name = "notification_date")
	private LocalDateTime notificationDate;
	
	private Boolean seen;

	
	public Alert() {
		super();
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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Alert [id=" + id + ", content=" + content + ", notificationDate=" + notificationDate + ", seen="
				+ seen + "]";
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
	
	
	
}
