package com.skilldistillery.bilingualbuddies.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.bilingualbuddies.entities.Country;
import com.skilldistillery.bilingualbuddies.services.CountryService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class CountryController {

	@Autowired
	CountryService countryService;

	@GetMapping("countries")
	public List<Country> index(HttpServletResponse res, HttpServletRequest req) {
		return countryService.index();

	}

	@GetMapping("countries/{cc}")
	public Country show(HttpServletResponse res, HttpServletRequest req, @PathVariable String cc) {
		return countryService.findCountry(cc);

	}
}
