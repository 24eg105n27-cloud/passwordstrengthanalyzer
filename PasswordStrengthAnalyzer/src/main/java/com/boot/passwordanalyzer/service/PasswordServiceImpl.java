package com.boot.passwordanalyzer.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.passwordanalyzer.PasswordStrengthAnalyzerApplication;
import com.boot.passwordanalyzer.DTO.PasswordResponse;
import com.boot.passwordanalyzer.model.PasswordHistory;
import com.boot.passwordanalyzer.repository.PasswordHistoryRepository;
import com.boot.passwordanalyzer.util.PasswordUtil;

import jakarta.validation.OverridesAttribute;
@Service
public class PasswordServiceImpl implements PasswordService {
	@Autowired
	private PasswordHistoryRepository repository;

	@Override
	public PasswordResponse analyzePassword(String password) {
		 int score = 0;

	        // Password Checks
	        boolean hasUpper =
	                password.matches(".*[A-Z].*");

	        boolean hasLower =
	                password.matches(".*[a-z].*");

	        boolean hasNumber =
	                password.matches(".*\\d.*");

	        boolean hasSpecial =
	                password.matches(".*[@#$%^&+=!].*");

	        // Check reused password
	        boolean reusedPassword =
	                repository.existsByPassword(password);

	        // Score Calculation
	        if (password.length() >= 8) {
	            score += 25;
	        }

	        if (hasUpper) {
	            score += 20;
	        }

	        if (hasLower) {
	            score += 20;
	        }

	        if (hasNumber) {
	            score += 20;
	        }

	        if (hasSpecial) {
	            score += 15;
	        }

	        // Strength Logic
	        String strength;

	        if (score < 40) {
	            strength = "WEAK";
	        }
	        else if (score < 75) {
	            strength = "MEDIUM";
	        }
	        else {
	            strength = "STRONG";
	        }

	        // Save Password History
	        PasswordHistory history =
	                new PasswordHistory();

	        history.setPassword(password);

	        repository.save(history);

	        // Response Object
	        PasswordResponse response =
	                new PasswordResponse();

	        response.setScore(score);

	        response.setStrength(strength);

	        response.setMessage(
	                getMessage(strength));

	        response.setHasUppercase(hasUpper);

	        response.setHasLowercase(hasLower);

	        response.setHasNumber(hasNumber);

	        response.setHasSpecialCharacter(
	                hasSpecial);

	        response.setReusedPassword(
	                reusedPassword);

	        response.setSuggestedPassword(
	                PasswordUtil.suggestPassword(password)
	        );

	        return response;
		
	}

	private String getMessage(String strength) {

        if (strength.equals("WEAK")) {

            return "Weak password. Add uppercase, numbers and symbols.";
        }

        else if (strength.equals("MEDIUM")) {

            return "Medium strength password.";
        }

        else {

            return "Strong password!";
        }
    }
	
	
}
