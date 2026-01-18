package com.codeEffluve.chat;

import java.sql.*;
import java.util.ArrayList;

public class ChatDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//채팅 내역 조회
	public ArrayList<ChatDTO> getChatList(int sidx, int sf) {
		try {
			ArrayList<ChatDTO> chatList = new ArrayList<ChatDTO>();
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();

			String sql = "select * from chat where sender=? and receiver=? or sender=? and receiver=? order by chattime";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sidx);
			ps.setInt(2, sf);
			ps.setInt(3, sf);
			ps.setInt(4, sidx);
			rs = ps.executeQuery();
			while (rs.next()) {
				ChatDTO chdto = new ChatDTO();
				chdto.setCh_idx(rs.getInt("ch_idx"));
				chdto.setSender(rs.getInt("sender"));
				chdto.setReceiver(rs.getInt("receiver"));
				chdto.setMessage(rs.getString("message"));
				chdto.setChattime(rs.getTimestamp("chattime"));
				chatList.add(chdto);
			}
			return chatList;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	// 채팅 보내기
	public int writeChat(int sender, int receiver, String message) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql = "insert into chat values (chat_ch_idx.nextval, ?, ?, ?, sysdate)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sender);
			ps.setInt(2, receiver);
			ps.setString(3, message);
			int result = ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	// 친구 삭제 시 채팅 내역 삭제 {
	public int deleteChats(int sender, int receiver) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql = "delete from chat where sender=? and receiver=? or sender=? and receiver=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sender);
			ps.setInt(2, receiver);
			ps.setInt(3, receiver);
			ps.setInt(4, sender);
			int result = ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
