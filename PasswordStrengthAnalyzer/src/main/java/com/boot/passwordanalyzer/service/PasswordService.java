package com.boot.passwordanalyzer.service;

import org.springframework.stereotype.Service;

import com.boot.passwordanalyzer.DTO.PasswordResponse;

@Service
public interface PasswordService {
	 PasswordResponse analyzePassword(String password);

}
