package com.skilldistillery.bilingualbuddies.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.bilingualbuddies.entities.Alert;
import com.skilldistillery.bilingualbuddies.repositories.AlertRepository;

@Service
public class AlertServiceImpl implements AlertService {

	@Autowired
	private AlertRepository alertRepo;

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
		alertRepo.saveAndFlush(alert);
		return alert;
	}

//	@Override
//	public Alert update(int alertId, Alert alertUpdates) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	
	//this method doesn't delete(faux deletes by changing if it was seen or not.)
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
