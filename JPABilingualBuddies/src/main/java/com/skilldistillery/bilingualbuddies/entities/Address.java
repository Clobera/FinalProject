package com.skilldistillery.bilingualbuddies.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Address {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String address;

	private String city;

	private String state;

	@Column(name = "postal_code")
	private String postalCode;

	private Boolean enabled;
	
	public Address() {
		super();
	}

	@Override
	public String toString() {
		return "Address [id=" + id + ", address=" + address + ", city=" + city + ", state=" + state + ", postalCode="
				+ postalCode + ", enabled=" + enabled + ", user=" + user + ", meetup=" + meetup + ", meetups=" + meetups
				+ "]";
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Meetup> getMeetup() {
		return meetup;
	}

	public void setMeetup(List<Meetup> meetup) {
		this.meetup = meetup;
	}

	@OneToOne(mappedBy="address")
	private User user;
	
	@OneToMany(mappedBy="address")
	private List<Meetup> meetup;

	@OneToMany(mappedBy = "address")
	private List<Meetup> meetups;

	public Address() {
		super();
	}

	public Address(int id, String address, String city, String state, String postalCode, Boolean enabled
			,List<Meetup> meetups) {
		super();
		this.id = id;
		this.address = address;
		this.city = city;
		this.state = state;
		this.postalCode = postalCode;
		this.enabled = enabled;
		this.meetups = meetups;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
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
		Address other = (Address) obj;
		return id == other.id;
	}

}
