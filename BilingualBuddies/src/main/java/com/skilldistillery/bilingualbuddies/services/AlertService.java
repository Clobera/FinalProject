package com.skilldistillery.bilingualbuddies.services;

import com.skilldistillery.bilingualbuddies.entities.Alert;

public interface AlertService {
	public Alert findById(int alertId);

	public Alert create(Alert alert);

//	public Alert update(int alertId, Alert alertUpdates);

	public boolean destroy(int alertId);

}
