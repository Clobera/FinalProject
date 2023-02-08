package com.skilldistillery.bilingualbuddies.services;

import java.util.Set;

import com.skilldistillery.bilingualbuddies.entities.User;

public interface UserService {

	 	public Set<User> index();

	    public User findById(int userId);

	    public User show(String username, int userId);

	    public User create(User user);

	    public User update(String username, int userId, User user);

	    public boolean destroy(String username, int userId);
}
