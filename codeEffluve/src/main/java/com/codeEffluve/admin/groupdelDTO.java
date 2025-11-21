package com.codeEffluve.admin;

import java.sql.Date;

public class groupdelDTO {
	private int g_idx, leader;
	private String g_name,g_memo,g_profile;
	
	public groupdelDTO() {
		
	}

	public int getG_idx() {
		return g_idx;
	}

	public void setG_idx(int g_idx) {
		this.g_idx = g_idx;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

	public String getG_memo() {
		return g_memo;
	}

	public void setG_memo(String g_memo) {
		this.g_memo = g_memo;
	}

	public String getG_profile() {
		return g_profile;
	}

	public void setG_profile(String g_profile) {
		this.g_profile = g_profile;
	}

	public int getLeader() {
		return leader;
	}

	public void setLeader(int leader) {
		this.leader = leader;
	}

	public groupdelDTO(int g_idx, String g_name, String g_memo, String g_profile, int leader) {
		super();
		this.g_idx = g_idx;
		this.g_name = g_name;
		this.g_memo = g_memo;
		this.g_profile = g_profile;
		this.leader = leader;
	}
	
}
