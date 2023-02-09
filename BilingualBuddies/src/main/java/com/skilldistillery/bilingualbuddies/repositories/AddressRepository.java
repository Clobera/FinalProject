package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Address;

public interface AddressRepository extends JpaRepository<Address, Integer>{
	
	
}
