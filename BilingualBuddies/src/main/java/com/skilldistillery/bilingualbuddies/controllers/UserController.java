package com.skilldistillery.bilingualbuddies.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.bilingualbuddies.entities.User;
import com.skilldistillery.bilingualbuddies.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*","http://localhost/"})
public class UserController {
	
	@Autowired
	UserService userService;
	
	
	@GetMapping("users")
	public List<User> index(Principal principal, HttpServletRequest req, HttpServletResponse res){
		List<User> users = userService.index();
		for (User user : users) {
			user.getLanguages().size();
		}
		return users;
	}
	
	@GetMapping("users/{username}")
	public User show(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable String username) {
		
		return userService.show(username);
				
	}
	
	@PutMapping("users/{username}")
	public User update(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable String username, @RequestBody User user) {
		try {
			user= userService.update( username, user );
			if(user == null) {
				res.setStatus(404);
			}
		} catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			user = null;
		}
		return user;
	}
	@DeleteMapping("users/{username}")
	public void delete(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable String username) {
		try {
			if(userService.destroy(username)) {
				res.setStatus(204);
			}
			else {
				res.setStatus(404);
			}
		} catch(Exception e){
			e.printStackTrace();
			res.setStatus(400);
		}
	}
	
}
