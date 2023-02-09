package com.skilldistillery.bilingualbuddies.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Meetup;
import com.skilldistillery.bilingualbuddies.entities.Post;
import com.skilldistillery.bilingualbuddies.repositories.PostRepository;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostRepository postRepo;

	@Override
	public List<Post> index() {
		return postRepo.findAll();
	}

	@Override
	public Post findById(int postId) {
		Optional<Post> postOpt = postRepo.findById(postId);
		Post post = null;
		if (postOpt.isPresent()) {
			post = postOpt.get();
		}
		return post;
	}

	@Override
	public Post findByUserId(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Post create(Post post) {
		postRepo.saveAndFlush(post);
		return post;
	}

	@Override
	public Post update(int postId, Post postUpdates) {
		Post output = findById(postId);
		if (output != null) {
			output.setContent(postUpdates.getContent());
			output.setImageUrl(postUpdates.getImageUrl());
			
			output = postRepo.saveAndFlush(output);
		}
		
		return output;
	}

	@Override
	public boolean destroy(int postId) {
		Post deleteMe = findById(postId);
		boolean deleted = false;
		if (deleteMe != null) {
			deleteMe.setEnabled(false);
			deleted = true;
			postRepo.saveAndFlush(deleteMe);
		}
		return deleted;
	}

}
