package com.skilldistillery.bilingualbuddies.services;

import java.util.List;

import com.skilldistillery.bilingualbuddies.entities.Address;

public interface AddressService {
	
	public Address findById(int addressId);
	
	public List<Address> findAllAdress(int addressid);
	
	public Address createAddress(Address address);
	
	public Address update(int addressId, Address address);
	
	public boolean destroy(int addressId);

}
