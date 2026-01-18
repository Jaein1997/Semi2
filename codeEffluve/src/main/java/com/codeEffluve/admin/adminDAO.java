package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class adminDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public adminDAO() {

	}
		//전체 개수
	  public int getTotalCount(String searchId) {
	    	try {
	    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	    		
	    		String sql = "SELECT COUNT(*) FROM members ";
	    		
	    		if (searchId != null && !searchId.equals("")) {
	                sql += "WHERE id LIKE ? ";
	            }

	            ps = conn.prepareStatement(sql);

	            if (searchId != null && !searchId.equals("")) {
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


	// 회원 목록
	public ArrayList<adminDTO> getMemberList(String searchId, int cp, int ls) {
	    ArrayList<adminDTO> arr = new ArrayList<>();
	    try {
	        conn = com.codeEffluve.db.CodeEffluveDB.getConn();

	        int start = (cp -1) * ls + 1;
	        int end = cp * ls;
	        
	        String sql =
	        		"SELECT * FROM ( " +
	        		"SELECT ROWNUM rnum, a.* FROM ( " +
	        		"SELECT m_idx, id, pwd, m_name, sex, birthday, tel, m_profile FROM members ";

	        if(searchId != null && !searchId.equals("")) {
	            sql += "WHERE id LIKE ? ";
	        }

	        sql += "ORDER BY m_idx DESC" +
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
	            adminDTO dto = new adminDTO(
	                rs.getInt("m_idx"),
	                rs.getString("id"),
	                rs.getString("pwd"),
	                rs.getString("m_name"),
	                rs.getString("sex"),
	                rs.getDate("birthday"),
	                rs.getString("tel"),
	                rs.getString("m_profile")
	            );
	            arr.add(dto);
	        }
	        return arr;

	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(rs != null) rs.close();
	            if(ps != null) ps.close();
	            if(conn != null) conn.close();
	        } catch(Exception e2) {}
	    }
	    return null;
	}

	
	//회원 삭제
	public int deleteMember(int m_idx) {
		try {
			conn=com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql ="delete from members where m_idx=?";
			ps =conn.prepareStatement(sql);
			ps.setInt(1, m_idx);
			return ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps !=null) ps.close();
				if(conn != null) conn.close();
			}catch (Exception e2) {
			}
		}
	}
}
