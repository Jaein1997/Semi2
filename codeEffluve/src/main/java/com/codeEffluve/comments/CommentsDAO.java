package com.codeEffluve.comments;

import java.sql.*;
import java.util.ArrayList;
import com.codeEffluve.comments.*;


public class CommentsDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public ArrayList<CommentsDTO> getComments(int t_idx) {
		try {
			ArrayList<CommentsDTO> tdtoList = new ArrayList<CommentsDTO>();
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "select c.c_idx, c.m_idx, c.message, c.c_time, m.id "
					+ "from comments c, members m "
					+ "where c.m_idx=m.m_idx and t_idx=? "
					+ "order by c_time";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, t_idx);
			rs = ps.executeQuery();
			while(rs.next()) {
				CommentsDTO tdto = new CommentsDTO();
				tdto.setC_idx(rs.getInt("c_idx"));
				tdto.setT_idx(t_idx);
				tdto.setM_idx(rs.getInt("m_idx"));
				tdto.setMessage(rs.getString("message"));
				tdto.setC_time(rs.getTimestamp("c_time"));
				tdto.setId(rs.getString("id"));
				tdtoList.add(tdto);
			}
			return tdtoList;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public int writeComment(CommentsDTO cdto) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "insert into comments values(comments_c_idx.nextval, ?, ?, ?, sysdate)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdto.getT_idx());
			ps.setInt(2, cdto.getM_idx());
			ps.setString(3, cdto.getMessage());
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public int deleteComment(int c_idx) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "delete from comments where c_idx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, c_idx);
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
