package com.skilldistillery.bilingualbuddies.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Address;
import com.skilldistillery.bilingualbuddies.repositories.AddressRepository;

@Service
public class AddressServiceImpl implements AddressService {
	
	@Autowired
	private AddressRepository addressRepo;

	@Override
	public Address findById(int addressId) {
		Optional<Address> addressOpt = addressRepo.findById(addressId);
		Address address = null;
		if(addressOpt.isPresent()) {
			address = addressOpt.get();
		}
		return address;
	}

	@Override
	public List<Address> findAllAdress(int addressid) {
		
		return addressRepo.findAll();
	}

	@Override
	public Address createAddress(Address address) {
		addressRepo.saveAndFlush(address);
		return address;
	}

	@Override
	public Address update(int addressId, Address address) {
		Address addressUpdate = findById(addressId);
		if(addressUpdate != null) {
			addressUpdate.setAddress(address.getAddress());
			addressUpdate.setCity(address.getCity());
			addressUpdate.setPostalCode(address.getPostalCode());
			addressUpdate.setState(address.getState());
			
			addressUpdate = addressRepo.saveAndFlush(addressUpdate);
		}
		return addressUpdate;
	}

	@Override
	public boolean destroy(int addressId) {
		Address deleteMe = findById(addressId);
		boolean deleted = false;
		if(deleteMe != null) {
			deleteMe.setEnabled(false);
			deleted = true;
			addressRepo.saveAndFlush(deleteMe);
		}
		return deleted;
	}

}
