package com.skilldistillery.bilingualbuddies.services;

import java.util.List;

import com.skilldistillery.bilingualbuddies.entities.Language;

public interface LanguageService {
	
	public List<Language> index();

	public Language findLanguage(String name);
	
	public Language findLanguageByCode(String code);

}
