package com.codeEffluve.admin;

import java.sql.Date;

public class adminDTO {
	private int m_idx;
	private String id;
	private String pwd;
	private String m_name;
	private String sex;
	private Date birthday;
	private String tel;
	private String m_profile;
	
	public adminDTO() {
		
	}

	public int getM_idx() {
		return m_idx;
	}

	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getM_profile() {
		return m_profile;
	}

	public void setM_profile(String m_profile) {
		this.m_profile = m_profile;
	}
	
	public adminDTO(int m_idx, String id, String pwd, String m_name, String sex, 
			Date birthday, String tel, String m_profile ) {
		super();
		this.m_idx = m_idx;
		this.id = id;
		this.pwd = pwd;
		this.m_name = m_name;
		this.sex = sex;
		this.birthday = birthday;
		this.tel= tel;
		this.m_profile= m_profile;
		
	}
}
