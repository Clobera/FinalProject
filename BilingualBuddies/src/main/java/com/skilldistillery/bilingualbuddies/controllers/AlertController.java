package com.skilldistillery.bilingualbuddies.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.bilingualbuddies.entities.Alert;
import com.skilldistillery.bilingualbuddies.services.AlertService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class AlertController {

	@Autowired
	AlertService alertService;

	@GetMapping(path = "alerts")
	public List<Alert> listAlerts(@PathVariable int id) {
		List<Alert> alerts = alertService.findByReceiver(id);

		return alerts;
	}

	@GetMapping("alerts/{id}")
	public Alert show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id) {
		return alertService.findById(id);

	}

	@PostMapping("alerts")
	public Alert create(HttpServletRequest req, HttpServletResponse res, @RequestBody Alert alert
			) {
		try {
			alertService.create(alert);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(alert.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			alert = null;
		}
		return null;
	}

}
