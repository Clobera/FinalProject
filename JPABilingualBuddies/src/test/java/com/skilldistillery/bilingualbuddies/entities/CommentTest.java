package com.skilldistillery.bilingualbuddies.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CommentTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;
	

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABilingualBuddies");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}


	@Test
	void test() {
		assertNotNull(comment);
		assertEquals("I agree!", comment.getContent());
	}

	@Test
	void test_RM_ManyToOne_to_Post() {
		assertNotNull(comment);
		assertEquals("This is so cool!", comment.getPost().getContent());
	}
	
	@Test
	void test_RM_ManyToOne_to_User() {
		assertNotNull(comment);
		assertEquals("admin", comment.getPost().getUser().getFirstName());
	}


}