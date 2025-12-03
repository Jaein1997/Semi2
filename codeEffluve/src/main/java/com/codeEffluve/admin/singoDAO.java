package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class singoDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;
    
    public singoDAO() {
	}
    
    //불편사항 목록
    public ArrayList<singoDTO> getsingoList(String searchId){
    	ArrayList<singoDTO> list = new ArrayList<>();
    	
    	try {
    		conn=com.codeEffluve.db.CodeEffluveDB.getConn();
    		String sql = 
    			    "SELECT s.s_idx, s.m_idx, s.title, s.content, s.status, " +
    			    	    "       s.s_date, m.id AS singoja " +
    			    	    "FROM singo s " +
    			    	    "JOIN members m ON s.m_idx = m.m_idx ";
    			    	    	
    		if(searchId != null && !searchId.equals("")) {
            	sql += "WHERE m.id LIKE ? ";
            }
            
            sql += "ORDER BY s.s_idx DESC";
            ps = conn.prepareStatement(sql);
            
            if(searchId != null && !searchId.equals("")) {
            	ps.setString(1, "%" + searchId + "%");
            }
            
    		rs = ps.executeQuery();
    		
    		while (rs.next()) {
    			singoDTO dto = new singoDTO(
    					rs.getInt("s_idx"),
    					rs.getInt("m_idx"),
    					rs.getString("title"),
    					rs.getString("content"),
    					rs.getString("status"),
    					rs.getString("singoja"),
    					rs.getDate("s_date")	
    					);
    			list.add(dto);
    		}
    		return list;
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		return null;
    	}finally {
    		try {
    			 if (rs != null) rs.close();
                 if (ps != null) ps.close();
                 if (conn != null) conn.close();
    		}catch(Exception e2) {
    			
    		}
    	}
    	
    }
    
    //신고 등록
    public int insertSingo(singoDTO dto) {
    	try {
    		conn=com.codeEffluve.db.CodeEffluveDB.getConn();
    		
    		String sql = "INSERT INTO singo(s_idx, m_idx, title, content, status, s_date) "
    				   + "values(singo_s_idx.nextval, ?, ?, ?, 'N',sysdate)";
    		ps = conn.prepareStatement(sql);
    		ps.setInt(1, dto.getM_idx());
    		ps.setString(2, dto.getTitle());
    		ps.setString(3, dto.getContent());
    		
    		return ps.executeUpdate();
    	} catch(Exception e) {
    		e.printStackTrace();
    		return -1;
    	}finally {
    		try {
    			if(ps!=null) ps.close();
    			if(conn!=null) conn.close();
    		}catch(Exception e2) {
    			
    		}
    	}
    	
    }
    
    //확인전 -> 확인완료
    public int updatestatus(int s_idx) {
    	try {
    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
    		String sql = "UPDATE singo SET status='확인완료' WHERE s_idx=?";
    		ps = conn.prepareStatement(sql);
            ps.setInt(1, s_idx);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if(ps!=null) ps.close();
                if(conn!=null) conn.close();
            } catch(Exception e2){}
        }
    }
}
