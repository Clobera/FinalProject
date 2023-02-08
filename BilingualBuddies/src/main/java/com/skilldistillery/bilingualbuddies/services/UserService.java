package com.skilldistillery.bilingualbuddies.services;

import java.util.List;

import com.skilldistillery.bilingualbuddies.entities.User;

public interface UserService {

	 	public List<User> index();

	    public User findById(int userId);

	    public User show(String username);

	    public User create(User user);

	    public User update(String username, User user);

	    public boolean destroy(String username);
}
