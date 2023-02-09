package com.skilldistillery.bilingualbuddies.controllers;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServlet;
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

import com.skilldistillery.bilingualbuddies.entities.Meetup;
import com.skilldistillery.bilingualbuddies.services.MeetupService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class MeetupController {

	@Autowired
	MeetupService meetupService;

	@GetMapping("meetups")
	public List<Meetup> index(Principal principal, HttpServletRequest req, HttpServletResponse res) {
		return meetupService.index();
	}

	@GetMapping("meetups/{name}")
	public Meetup show(Principal principal, HttpServletRequest req, HttpServletResponse res,
			@PathVariable String name) {
		return meetupService.show(name);
	}
	
	@GetMapping("meetups/{date}")
	public Meetup findByDate(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable LocalDateTime date) {
		return meetupService.findByDate(date);
	}

	@PostMapping("meetups")
	public Meetup create(Principal principal, HttpServletRequest req, HttpServletResponse res,
			@RequestBody Meetup meetup) {
		try {
			meetupService.create(meetup);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(meetup.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			meetup = null;
		}
		return meetup;
	}

	@PutMapping("meetups/{name}")
	public Meetup update(Principal principal, HttpServletRequest req, HttpServletResponse res,
			@PathVariable String name, @RequestBody Meetup meetup) {
		try {
			meetup = meetupService.update(name, meetup);
			if (meetup == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			meetup = null;
		}
		return meetup;
	}

	@DeleteMapping("meetups/{name}")
	public void delete(Principal principal, HttpServletRequest req, HttpServletResponse res,
			@PathVariable String name) {
		try {
			if (meetupService.destroy(name)) {
				res.setStatus(204);
			}

			else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}

	}
}
