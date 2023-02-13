package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Team;

public interface TeamRepository extends JpaRepository<Team, Integer> {
	Team findByName(String name);

	Team findByOwnerUsername(String username);
}
