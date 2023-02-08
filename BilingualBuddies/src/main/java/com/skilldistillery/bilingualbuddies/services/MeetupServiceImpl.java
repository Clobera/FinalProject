package com.skilldistillery.bilingualbuddies.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Meetup;
import com.skilldistillery.bilingualbuddies.repositories.MeetupRepository;

@Service
public class MeetupServiceImpl implements MeetupService {

	@Autowired
	private MeetupRepository meetupRepo;

	@Override
	public List<Meetup> index() {
		return meetupRepo.findAll();
	}

	@Override
	public Meetup findById(int meetupId) {
		Optional<Meetup> meetupOpt = meetupRepo.findById(meetupId);
		Meetup meetup = null;
		if (meetupOpt.isPresent()) {
			meetup = meetupOpt.get();
		}
		return meetup;
	}

	@Override
	public Meetup findByDate(LocalDateTime meetupDate) {
		Meetup meetup = meetupRepo.findMeetupByDate(meetupDate);
		return meetup;
	}

	//NOT SURE WHICHONE IS WHAT WE WANT TO USE.
	
//	@Override
//	public List<Meetup> findByDate(LocalDateTime meetupDate) {
//		List<Meetup> meetup = (List<Meetup>) meetupRepo.findMeetupByDate(meetupDate);
//		return meetup;
//	}

	@Override
	public Meetup show(String meetupName) {
		
		return null;
	}

	@Override
	public Meetup create(Meetup meetup) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Meetup update(String meetupName, Meetup meetupUpdates) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String meetupName) {
		// TODO Auto-generated method stub
		return false;
	}

}
