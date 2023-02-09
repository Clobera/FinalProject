package com.skilldistillery.bilingualbuddies.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Post;

public interface PostRepository extends JpaRepository<Post, Integer> {

	public List<Post> findByUser_Id(int userId);
}
