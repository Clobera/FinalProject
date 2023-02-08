package com.skilldistillery.bilingualbuddies.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.bilingualbuddies.entities.Alert;

public interface AlertRepository extends JpaRepository<Alert, Integer> {
Alert findAlertBySenderId(int Id);
}
