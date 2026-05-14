package com.boot.passwordanalyzer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.boot.passwordanalyzer.model.PasswordHistory;

@Repository
public interface PasswordHistoryRepository extends JpaRepository<PasswordHistory,Long>{
	 boolean existsByPassword(String password);

}
