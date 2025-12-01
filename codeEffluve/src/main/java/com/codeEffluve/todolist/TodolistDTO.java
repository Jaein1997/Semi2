package com.codeEffluve.todolist;

import java.sql.Timestamp;

public class TodolistDTO {
	private int t_idx,m_idx;
	private String content,t_memo,shares,id,m_profile, status;
	private Timestamp t_time;
	
	public int getT_idx() {
		return t_idx;
	}
	public void setT_idx(int t_idx) {
		this.t_idx = t_idx;
	}
	public String getM_profile() {
		return m_profile;
	}
	public void setM_profile(String m_profile) {
		this.m_profile = m_profile;
	}
	public int getM_idx() {
		return m_idx;
	}
	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getT_memo() {
		return t_memo;
	}
	public void setT_memo(String t_memo) {
		this.t_memo = t_memo;
	}
	public String getShares() {
		return shares;
	}
	public void setShares(String shares) {
		this.shares = shares;
	}
	public Timestamp getT_time() {
		return t_time;
	}
	public void setT_time(Timestamp t_time) {
		this.t_time = t_time;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
