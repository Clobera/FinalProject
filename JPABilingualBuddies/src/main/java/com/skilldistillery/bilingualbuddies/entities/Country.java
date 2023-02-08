package com.skilldistillery.bilingualbuddies.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Country {

	@Id
	@Column(name = "country_code")
	private String countryCode;

	private String country;
	
	@JsonIgnore
	@OneToMany(mappedBy = "country")
	private List<User> users;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name="country_has_language",
			joinColumns=@JoinColumn(name="country_country_code"),
			inverseJoinColumns = @JoinColumn(name="language_id")
			)
	private List<Language> langauges;

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

	public List<Language> getLangauges() {
		return langauges;
	}

	public void setLangauges(List<Language> langauges) {
		this.langauges = langauges;
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
