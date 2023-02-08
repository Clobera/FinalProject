package com.skilldistillery.bilingualbuddies.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
	

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}

	@Test
	void test_OneToOne_address() {
		assertNotNull(user);
		assertEquals(null, user.getAddress());
	}

	@Test
	void test_ManyToOne_country() {
		assertNotNull(user);
		assertEquals("United States", user.getCountry().getCountry());
	}

	@Test
	void test_oneToOne_team() {
		assertNotNull(user);
		assertEquals("Better People Better World", user.getMyTeam().getName());
	}
	@Test
	void test_RM_ManyToMany_to_language() {
		assertNotNull(user);
		assertTrue(user.getLanguages().size() > 0);
			
	}
	
	@Test
	void test_RM_OneToMany_to_sentAlerts_Alert() {
		assertNotNull(user);
		assertTrue(user.getSentAlert().size() > 0);
			
	}
	@Test
	void test_RM_OneToMany_to_alerts_Alert() {
		User user2 = em.find(User.class, 2);
		assertNotNull(user2);
		assertTrue(user2.getAlerts().size() > 0);
		user2 = null;
		
	}


}
