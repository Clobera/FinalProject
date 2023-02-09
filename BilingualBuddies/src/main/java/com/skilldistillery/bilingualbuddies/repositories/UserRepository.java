package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	User findByUsername(String username);
}
