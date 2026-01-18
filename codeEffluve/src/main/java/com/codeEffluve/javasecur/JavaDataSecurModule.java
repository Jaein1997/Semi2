package com.codeEffluve.javasecur;

import java.security.*;

public class JavaDataSecurModule {

	// 암호화 코드 모듈화
	public static String getSHA256(String data) {
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(data.getBytes());
			byte bytes[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for(byte temp:bytes) {
				sb.append(String.format("%02x", temp));
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}
}
