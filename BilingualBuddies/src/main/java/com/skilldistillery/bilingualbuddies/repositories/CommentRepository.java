package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
Comment findCommentByUsername(String username);
}
