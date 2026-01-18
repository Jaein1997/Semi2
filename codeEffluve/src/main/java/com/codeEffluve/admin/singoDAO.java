package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class singoDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;
    
    public singoDAO() {
	}
    
    //전체 리스트
    public int getTotalCount(String searchId) {
    	try {
    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
    		
    		 String sql = 
    	                "SELECT COUNT(*) FROM singo s " +
    	                "JOIN members m ON s.m_idx = m.m_idx ";
    		 
    		 if(searchId != null && !searchId.equals("")) {
                 sql += "WHERE m.id LIKE ? ";
             }

             ps = conn.prepareStatement(sql);

             if(searchId != null && !searchId.equals("")) {
                 ps.setString(1, "%" + searchId + "%");
             }

             rs = ps.executeQuery();
             rs.next();

             return rs.getInt(1);
    		 
    	}catch(Exception e) {
    		e.printStackTrace();
    		return 0;
    		
    	}finally {
    	try {
    		if(rs != null) rs.close();
    		if(ps != null) ps.close();
    		if(conn != null) conn.close();
    	}catch(Exception e2) {
    	}
    }
  }
    
    //불편사항 목록
    public ArrayList<singoDTO> getsingoList(String searchId, int cp, int ls){
    	
    	ArrayList<singoDTO> list = new ArrayList<>();
    	
    	try {
    		conn=com.codeEffluve.db.CodeEffluveDB.getConn();
    		
    		int start = (cp -1) * ls + 1;
    		int end = cp * ls;
    		
    		String sql =
                    "SELECT * FROM ( " +
                    "   SELECT ROWNUM rnum, a.* FROM ( " +
                    "       SELECT s.s_idx, s.m_idx, s.title, s.content, " +
                    "              s.status, s.s_date, m.id AS singoja " +
                    "       FROM singo s " +
                    "       JOIN members m ON s.m_idx = m.m_idx ";
    			    	    	
    		if(searchId != null && !searchId.equals("")) {
            	sql += "WHERE m.id LIKE ? ";
            }
            
            sql += "ORDER BY s.s_idx DESC" +
            	   "  ) a " +
            	   ") WHERE rnum >= ? AND rnum <= ?";
            	
            ps = conn.prepareStatement(sql);
            
            int i = 1;
            
            if(searchId != null && !searchId.equals("")) {
            	ps.setString(i++, "%" + searchId + "%");
            }
            
            ps.setInt(i++, start);
            ps.setInt(i, end);
            
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
