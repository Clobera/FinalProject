package com.skilldistillery.bilingualbuddies.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
	Comment findByUser_username(String username);

	List<Comment> findByPost_Id(int postId);
}
