package com.codeEffluve.cs;

import java.sql.Date;

public class CsDTO {

    private int s_idx;          
    private int m_idx;          
    private String title;       
    private String content;     
    private Date s_date;        
    private String status;      
    
  

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
    
    public Date getS_date() { return s_date; }
    public void setS_date(Date s_date) { this.s_date = s_date; }
}