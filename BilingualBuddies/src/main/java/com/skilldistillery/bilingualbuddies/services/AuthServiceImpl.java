package com.skilldistillery.bilingualbuddies.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Language;
import com.skilldistillery.bilingualbuddies.entities.User;
import com.skilldistillery.bilingualbuddies.repositories.AddressRepository;
import com.skilldistillery.bilingualbuddies.repositories.LangeuageRepository;
import com.skilldistillery.bilingualbuddies.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private PasswordEncoder encoder;

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private AddressRepository addrRepo;

	@Autowired
	private LangeuageRepository langRepo;
	
	
	@Override
	public User register(User user) {
		user.setPassword(encoder.encode(user.getPassword()));
		user.setEnabled(true);
		user.setRole("standard");
		
		addrRepo.saveAndFlush(user.getAddress());
		user = userRepo.saveAndFlush(user);
		Language lang = user.getLanguages().get(0);
		Optional<Language> opt = langRepo.findById(lang.getId());
		if (opt.isPresent()) {
			lang = opt.get();
			lang.getUsers().add(user);
			lang = langRepo.saveAndFlush(lang);
		}
		
		return user;
	}
	
	

	@Override
	public User getUserByUsername(String username) {
		return userRepo.findByUsername(username);

	}
	
	

}
