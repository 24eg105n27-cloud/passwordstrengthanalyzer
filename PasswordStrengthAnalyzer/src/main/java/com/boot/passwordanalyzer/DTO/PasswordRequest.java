package com.boot.passwordanalyzer.DTO;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class PasswordRequest {
	@NotBlank(message = "Password cannot be empty")
    private String password;

	public PasswordRequest(@NotBlank(message = "Password cannot be empty") String password) {
		super();
		this.password = password;
	}

	public PasswordRequest() {
		super();
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	

}
