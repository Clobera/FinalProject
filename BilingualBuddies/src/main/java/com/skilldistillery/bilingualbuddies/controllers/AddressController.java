package com.skilldistillery.bilingualbuddies.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.bilingualbuddies.entities.Address;
import com.skilldistillery.bilingualbuddies.services.AddressService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class AddressController {

	@Autowired
	AddressService addressService;

	@GetMapping(path = "addresses")
	public List<Address> listAddress(HttpServletRequest req, HttpServletResponse res) {
		return addressService.findAllAdress();
	}

	@GetMapping(path = "addresses/{id}")
	public Address show(HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id) {
		return addressService.findById(id);
	}

	@PostMapping("addresses")
	public Address create(HttpServletRequest req, HttpServletResponse res, @RequestBody Address address) {
		try {
			addressService.createAddress(address);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(address.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			address = null;
		}
		return address;
	}

	@PutMapping("addresses/{id}")
	public Address update(HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id,
			@RequestBody Address address) {
		try {
			address = addressService.update(id, address);
			if (address == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			address = null;
		}
		return address;
	}

	@DeleteMapping("addresses/{id}")
	public void delete(HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id) {
		try {
			if (addressService.destroy(id)) {
				res.setStatus(204);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}

	}
}
