package com.skilldistillery.bilingualbuddies.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class AlertTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Alert alert;

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

		alert = em.find(Alert.class, 1);

	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();

		alert = null;

	}

	@Test
	void test_basic_mappings() {

		assertNotNull(alert);
		assertEquals("Learn English", alert.getContent());
	}

	@Test
	void test_RM_OneToMany_to_sentAlerts_user() {
		assertNotNull(alert);
		assertEquals(2, alert.getReceiver().getId());

	}

	@Test
	void test_RM_OneToMany_to_alerts_user() {
		assertNotNull(alert);
		assertEquals(1, alert.getSender().getId());

	}

	@Test
	void test_RM_meetup_Alert() {
		assertNotNull(alert);
		assertEquals(1, alert.getMeetup().getId());
	}

}
