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

@RestController
@RequestMapping("api")
@CrossOrigin({"*","http://localhost/"})
public class UserController {
	
	@Autowired
	//UserService userService;
	
	
	@GetMapping("users")
	public List<User> index(Principal principal, HttpServletRequest req, HttpServletResponse res){
		return null;
		
		//return userService.index(principal.getName());
	}
	
	@GetMapping("users/{id}")
	public User show(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int id) {
		return null;
		//return userService.show(principal.getName(), id);
				
	}
	@PostMapping("users")
	public User create(Principal principal ,HttpServletRequest req, HttpServletResponse res, @RequestBody User user) {
//		try {
//			userService.create(principal.getName(), user);
//			res.setStatus(201);
//			StringBuffer url = req.getRequestURL();
//			url.append("/").append(user.getId());
//			res.setHeader("Location", url.toString());
//		} catch(Exception e) {
//			e.printStackTrace();
//			res.setStatus(400);
//			user = null;
//		}
//		return user;
		return null;
	}
	
	@PutMapping("users/{id}")
	public User update(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id, @RequestBody User user) {
//		try {
//			user= userService.update(principal.getName(), id, user );
//			if(user == null) {
//				res.setStatus(404);
//			}
//		} catch(Exception e) {
//			e.printStackTrace();
//			res.setStatus(400);
//			user = null;
//		}
//		return user;
		return null;
	}
	@DeleteMapping("users/{id}")
	public void delete(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id) {
//		try {
//			if(userService.destroy(principal.getName()), id) {
//				res.setStatus(204);
//			}
//			else {
//				res.setStatus(404);
//			}
//		} catch(Exception e){
//			e.printStackTrace();
//			res.setStatus(400);
//		}
	}
}
