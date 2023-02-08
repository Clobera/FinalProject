package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.LanguageResource;

public interface LangeuageResourceRepository extends JpaRepository<LanguageResource, Integer> {
LanguageResource findLanguageResourceByName(String name);
}
