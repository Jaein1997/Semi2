package com.codeEffluve.cs;

import java.sql.Date;

public class CsDTO {

    private int s_idx;          // singo 테이블의 PK
    private int m_idx;          // 작성자 회원 고유 번호
    private String title;       // 제목
    private String content, status;     // 내용
    private Date s_date;        // 접수일
    
    // ⚠️ category 필드는 DB에 저장되지 않지만, JSP에서 데이터를 전달하기 위해 임시로 유지하거나 제거할 수 있습니다.
    // 여기서는 DB 구조에 맞게 제거합니다.

    public CsDTO() { }

    // Getter and Setter
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


