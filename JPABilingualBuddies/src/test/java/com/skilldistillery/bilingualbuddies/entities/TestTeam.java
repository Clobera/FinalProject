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

class TestTeam {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Team team;
	
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
		team = em.find(Team.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		team = null;
	}

	@Test
	void test() {
		
		assertNotNull(team);
		assertEquals(1, team.getId());
		assertEquals("https://d3mvlb3hz2g78.cloudfront.net/wp-content/uploads/2020/11/thumb_720_450_dreamstime_m_44810592_(1).jpg", team.getImageUrl());
		assertEquals("Better People Better World", team.getName());
	}

}
