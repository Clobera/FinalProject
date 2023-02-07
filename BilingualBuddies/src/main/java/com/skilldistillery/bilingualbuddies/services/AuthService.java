package com.skilldistillery.bilingualbuddies.services;

import com.skilldistillery.bilingualbuddies.entities.User;

public interface AuthService {

	
	public User register(User user);
	public User getUserByUsername(String username);
}
