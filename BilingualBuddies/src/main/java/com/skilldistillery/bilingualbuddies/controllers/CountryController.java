package com.skilldistillery.bilingualbuddies.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.bilingualbuddies.entities.Country;

@RestController
@RequestMapping("api")
@CrossOrigin({"*","http://localhost/"})
public class CountryController {
	
//	@Autowired
//	CountryService countryService;
	
	@GetMapping("countries")
	public List<Country> index(HttpServletResponse res, HttpServletRequest req){
		//return countryService.index();
		return null;
	}
	
	@GetMapping("countries/{name}")
	public Country show(HttpServletResponse res, HttpServletRequest req, @PathVariable String name) {
		//return countryService.show(name);
		return null;
	}
}
	
	