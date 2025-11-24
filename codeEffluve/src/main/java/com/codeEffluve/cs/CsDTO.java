package com.codeEffluve.cs;

import java.sql.*;

public class CsDTO {

    private int s_idx;          // singo 테이블의 PK
    private int m_idx;          // 작성자 회원 고유 번호
    private String title;       // 제목
    private String content, status;     // 내용
    private Timestamp s_date;        // 접수일
    
  

    public CsDTO() { }

    
    public int getS_idx() { return s_idx; }
    public void setS_idx(int s_idx) { this.s_idx = s_idx; }
    
    public int getM_idx() { return m_idx; }
    public void setM_idx(int m_idx) { this.m_idx = m_idx; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

	public Timestamp getS_date() { return s_date; }
    public void setS_date(Timestamp s_date) { this.s_date = s_date; }
}


