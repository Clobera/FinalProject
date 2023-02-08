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

class CountryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Country country;

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
		country = em.find(Country.class, "US");
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		country = null;
	}

	@Test
	void test_basic_mappings() {
		assertNotNull(country);
		assertEquals("US", country.getCountryCode());
	}

	@Test
	void test_MTM_mappings_to_language() {
		assertNotNull(country);
		assertTrue(country.getLangauges().size() > 0);
	}

}
