package com.skilldistillery.bilingualbuddies.services;

import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.User;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public Set<User> index() {
		return userRepo.findAll();
	}

//	findById and show do the same thing just with different parameters
	@Override
	public User findById(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		return user;
	}

	@Override
	public User show(String username) {
		User user = userRepo.findByUsername(username);
		return user;
	}

	@Override
	public User create(User user) {
		User sendMe = todoRepo.saveAndFlush(user);
		return sendMe;
	}

	@Override
	public User update(String username, int userId, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int userId) {
		// TODO Auto-generated method stub
		return false;
	}

}
