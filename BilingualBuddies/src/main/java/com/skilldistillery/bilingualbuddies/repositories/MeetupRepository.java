package com.skilldistillery.bilingualbuddies.repositories;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Meetup;

public interface MeetupRepository extends JpaRepository<Meetup, Integer> {

	List<Meetup> findByMeetupDate(LocalDate meetupDate);

	Meetup findMeetupByTitle(String meetupTitle);

}
