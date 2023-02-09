package com.skilldistillery.bilingualbuddies.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Country;
import com.skilldistillery.bilingualbuddies.repositories.CountryRepository;

@Service
public class CountryServiceImpl implements CountryService {
	@Autowired
	private CountryRepository countryRepo;

	@Override
	public List<Country> index() {
		return countryRepo.findAll();
	}

	@Override
	public Country findCountry(String countryCode) {
		Country country = countryRepo.findByCountryCode(countryCode);
		return country;
	}

}
