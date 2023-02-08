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

class PostTest {

		
		private static EntityManagerFactory emf;
		private EntityManager em;
		private Post post;
		

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
			post = em.find(Post.class, 1);
		}

		@AfterEach
		void tearDown() throws Exception {
			em.close();
			post = null;
		}

		@Test
		void test() {
			assertNotNull(post);
			assertEquals("This is so cool!", post.getContent()); 
		}
		
		@Test
		void test_ManyToOne_to_users() {
			assertNotNull(post);
			assertEquals("admin", post.getUser().getFirstName()); 
		}


	}

