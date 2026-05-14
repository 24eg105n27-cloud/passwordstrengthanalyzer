package com.boot.passwordanalyzer.DTO;

import lombok.Builder;
import lombok.Data;

@Data
public class PasswordResponse {
	 private int score;

	    private String strength;

	    private String message;

	    private boolean hasUppercase;

	    private boolean hasLowercase;

	    private boolean hasNumber;

	    private boolean hasSpecialCharacter;

	    private boolean reusedPassword;

	    private String suggestedPassword;
	    
	    

		public PasswordResponse(int score, String strength, String message, boolean hasUppercase, boolean hasLowercase,
				boolean hasNumber, boolean hasSpecialCharacter, boolean reusedPassword, String suggestedPassword) {
			super();
			this.score = score;
			this.strength = strength;
			this.message = message;
			this.hasUppercase = hasUppercase;
			this.hasLowercase = hasLowercase;
			this.hasNumber = hasNumber;
			this.hasSpecialCharacter = hasSpecialCharacter;
			this.reusedPassword = reusedPassword;
			this.suggestedPassword = suggestedPassword;
		}
		
		

		public PasswordResponse() {
			super();
		}



		public int getScore() {
			return score;
		}

		public void setScore(int score) {
			this.score = score;
		}

		public String getStrength() {
			return strength;
		}

		public void setStrength(String strength) {
			this.strength = strength;
		}

		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}

		public boolean isHasUppercase() {
			return hasUppercase;
		}

		public void setHasUppercase(boolean hasUppercase) {
			this.hasUppercase = hasUppercase;
		}

		public boolean isHasLowercase() {
			return hasLowercase;
		}

		public void setHasLowercase(boolean hasLowercase) {
			this.hasLowercase = hasLowercase;
		}

		public boolean isHasNumber() {
			return hasNumber;
		}

		public void setHasNumber(boolean hasNumber) {
			this.hasNumber = hasNumber;
		}

		public boolean isHasSpecialCharacter() {
			return hasSpecialCharacter;
		}

		public void setHasSpecialCharacter(boolean hasSpecialCharacter) {
			this.hasSpecialCharacter = hasSpecialCharacter;
		}

		public boolean isReusedPassword() {
			return reusedPassword;
		}

		public void setReusedPassword(boolean reusedPassword) {
			this.reusedPassword = reusedPassword;
		}

		public String getSuggestedPassword() {
			return suggestedPassword;
		}

		public void setSuggestedPassword(String suggestedPassword) {
			this.suggestedPassword = suggestedPassword;
		}

		

}
