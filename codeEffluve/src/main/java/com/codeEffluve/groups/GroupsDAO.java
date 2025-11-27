package com.codeEffluve.groups;

import java.sql.*;
import java.util.*;

import com.codeEffluve.db.*;

public class GroupsDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//본인 그룹 조회 메서드
	public ArrayList<GroupsDTO> myGroups(int m_idx){
		try {
			conn=CodeEffluveDB.getConn();
			String sql="select a.g_idx, a.g_name "
					+ "from group_info a, grouping b "
					+ "where a.g_idx=b.g_idx and b.m_idx=? "
					+ "order by a.g_idx";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, m_idx);
			rs=ps.executeQuery();
			
			ArrayList<GroupsDTO> arr=new ArrayList();
			while(rs.next()) {
				GroupsDTO gdto=new GroupsDTO();
				gdto.setG_idx(rs.getInt("g_idx"));
				gdto.setG_name(rs.getString("g_name"));
				arr.add(gdto);
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
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
	}
	//내 일정 수정 및 추가 그룹생성 메서드
	public int createGroup(GroupsDTO dto) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="insert into group_info values(group_g_idx.nextval,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getG_name());
			ps.setString(2, dto.getG_memo());
			ps.setString(3, dto.getG_profile());
			ps.setInt(4, dto.getM_idx());
			int count=ps.executeUpdate();
			
			sql="select g_idx from group_info where leader=? order by g_idx desc";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getM_idx());
			rs=ps.executeQuery();
			int g_idx=0;
			if(rs.next()) {
				g_idx=rs.getInt(1);
				count++;
			}
			sql="insert into grouping values(?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getM_idx());
			ps.setInt(2, g_idx);
			count+=ps.executeUpdate();
			
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}