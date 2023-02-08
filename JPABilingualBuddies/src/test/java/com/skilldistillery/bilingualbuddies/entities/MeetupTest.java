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

class MeetupTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Meetup meetup;
	

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
		meetup = em.find(Meetup.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		meetup = null;
	}


	@Test
	void test() {
		assertNotNull(meetup);
		assertEquals("Meet Here to Learn English", meetup.getContent());
		assertEquals("English Time", meetup.getTitle());
	}

	@Test
	void test_RM_meetup_address() {
		assertNotNull(meetup);
		assertEquals("Lakewood", meetup.getAddress().getCity());
		assertEquals("Colorado", meetup.getAddress().getState());
	}

}