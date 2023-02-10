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

import com.skilldistillery.bilingualbuddies.entities.Language;
import com.skilldistillery.bilingualbuddies.services.LanguageService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost" })
public class LanguageController {
	@Autowired
	private LanguageService langService;

	@GetMapping("languages")
	public List<Language> index(HttpServletResponse res, HttpServletRequest req) {
		return langService.index();

	}

	@GetMapping("languages/{name}")
	public Language show(HttpServletResponse res, HttpServletRequest req, @PathVariable String name) {
		
		Language lang = langService.findLanguage(name);
		try {
			if (lang != null) {
				res.setStatus(200);
				return lang;
			} else {
				res.setStatus(400);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			lang = null;
		}
		return lang;

	}

}
