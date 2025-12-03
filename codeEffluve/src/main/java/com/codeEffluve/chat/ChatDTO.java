package com.codeEffluve.chat;

import java.sql.*;

public class ChatDTO {
	private int ch_idx, sender, receiver;
	private String message;
	private Timestamp chattime;
	public int getCh_idx() {
		return ch_idx;
	}
	public void setCh_idx(int ch_idx) {
		this.ch_idx = ch_idx;
	}
	public int getSender() {
		return sender;
	}
	public void setSender(int sender) {
		this.sender = sender;
	}
	public int getReceiver() {
		return receiver;
	}
	public void setReceiver(int receiver) {
		this.receiver = receiver;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Timestamp getChattime() {
		return chattime;
	}
	public void setChattime(Timestamp chattime) {
		this.chattime = chattime;
	}
	
	
}
