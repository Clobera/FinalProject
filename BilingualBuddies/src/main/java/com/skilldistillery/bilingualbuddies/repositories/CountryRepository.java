package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Country;

public interface CountryRepository extends JpaRepository<Country, Integer> {
	Country findByCountryCode(String countryCode);

}
