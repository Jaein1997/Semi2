package com.codeEffluve.groups;

import java.sql.*;
import java.util.*;

import com.codeEffluve.db.*;
import com.codeEffluve.members.MembersDTO;
import com.codeEffluve.todolist.TodolistDTO;

public class GroupsDAO {
   private Connection conn;
   private PreparedStatement ps;
   private ResultSet rs;
   //그룹 삭제 메서드
   public int deletegroup(int g_idx, int m_idx) {
      try {
         conn=CodeEffluveDB.getConn();
         String sql="delete from group_info "
               + "where g_idx=? and leader=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, g_idx);
         ps.setInt(2, m_idx);
         int count=ps.executeUpdate();
         
         return count;
      }catch(Exception e) {
         e.printStackTrace();
         return -1;
      }finally {
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {
            e2.printStackTrace();
         }
      }
   }
   //그룹장 변경 메서드
   public int changeleader(int g_idx, int m_idx) {
      try {
         conn=CodeEffluveDB.getConn();
         String sql="update group_info set leader=? "
               + "where g_idx=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, m_idx);
         ps.setInt(2, g_idx);
         int count=ps.executeUpdate();
         
         return count;
      }catch(Exception e) {
         e.printStackTrace();
         return -1;
      }finally {
         try {
            if(ps!=null)ps.close();
            if(conn!=null)conn.close();
         }catch(Exception e2) {
            e2.printStackTrace();
         }
      }
   }
   
