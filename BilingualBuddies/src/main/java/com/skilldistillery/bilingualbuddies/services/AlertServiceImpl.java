package com.skilldistillery.bilingualbuddies.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Alert;
import com.skilldistillery.bilingualbuddies.entities.User;
import com.skilldistillery.bilingualbuddies.repositories.AlertRepository;
import com.skilldistillery.bilingualbuddies.repositories.UserRepository;

@Service
public class AlertServiceImpl implements AlertService {

	@Autowired
	private AlertRepository alertRepo;

	@Autowired
	private UserRepository userRepo;

	@Override
	public Alert findById(int alertId) {
		Optional<Alert> alertOpt = alertRepo.findById(alertId);
		Alert alert = null;
		if (alertOpt.isPresent()) {
			alert = alertOpt.get();
		}
		return alert;
	}

	@Override
	public List<Alert> findByReceiver(int receiverId) {
		List<Alert> alerts = alertRepo.findAlertByReceiverId(receiverId);
		return alerts;
	}

	@Override
	public Alert create(Alert alert) {
		User sender = alert.getSender();
		System.out.print(alert);
		alert.setMeetup(null);
		User receiver = alert.getReceiver();
System.out.print(receiver);
		Optional<User> optSender = userRepo.findById(sender.getId());
		Optional<User> optReceiver = userRepo.findById(receiver.getId());

		if (optSender.isPresent() && optReceiver.isPresent()) {
			sender = optSender.get();
			receiver = optReceiver.get();
			
			alert.setSender(sender);
			alert.setReceiver(receiver);
			
			alertRepo.saveAndFlush(alert);
			return alert;
		}

		return null;
	}

//	@Override
//	public Alert update(int alertId, Alert alertUpdates) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	// this method doesn't delete(faux deletes by changing if it was seen or not.)
	@Override
	public boolean destroy(int alertId) {
		Alert deleteMe = findById(alertId);
		boolean deleted = false;
		if (deleteMe != null) {
			deleteMe.setSeen(false);
			deleted = true;
		}
		return deleted;
	}

}
