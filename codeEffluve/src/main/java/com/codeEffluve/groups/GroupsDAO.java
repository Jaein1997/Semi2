package com.codeEffluve.groups;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.codeEffluve.db.*;

public class GroupsDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	//그룹생성 메서드
	public int createGroup(GroupsDTO dto) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="insert into group_info values(todolist_t_idx.nextval,?,?,?,?";
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
