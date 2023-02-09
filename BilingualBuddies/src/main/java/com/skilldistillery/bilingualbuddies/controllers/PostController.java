package com.skilldistillery.bilingualbuddies.controllers;

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

import com.skilldistillery.bilingualbuddies.entities.Post;
import com.skilldistillery.bilingualbuddies.services.PostService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*","http://localhost/"})
public class PostController {
	
	@Autowired
	PostService pService;
	
	@GetMapping("posts")
	public List<Post> index(HttpServletRequest req, HttpServletResponse res){
		return pService.index();
		
	}
	
	@GetMapping("posts/{id}")
	public Post findById(@PathVariable Integer id, HttpServletResponse res) {
		return pService.findById(id);
		
	}

	@GetMapping("users/{uid}/posts")
	public List<Post> findByUserId(@PathVariable Integer uid, HttpServletResponse res) {
		return pService.findByUserId(uid);
		
	}
	
	@PostMapping("posts")
	public Post newPost(@RequestBody Post post, HttpServletResponse res, HttpServletRequest req) {
		try {
			pService.create(post);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(post.getId());
			res.setHeader("Location", url.toString());
		} catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			post = null;
		}
		return post;
	}
	
	@PutMapping("posts/{id}")
	public Post updatePost(@RequestBody Post post, @PathVariable Integer id, HttpServletResponse res, HttpServletRequest req) {
		try {
			post = pService.update(id, post);
			if(post == null) {
				res.setStatus(404);
			}
		} catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			post = null;
		}
		return post;
	}
	@DeleteMapping("posts/{id}")
	public void delete(HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id) {
		try {
			if(pService.destroy(id)) {
				res.setStatus(204);
			}
			else {
				res.setStatus(404);
			}
		} catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
	}

}
