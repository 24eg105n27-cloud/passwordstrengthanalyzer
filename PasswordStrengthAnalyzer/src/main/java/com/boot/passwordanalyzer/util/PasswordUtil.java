package com.boot.passwordanalyzer.util;

public class PasswordUtil {
	 public static String suggestPassword(String password) {

	        StringBuilder sb = new StringBuilder(password);

	        if (!password.matches(".*[A-Z].*")) {
	            sb.append("A");
	        }

	        if (!password.matches(".*[a-z].*")) {
	            sb.append("a");
	        }

	        if (!password.matches(".*\\d.*")) {
	            sb.append("1");
	        }

	        if (!password.matches(".*[@#$%^&+=!].*")) {
	            sb.append("@");
	        }

	        if (password.length() < 8) {
	            sb.append("1234");
	        }

	        return sb.toString();
	    }

}
