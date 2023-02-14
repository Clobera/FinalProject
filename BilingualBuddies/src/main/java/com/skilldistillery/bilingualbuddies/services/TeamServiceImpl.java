package com.skilldistillery.bilingualbuddies.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Team;
import com.skilldistillery.bilingualbuddies.entities.User;
import com.skilldistillery.bilingualbuddies.repositories.TeamRepository;
import com.skilldistillery.bilingualbuddies.repositories.UserRepository;

@Service
public class TeamServiceImpl implements TeamService {
	
	@Autowired
	private TeamRepository teamRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public Team findById(int id) {
		Optional<Team> teamOpt = teamRepo.findById(id);
		Team team = null;
		if(teamOpt.isPresent()) {
			team = teamOpt.get();
		}
		return team;
	}

	@Override
	public List<Team> findAllTeams() {
		
		return teamRepo.findAll();
	}
	
	@Override
	public Team finByUser(String user) {
		
		return teamRepo.findByOwnerUsername(user);
	}

	@Override
	public Team createTeam(Team team, String username) {
		User user = userRepo.findByUsername(username);
		if(user == null || user.getMyTeam() != null) {
			return null;
		} 
		user.setMyTeam(team);
		team.setOwner(user);
		team.setEnabled(true);
		teamRepo.saveAndFlush(team);
		return team;
	}

	@Override
	public Team update(int id, Team team, User loggedInUser) {
		Team teamUpdate = findById(id);
		if(teamUpdate != null) {
			teamUpdate.setName(team.getName());
			teamUpdate.setContent(team.getContent());
			teamUpdate.setImageUrl(team.getImageUrl());
			if(team.getMembers().size() < teamUpdate.getMembers().size()) {
				User user = userRepo.findByUsername(team.getMembers().get(team.getMembers().size() - 1).getUsername());
				teamUpdate.addUser(user);
				user = userRepo.saveAndFlush(user);
			}
			if(team.getMembers().size() > teamUpdate.getMembers().size()) {
				loggedInUser = userRepo.findByUsername(loggedInUser.getUsername());
				teamUpdate.removeUser(loggedInUser);
				loggedInUser = userRepo.saveAndFlush(loggedInUser);
			}
			teamUpdate = teamRepo.saveAndFlush(teamUpdate);
		}
		return teamUpdate;
	}

	@Override
	public boolean destroy(int id) {
		Team deleteMe = findById(id);
		boolean deleted = false;
		if(deleteMe != null) {
			deleteMe.setEnabled(false);
			deleted = true;
			teamRepo.saveAndFlush(deleteMe);
		}
		return deleted;
	}

}
