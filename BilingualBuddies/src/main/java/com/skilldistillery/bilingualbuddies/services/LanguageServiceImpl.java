package com.skilldistillery.bilingualbuddies.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Language;
import com.skilldistillery.bilingualbuddies.repositories.LangeuageRepository;

@Service
public class LanguageServiceImpl implements LanguageService {
	
	@Autowired
	private LangeuageRepository langRepo;

	@Override
	public List<Language> index() {
		return langRepo.findAll();
	}

	@Override
	public Language findLanguage(String name) {
		return langRepo.findByName(name);
	}

	@Override
	public Language findLanguageByCode(String code) {
		return langRepo.findByCode(code);
	}
	
	
}
