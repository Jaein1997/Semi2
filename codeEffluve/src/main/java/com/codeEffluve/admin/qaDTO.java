package com.codeEffluve.admin;

public class qaDTO {
	
	private int q_idx, viewcount;
	private String q,a;
	
	public qaDTO() {
		
	}

	public int getQ_idx() {
		return q_idx;
	}

	public void setQ_idx(int q_idx) {
		this.q_idx = q_idx;
	}

	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	public String getA() {
		return a;
	}

	public void setA(String a) {
		this.a = a;
	}

	public int getViewcount() {
		return viewcount;
	}

	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}

	public qaDTO(int q_idx, String q, String a, int viewcount) {
		super();
		this.q_idx = q_idx;
		this.q = q;
		this.a = a;
		this.viewcount = viewcount;
	}
	
}
