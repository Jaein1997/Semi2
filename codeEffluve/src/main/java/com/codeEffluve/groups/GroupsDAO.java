package com.codeEffluve.groups;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.codeEffluve.db.*;

public class GroupsDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	//그룹명 중복체크 메서드
	public String groupCheck(String g_name) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="select g_name from group_info where g_name=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, g_name);
			rs=ps.executeQuery();
			if(rs.next()) {
				g_name=null;
			}
			
			return g_name;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				ps.close();
				conn.close();
				rs.close();
			}catch(Exception e2) {
				
			}
		}
	}
	//그룹생성 메서드
	public int createGroup(GroupsDTO dto) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="insert into group_info values(group_g_idx.nextval,?,?,?,?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getM_idx());
			
			ps.setString(5, "private");

			int count=ps.executeUpdate();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)ps.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
