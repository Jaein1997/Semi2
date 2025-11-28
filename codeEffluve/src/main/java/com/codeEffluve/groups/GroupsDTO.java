package com.codeEffluve.groups;

public class GroupsDTO {
	private int g_idx, m_idx;
	private String g_name,g_memo,g_profile,leader;
	public int getG_idx() {
		return g_idx;
	}
	public void setG_idx(int g_idx) {
		this.g_idx = g_idx;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
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
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	
}
