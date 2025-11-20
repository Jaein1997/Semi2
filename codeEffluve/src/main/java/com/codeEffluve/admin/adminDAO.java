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
	public ArrayList<adminDTO> getMemberList() {
		ArrayList<adminDTO> arr = new ArrayList<>();
		try {
	conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	String sql="select * from members order by m_idx desc";
	ps=conn.prepareStatement(sql);
	rs=ps.executeQuery();
	
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
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
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
