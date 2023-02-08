package com.skilldistillery.bilingualbuddies.repositories;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Meetup;

public interface MeetupRepository extends JpaRepository<Meetup, Integer> {

Meetup findByMeetupDate(LocalDateTime meetupDate);

	Meetup findMeetupByDate(LocalDateTime meetupDate);

	Meetup findMeetupByTitle(String meetupTitle);

}
