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
		Meetup meetup = meetupRepo.findMeetupByTitle(meetupName);
		return meetup;
	}

	@Override
	public Meetup create(Meetup meetup) {
		meetupRepo.saveAndFlush(meetup);
		return meetup;
	}

	@Override
	public Meetup update(String meetupName, Meetup meetupUpdates) {
		Meetup output = show(meetupName);
		if (output != null) {
			output.setMeetupDate(meetupUpdates.getMeetupDate());
			output.setContent(meetupUpdates.getContent());
			output.setStartTime(meetupUpdates.getStartTime());
			output.setEndTime(meetupUpdates.getEndTime());
			output.setImgUrl(meetupUpdates.getImgUrl());
			output.setTitle(meetupUpdates.getTitle());
			
			output = meetupRepo.saveAndFlush(output);
		}
		return output;
	}

	@Override
	public boolean destroy(String meetupName) {
		Meetup deleteMe = show(meetupName);
		boolean deleted = false;
		if (deleteMe != null) {
			deleteMe.setEnabled(false);
			deleted = true;
			meetupRepo.saveAndFlush(deleteMe);
		}
		return deleted;
	}

}
