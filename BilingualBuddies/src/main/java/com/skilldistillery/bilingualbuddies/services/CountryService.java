package com.skilldistillery.bilingualbuddies.services;

import java.util.List;

import com.skilldistillery.bilingualbuddies.entities.Country;

public interface CountryService {
	public List<Country> index();

	public Country findCountry(String countryCode);

}
