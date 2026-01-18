package com.codeEffluve.grouping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.codeEffluve.db.CodeEffluveDB;
import com.codeEffluve.groups.GroupsDTO;
import com.codeEffluve.members.MembersDTO;

public class GroupingDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	//가입신청 철회
	public int cancel(int m_idx, int g_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="delete from approve where m_idx=? and g_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, m_idx);
			ps.setInt(2, g_idx);
			int result=ps.executeUpdate();
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	//그룹 탈퇴
	public int goodbyemember(int m_idx, int g_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="delete from grouping where m_idx=? and g_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, m_idx);
			ps.setInt(2, g_idx);
			int result=ps.executeUpdate();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	//그룹에 가입 신청
	public int askjoin(int g_idx, int m_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="insert into approve (g_idx, m_idx) values(?, ?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, g_idx);
			ps.setInt(2, m_idx);
			int result=ps.executeUpdate();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	//그룹에 멤버 추가
	public int joinmember(int m_idx, int g_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="insert into grouping (m_idx, g_idx) values(?, ?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, m_idx);
			ps.setInt(2, g_idx);
			int result=ps.executeUpdate();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	//그룹에 가입신청한 멤버 정보 리턴 메서드
	public ArrayList<MembersDTO> whohasasked(int g_idx){
		try {
			conn=CodeEffluveDB.getConn();
			String sql="select a.m_idx, a.id, a.m_name "
					+ "from members a,approve b "
					+ "where a.m_idx=b.m_idx and b.g_idx=? "
					+ "order by a.m_idx";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, g_idx);
			rs=ps.executeQuery();
			
			ArrayList<MembersDTO> arr=new ArrayList();
			while(rs.next()) {
				MembersDTO mdto=new MembersDTO();
				mdto.setM_idx(rs.getInt("m_idx"));
				mdto.setId(rs.getString("id"));
				mdto.setM_name(rs.getString("m_name"));
				arr.add(mdto);
			}
			
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	//그룹에 속한 멤버정보 리턴 메서드
	public ArrayList<MembersDTO> membersInGroup(int g_idx){
		try {
			conn=CodeEffluveDB.getConn();
			String sql="select a.m_idx, a.id, a.m_name "
					+ "from members a,grouping b "
					+ "where a.m_idx=b.m_idx and b.g_idx=? "
					+ "order by a.m_idx";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, g_idx);
			rs=ps.executeQuery();
			
			ArrayList<MembersDTO> arr=new ArrayList();
			while(rs.next()) {
				MembersDTO mdto=new MembersDTO();
				mdto.setM_idx(rs.getInt("m_idx"));
				mdto.setId(rs.getString("id"));
				mdto.setM_name(rs.getString("m_name"));
				arr.add(mdto);
			}
			
			return arr;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
}
