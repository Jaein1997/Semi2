package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class thatDAO {
	
	private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;
    
    
    public thatDAO() {
		
	}
    
    //댓글 리스트
	public ArrayList<thatDTO> getCommentList(String searchId) {
	    ArrayList<thatDTO> arr = new ArrayList<>();

	    try {
	    	conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	    	 String sql =
	    	            "SELECT c.c_idx, c.t_idx, c.m_idx, m.id AS member_id, " +
	    	            " c.message, c.c_time, t.content, t.shares " +
	    	            "FROM comments c JOIN todolist t ON c.t_idx = t.t_idx " +
	    	            "JOIN members m ON c.m_idx = m.m_idx ";
	    	            
	    	 if(searchId != null && !searchId.equals("")) {
	            	sql += "WHERE m.id LIKE ? ";
	            }
	            
	    	 sql += "ORDER BY c.c_idx DESC";
	            ps = conn.prepareStatement(sql);
	            
	            if(searchId != null && !searchId.equals("")) {
	            	ps.setString(1, "%" + searchId + "%");
	            }
	        rs = ps.executeQuery();

	        while(rs.next()) {
	        	thatDTO dto = new thatDTO(
	        			rs.getInt("c_idx"),
	        			rs.getInt("t_idx"),
	        			rs.getInt("m_idx"),
	        			rs.getString("member_id"),
	        			rs.getString("content"),
	        			rs.getString("shares"),
	        			rs.getString("message"),
	        			rs.getDate("c_time")
	        			);
	        	arr.add(dto);
	        }
	        return arr;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {}
	    }
	}
	 //댓글 삭제
    public int deleteThat(int c_idx) {
    	try {
    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            String sql = "DELETE FROM comments WHERE c_idx=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, c_idx);
            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {}
        }
    }

}
