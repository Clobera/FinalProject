package com.skilldistillery.bilingualbuddies.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.bilingualbuddies.entities.Post;

@RestController
@RequestMapping("api")
@CrossOrigin({"*","http://localhost/"})
public class PostController {
	
//	@Autowired
//	PostService pService;
	
	@GetMapping("posts")
	public List<Post> index(HttpServletRequest req, HttpServletResponse res){
		//return pService.index();
		return null;
	}
	
	@GetMapping("posts/{id}")
	public Post findById(@PathVariable Integer id, HttpServletResponse res) {
		//return pService.show(id);
		return null;
	}
	
	@PostMapping("posts")
	public Post newPost(@RequestBody Post post, HttpServletResponse res, HttpServletRequest req) {
		try {
			//pService.createPost(post);
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

}
