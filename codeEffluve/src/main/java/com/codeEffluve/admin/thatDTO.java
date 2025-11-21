package com.codeEffluve.admin;

import java.sql.Date;

public class thatDTO {
	private int c_idx, t_idx, m_idx;
	private String content,t_memo,shares,message;
	private Date t_time,c_time;
	
	public thatDTO() {
		
	}

	public int getC_idx() {
		return c_idx;
	}

	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}

	public int getT_idx() {
		return t_idx;
	}

	public void setT_idx(int t_idx) {
		this.t_idx = t_idx;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getT_time() {
		return t_time;
	}

	public void setT_time(Date t_time) {
		this.t_time = t_time;
	}

	public Date getC_time() {
		return c_time;
	}

	public void setC_time(Date c_time) {
		this.c_time = c_time;
	}

	public thatDTO(int c_idx, int t_idx, int m_idx, String content, String t_memo, String shares, String message,
			Date t_time, Date c_time) {
		super();
		this.c_idx = c_idx;
		this.t_idx = t_idx;
		this.m_idx = m_idx;
		this.content = content;
		this.t_memo = t_memo;
		this.shares = shares;
		this.message = message;
		this.t_time = t_time;
		this.c_time = c_time;
	}
	
}
