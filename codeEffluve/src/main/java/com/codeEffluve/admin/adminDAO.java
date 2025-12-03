package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class adminDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public adminDAO() {

	}

	// 회원 목록
	public ArrayList<adminDTO> getMemberList(String searchId) {
	    ArrayList<adminDTO> arr = new ArrayList<>();
	    try {
	        conn = com.codeEffluve.db.CodeEffluveDB.getConn();

	        String sql = "SELECT m_idx, id, pwd, m_name, sex, birthday, tel, m_profile FROM members ";

	        if(searchId != null && !searchId.equals("")) {
	            sql += "WHERE id LIKE ? ";
	        }

	        sql += "ORDER BY m_idx DESC";

	        ps = conn.prepareStatement(sql);

	        if(searchId != null && !searchId.equals("")) {
	            ps.setString(1, "%" + searchId + "%");
	        }

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
