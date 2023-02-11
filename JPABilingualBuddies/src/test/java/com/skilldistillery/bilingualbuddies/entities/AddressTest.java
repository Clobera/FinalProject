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

class AddressTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address address;
	

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
		address = em.find(Address.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		address = null;
	}


	@Test
	void test() {
		assertNotNull(address);
		assertEquals("80215", address.getPostalCode());
		assertEquals("Lakewood", address.getCity());
		assertEquals("Colorado", address.getState());
	}

	@Test
	void test_RM_address_meetup() {
		address = em.find(Address.class, 2);
		assertNotNull(address);
		System.out.println(address.getMeetups().size());
		assertTrue(address.getMeetups().size() > 0);
		
		
	}

	
//	uncomment and finish this test when proper address is added to db.
//	@Test
//	void test_RM_address_user() {
//		assertNotNull(address);
//		assertEquals(1, address.getUser().getId());
//	}
//	
	


}
