package com.codeEffluve.admin;

import java.sql.Date;

public class singoDTO {
	private int s_idx, m_idx;
	private String title,content, status, singoja;
	private Date s_date;
	
	public singoDTO() {
	
	}

	public int getS_idx() {
		return s_idx;
	}

	public void setS_idx(int s_idx) {
		this.s_idx = s_idx;
	}

	public int getM_idx() {
		return m_idx;
	}

	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getS_date() {
		return s_date;
	}

	public void setS_date(Date s_date) {
		this.s_date = s_date;
	}
	

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	

	public String getSingoja() {
		return singoja;
	}

	public void setSingoja(String singoja) {
		this.singoja = singoja;
	}

	
	
	public singoDTO(int s_idx, int m_idx, String title, String content, String status, String singoja, Date s_date) {
		super();
		this.s_idx = s_idx;
		this.m_idx = m_idx;
		this.title = title;
		this.content = content;
		this.status = status;
		this.singoja = singoja;
		this.s_date = s_date;
	}

}
