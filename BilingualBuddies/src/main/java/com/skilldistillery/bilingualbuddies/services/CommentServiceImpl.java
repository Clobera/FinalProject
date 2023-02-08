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
		if (commentRepo.findByPost_Id(postId).size() > 0) {
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
	public boolean deleteCommentById(int postId, int commentId) {
		boolean deleted = false;
		Post post = new Post();
		Comment deleteMe = new Comment();

		Optional<Post> postOpt = postRepo.findById(postId);
		if (postOpt.isPresent()) {
			post = postOpt.get();

			Optional<Comment> comment = commentRepo.findById(commentId);
			if (comment.isPresent()) {
				deleteMe = comment.get();

				List<Comment> comments = post.getComments();
				int num = comments.indexOf(deleteMe);
				if (num != -1) {
					deleteMe = comments.get(num);
					post.removeComment(deleteMe);
					postRepo.saveAndFlush(post);
					deleteMe.setEnabled(false);
					deleted = true;
					commentRepo.saveAndFlush(deleteMe);
				}

			}

		}

		return deleted;
	}

}
