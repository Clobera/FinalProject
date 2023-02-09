package com.skilldistillery.bilingualbuddies.services;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.skilldistillery.bilingualbuddies.entities.Meetup;

public interface MeetupService {
	public List<Meetup> index();

	public Meetup findById(int meetupId);

	public List<Meetup> findByDate(LocalDate meetupDate);

	public Meetup show(String meetupName);

	public Meetup create(Meetup meetup);

	public Meetup update(String meetupName, Meetup meetupUpdates);

	public boolean destroy(String meetupName);

}