   //이름으로 그룹 멤버 검색 메서드
   public ArrayList<MembersDTO> searchedmember(int g_idx, String m_name) {
      try {
         conn=CodeEffluveDB.getConn();
         String sql="select a.* "
               + "from members a, grouping b "
               + "where a.m_name like ? and b.g_idx=? and a.m_idx = b.m_idx "
               + "order by a.m_idx";
         ps=conn.prepareStatement(sql);
         ps.setString(1, "%"+m_name+"%");
         ps.setInt(2, g_idx);
         rs=ps.executeQuery();
         
         ArrayList<MembersDTO> arr=new ArrayList();
         while(rs.next()) {
            MembersDTO dto=new MembersDTO();
            dto.setM_idx(rs.getInt("m_idx"));
            dto.setId(rs.getString("id"));
            dto.setM_name(rs.getString("m_name"));
            dto.setM_profile(rs.getString("m_profile"));
            arr.add(dto);
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
   //그룹장 제외 그룹 멤버 조회 메서드
   public ArrayList<MembersDTO> groupmembers(int g_idx){
      try {
         conn=CodeEffluveDB.getConn();
         String sql = "select a.* "
               + "from members a, grouping b "
               + "where a.m_idx=b.m_idx and b.g_idx=? "
                    + "order by a.m_idx";
         ps=conn.prepareStatement(sql);
            ps.setInt(1,g_idx);
            rs = ps.executeQuery();
            
            ArrayList<MembersDTO> arr=new ArrayList();
            while(rs.next()) {
               MembersDTO dto=new MembersDTO();
               dto.setM_idx(rs.getInt("m_idx"));
               dto.setId(rs.getString("id"));
               dto.setM_name(rs.getString("m_name"));
               dto.setM_profile(rs.getString("m_profile"));
               arr.add(dto);
            }
			return arr;
		} catch (Exception e) {
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
	
	//날짜별 그룹일정조회 메서드
		public ArrayList<TodolistDTO> groupTodolist(int g_idx,String date){
			try {
				conn=CodeEffluveDB.getConn();
				String sql = "select a.*, c.id, c.m_profile "
						+ "from todolist a, sharedList b, members c " +
	                    "where a.t_idx=b.t_idx and a.m_idx=c.m_idx and b.g_idx=? "
	                    + "and t_time >= to_date(?,'YYYY-MM-DD HH24:MI') "
	                    + "and t_time <= to_date(?,'YYYY-MM-DD HH24:MI') "
	                    + "and a.status='ud' "
	                    + "order by t_time";
				ps=conn.prepareStatement(sql);
	            ps.setInt(1,g_idx);
	            ps.setString(2, date);
	            date+=" 23:59";
	            ps.setString(3, date);

               rs = ps.executeQuery();
               ArrayList<TodolistDTO> arr=new ArrayList<>();
               while(rs.next()) {
                  TodolistDTO dto=new TodolistDTO();
                  dto.setM_idx(rs.getInt("m_idx"));
                  dto.setT_idx(rs.getInt("t_idx"));
                  dto.setContent(rs.getString("content"));
                  dto.setT_time(rs.getTimestamp("t_time"));
                  dto.setT_memo(rs.getString("t_memo"));
                  dto.setShares(rs.getString("shares"));
                  dto.setId(rs.getString("id"));
                  dto.setM_profile(rs.getString("m_profile"));
                  arr.add(dto);
               }
            return arr;
         } catch (Exception e) {
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
   //그룹명으로 검색 메서드
   public ArrayList<GroupsDTO> searchedGroup(String g_name) {
      try {
         conn=CodeEffluveDB.getConn();
         String sql="select a.*,b.m_name from group_info a,members b"
               + " where g_name like ? and a.leader = b.m_idx "
               + "order by g_idx";
         ps=conn.prepareStatement(sql);
         ps.setString(1, "%"+g_name+"%");
         rs=ps.executeQuery();
         
         ArrayList<GroupsDTO> arr=new ArrayList();
         while(rs.next()) {
            GroupsDTO gdto=new GroupsDTO();
            gdto.setG_idx(rs.getInt("g_idx"));
            gdto.setG_name(rs.getString("g_name"));
            gdto.setG_memo(rs.getString("g_memo"));
            gdto.setG_profile(rs.getString("g_profile"));
            gdto.setM_idx(rs.getInt("leader"));
            gdto.setLeader(rs.getString("m_name"));
            gdto.setApproval(rs.getString("approval"));
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
   //전체 그룹 조회 메서드
   public ArrayList<GroupsDTO> allGroup() {
      try {
         conn=CodeEffluveDB.getConn();
         String sql="select a.*,b.m_name from group_info a, members b "
               + "where a.leader = b.m_idx "
               + "order by g_idx";
         ps=conn.prepareStatement(sql);
         rs=ps.executeQuery();
         
         ArrayList<GroupsDTO> arr=new ArrayList();
         while(rs.next()) {
            GroupsDTO gdto=new GroupsDTO();
            gdto.setG_idx(rs.getInt("g_idx"));
            gdto.setG_name(rs.getString("g_name"));
            gdto.setG_memo(rs.getString("g_memo"));
            gdto.setG_profile(rs.getString("g_profile"));
            gdto.setM_idx(rs.getInt("leader"));
            gdto.setLeader(rs.getString("m_name"));
            gdto.setApproval(rs.getString("approval"));
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
   //그룹 정보 조회 메서드
   public GroupsDTO selectedGroup(int g_idx) {
      try {
         conn=CodeEffluveDB.getConn();
         String sql="select * from group_info where g_idx=?";
         ps=conn.prepareStatement(sql);
         ps.setInt(1, g_idx);
         rs=ps.executeQuery();
         
         GroupsDTO gdto=new GroupsDTO();
         if(rs.next()) {
            gdto.setG_idx(g_idx);
            gdto.setG_name(rs.getString("g_name"));
            gdto.setG_memo(rs.getString("g_memo"));
            gdto.setG_profile(rs.getString("g_profile"));
            gdto.setM_idx(rs.getInt("leader"));
            gdto.setApproval(rs.getString("approval"));
         }
         return gdto;
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
   
   //가입 신청한 그룹 조회 메서드
      public ArrayList<GroupsDTO> myaskedGroups(int m_idx){
         try {
            conn=CodeEffluveDB.getConn();
            String sql="select a.* "
                  + "from group_info a, approve b "
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
               gdto.setG_memo(rs.getString("g_memo"));
               gdto.setG_profile(rs.getString("g_profile"));
               gdto.setM_idx(rs.getInt("leader"));
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
   //본인 그룹 조회 메서드
   public ArrayList<GroupsDTO> myGroups(int m_idx){
      try {
         conn=CodeEffluveDB.getConn();
         String sql="select a.* "
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
            gdto.setG_memo(rs.getString("g_memo"));
            gdto.setG_profile(rs.getString("g_profile"));
            gdto.setM_idx(rs.getInt("leader"));
            gdto.setApproval(rs.getString("approval"));
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
   //그룹수정 메서드
      public int updateGroup(GroupsDTO dto) {
         try {
            conn=CodeEffluveDB.getConn();
            String sql="update group_info set g_name=?, g_memo=?, g_profile=?, leader=?, approval=? "
                  + "where g_idx=?";
            ps=conn.prepareStatement(sql);
            ps.setString(1, dto.getG_name());
            ps.setString(2, dto.getG_memo());
            ps.setString(3, dto.getG_profile());
            ps.setInt(4, dto.getM_idx());
            ps.setString(5, dto.getApproval());
            ps.setInt(6, dto.getG_idx());
            int count=ps.executeUpdate();
            
            return count;
         }catch(Exception e) {
            e.printStackTrace();
            return -1;
         }finally {
            try {
               if(ps!=null)ps.close();
               if(conn!=null)conn.close();
            }catch(Exception e2) {
               e2.printStackTrace();
            }
         }
      }
   
   //그룹생성 메서드
   public int createGroup(GroupsDTO dto) {
      try {
         conn=CodeEffluveDB.getConn();
         String sql="insert into group_info values(group_g_idx.nextval,?,?,?,?,?)";
         ps=conn.prepareStatement(sql);
         ps.setString(1, dto.getG_name());
         ps.setString(2, dto.getG_memo());
         ps.setString(3, dto.getG_profile());
         ps.setInt(4, dto.getM_idx());
         ps.setString(5, dto.getApproval());
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