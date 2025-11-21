package com.codeEffluve.admin;

import java.sql.Date;

public class daydelDTO {
	private int t_idx, m_idx;
	private String content,t_memo,shares;
	private Date t_time;
	
	public daydelDTO() {
	
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

	public Date getT_time() {
		return t_time;
	}

	public void setT_time(Date t_time) {
		this.t_time = t_time;
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

	public daydelDTO(int t_idx, int m_idx, String content, Date t_time, String t_memo, String shares) {
		super();
		this.t_idx = t_idx;
		this.m_idx = m_idx;
		this.content = content;
		this.t_time = t_time;
		this.t_memo = t_memo;
		this.shares = shares;
	}
}
