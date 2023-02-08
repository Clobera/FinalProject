package com.skilldistillery.bilingualbuddies.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Country {

	@Id
	@Column(name = "country_code")
	private String countryCode;

	private String country;

	@OneToMany(mappedBy = "country")
	private List<User> users;

	public Country() {
		super();
	}

	public Country(String countryCode, String country, List<User> users) {
		super();
		this.countryCode = countryCode;
		this.country = country;
		this.users = users;
	}

	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	@Override
	public int hashCode() {
		return Objects.hash(countryCode);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Country other = (Country) obj;
		return Objects.equals(countryCode, other.countryCode);
	}

	@Override
	public String toString() {
		return "Country [countryCode=" + countryCode + ", country=" + country + ", users=" + users + "]";
	}

}
