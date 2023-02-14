package com.skilldistillery.bilingualbuddies.controllers;

import java.security.Principal;
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

import com.skilldistillery.bilingualbuddies.entities.Team;
import com.skilldistillery.bilingualbuddies.entities.User;
import com.skilldistillery.bilingualbuddies.services.TeamService;
import com.skilldistillery.bilingualbuddies.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*","http://localhost/"})
public class TeamController {
	
	@Autowired
	TeamService teamService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("teams")
	public List<Team> index(HttpServletRequest req, HttpServletResponse res){
		List<Team> teams = teamService.findAllTeams();
		
		for(Team team : teams) {
			team.getMembers().size();
		}
		return teams;
	}
	
	@GetMapping("teams/{id}")
	public Team show(HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id) {
		return teamService.findById(id);
	}
	
	@GetMapping("teams/myTeam")
	public Team show(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		Team team = teamService.finByUser(principal.getName());		
		return team;
	}
	
	@PostMapping("teams")
	public Team create(Principal principal, HttpServletRequest req, HttpServletResponse res, @RequestBody Team team) {
		try {
			teamService.createTeam(team, principal.getName());
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(team.getId());
			res.setHeader("Location", url.toString());
		} catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			team = null;
		}
		return team;
	
	}
	@PutMapping("teams/{id}")
	public Team update(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id, @RequestBody Team team) {
		try {
			User user = userService.show(principal.getName());
			team = teamService.update(id, team, user );
			if(team == null) {
				res.setStatus(404);
			}
		} catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			team = null;
		}
		return team;
	}
	
	@DeleteMapping("teams/{id}")
	public void delete(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable Integer id) {
		try {
			if(teamService.destroy(id)) {
				res.setStatus(204);
			}
			else {
				res.setStatus(404);
			}
		} catch(Exception e){
			e.printStackTrace();
			res.setStatus(400);
		}
	}
	

}
