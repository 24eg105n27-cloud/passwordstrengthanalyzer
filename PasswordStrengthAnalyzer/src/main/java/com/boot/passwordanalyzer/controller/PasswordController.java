package com.boot.passwordanalyzer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boot.passwordanalyzer.DTO.PasswordRequest;
import com.boot.passwordanalyzer.DTO.PasswordResponse;
import com.boot.passwordanalyzer.service.PasswordService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/password")
@CrossOrigin(origins = "*")
public class PasswordController {
	@Autowired
    private PasswordService passwordService;

    @PostMapping("/analyze")
    public PasswordResponse analyzePassword(@Valid @RequestBody PasswordRequest request) {
        return passwordService
                .analyzePassword(request.getPassword());
    }

}
