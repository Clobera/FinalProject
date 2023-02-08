package com.skilldistillery.bilingualbuddies.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Comment;
import com.skilldistillery.bilingualbuddies.entities.Post;
import com.skilldistillery.bilingualbuddies.repositories.CommentRepository;
import com.skilldistillery.bilingualbuddies.repositories.PostRepository;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private CommentRepository commentRepo;
	
	@Autowired
	private PostRepository postRepo;
	
	@Override
	public List<Comment> findAllComments(int postId) {
		List<Comment> comments = null;
		if(commentRepo.findByPost_Id(postId).size() > 0) {
			comments = commentRepo.findByPost_Id(postId);
		}
		
		return comments;
	}
	
	@Override
	public Comment findById(int id) {
		Optional<Comment> commentOpt = commentRepo.findById(id);
		Comment comment = null;
		if (commentOpt.isPresent()) {
		  comment = commentOpt.get();
		}
		
		return comment;
	}
	
	@Override
	public Comment createComment(int postId, Comment comment) {
		
		Optional<Post> postOpt = postRepo.findById(postId);
		if (postOpt.isPresent()) {
		  comment.setPost(postOpt.get());
		  
		  return commentRepo.saveAndFlush(comment);
		}
		
		return null;
	}
	
	@Override
	public boolean deleteCommentById(int commentId) {
		Comment deleteMe = findById(commentId);
		boolean deleted = false;
		if(deleteMe != null) {
			commentRepo.delete(deleteMe);
			deleted = true;
		}
		return deleted;
	}
	

}
