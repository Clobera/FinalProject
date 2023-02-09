package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Language;

public interface LangeuageRepository extends JpaRepository<Language, Integer> {
	Language findLanuageByName(String name);
}
