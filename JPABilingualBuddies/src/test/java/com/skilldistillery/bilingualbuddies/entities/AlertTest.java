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

//	@Test
//	void test_basic_mappings() {
//		assertNotNull(alert);
//		assertEquals("admin", alert.getContent());
//	}

//	@Test
//	void test_MTO_OTO_OTM_mappings() {
//		assertNotNull(address);
//		fail("not implemented yet");
//	}

}
