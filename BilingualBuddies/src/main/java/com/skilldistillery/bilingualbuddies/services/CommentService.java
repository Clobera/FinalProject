package com.skilldistillery.bilingualbuddies.services;

import java.util.List;

import com.skilldistillery.bilingualbuddies.entities.Comment;

public interface CommentService {

	List<Comment> findAllComments(int postId);
	
	Comment findById(int id);

	Comment createComment(int postId, Comment comment);
	
	boolean deleteCommentById(int commentId);
}
