package com.codeEffluve.friending;

import java.sql.*;
import java.util.*;

public class FriendingDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public ArrayList<Integer> viewFriends(int sid) {
		try {
			ArrayList<Integer> friendsArr = new ArrayList<Integer>();
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql1 = "select fr2 from friending where fr1=?";
			ps = conn.prepareStatement(sql1);
			ps.setInt(1, sid);
			rs = ps.executeQuery();
			while(rs.next()) {
				friendsArr.add(rs.getInt("fr2"));
			}
			rs.close();
			ps.close();
			
			String sql2 = "select fr1 from friending where fr2=?";
			ps = conn.prepareStatement(sql2);
			ps.setInt(1, sid);
			rs = ps.executeQuery();
			while(rs.next()) {
				friendsArr.add(rs.getInt("fr1"));
			}
			return friendsArr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs!=null) rs.close();
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public boolean isFriend(int fr1, int fr2) {
		try {
			boolean result = false;
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql1 = "select * from friending where fr2=? and fr1=?";
			ps = conn.prepareStatement(sql1);
			ps.setInt(1, fr1);
			ps.setInt(2, fr2);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
			}
			rs.close();
			ps.close();
			String sql2 = "select * from friending where fr1=? and fr2=?";
			ps = conn.prepareStatement(sql2);
			ps.setInt(1, fr1);
			ps.setInt(2, fr2);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs!=null) rs.close();
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public int addFriend(int fr1, int fr2) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql1 = "insert into friending values(?,?)";
			ps = conn.prepareStatement(sql1);
			ps.setInt(1, fr1);
			ps.setInt(2, fr2);
			int result = ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (rs!=null) rs.close();
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
