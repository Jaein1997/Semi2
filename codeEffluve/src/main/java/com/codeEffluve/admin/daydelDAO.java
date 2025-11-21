package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class daydelDAO {
	
	 private Connection conn;
	    private PreparedStatement ps;
	    private ResultSet rs;
	    
	    public daydelDAO() {
		
	    }
	    
	    //일정 리스트
	    public ArrayList<daydelDTO> getTodoList() {
	    	ArrayList<daydelDTO> arr = new ArrayList<>();
	    	
	    	try {
	    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	    		String sql = "SELECT * FROM todolist order by t_idx desc";
	    		ps = conn.prepareStatement(sql);
	    		rs = ps.executeQuery();
	    		
	    		while (rs.next()) {
	    			daydelDTO dto = new daydelDTO(
	    					rs.getInt("t_idx"),
	    					rs.getInt("m_idx"),
	    					rs.getString("content"),
	    					rs.getDate("t_time"),
	    					rs.getString("t_memo"),
	    					rs.getString("shares")
	    					);
	    			arr.add(dto);
	    		}
	    		return arr;
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    		return null;
	    	}finally {
	    		try {
	    			if (rs != null) rs.close();
	                 if (ps != null) ps.close();
	                 if (conn != null) conn.close();
	    		}catch(Exception e2) {}
	    	}
	    }
	    
	    //일정 삭제
	    public int deleteTodo(int t_idx) {
	    	try {
	    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	            String sql = "DELETE FROM todolist WHERE t_idx=?";
	            ps = conn.prepareStatement(sql);
	            ps.setInt(1, t_idx);
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
