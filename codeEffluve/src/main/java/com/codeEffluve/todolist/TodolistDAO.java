package com.codeEffluve.todolist;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import com.codeEffluve.db.*;
import com.codeEffluve.groups.GroupsDTO;

public class TodolistDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	//일정이 공유된 그룹들 정보 리턴 메서드
		public ArrayList<GroupsDTO> groupsofTodolist(int t_idx){
			try {
				conn=CodeEffluveDB.getConn();
				String sql="select a.g_idx, a.g_name "
						+ "from group_info a,sharedList b "
						+ "where a.g_idx=b.g_idx and b.t_idx=? "
						+ "order by a.g_idx";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, t_idx);
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
	//공개범위 수정 메서드
	public int rangeEdit(int t_idx, String range) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="update todolist "
					+ "set shares=? "
					+ "where t_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, range);
			ps.setInt(2, t_idx);
			int count=ps.executeUpdate();
			if(range.equals("private")||range.equals("public")) {
				sql="delete from sharedList where t_idx=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, t_idx);
				ps.executeUpdate();
			}
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
	//일정 그룹핑 해제 메서드
	public int groopDelete(int t_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="delete from sharedList where t_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, t_idx);
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
	//일정 그룹 수정 메서드(그룹공개->그룹공개)
	public int groopChange(int t_idx, int g_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="delete from sharedList where t_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, t_idx);
			ps.executeUpdate();
			
			sql="insert into sharedList values(?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, t_idx);
			ps.setInt(2, g_idx);
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
	//일정 그루핑 메서드
	public int groopingTodolist(int t_idx, int g_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="insert into sharedList values(?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, t_idx);
			ps.setInt(2, g_idx);
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
	
	//내 일정 추가 메서드
	public int insertTodolist(TodolistDTO dto,String date) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="insert into todolist values(todolist_t_idx.nextval,?,?,TO_DATE(?,'YYYY-MM-DD HH24:MI'),?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getM_idx());
			ps.setString(2, dto.getContent());
			ps.setString(3, date);
			ps.setString(4, dto.getT_memo());
			ps.setString(5, dto.getShares());
			int count=ps.executeUpdate();
			
			sql="select t_idx from todolist idx order by t_idx desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt("t_idx");
			}
			
			return count;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
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
	
	//m_idx 리턴 메서드
	public int returnM_idx(String id) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="SELECT m_idx FROM members where id=?";
			ps=conn.prepareStatement(sql);
			ps.setNString(1, id);
			rs=ps.executeQuery();
			int idx=0;
			if(rs.next()) {idx=rs.getInt("m_idx");}
			return idx;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {
				
			}
		}
		
	}
	//내 일정 수정 메서드
	public int editTodolist(TodolistDTO dto,String date) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="update todolist "
					+ "set content=?, t_memo=?, t_time=TO_DATE(?,'YYYY-MM-DD HH24:MI'), shares=? "
					+ "where t_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getContent());
			ps.setString(2, dto.getT_memo());
			ps.setString(3, date);
			ps.setString(4, dto.getShares());
			ps.setInt(5, dto.getT_idx());
			
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
	//내 일정 삭제 메서드
	public int deleteTodolist(int t_idx) {
		try {
			conn=CodeEffluveDB.getConn();
			String sql="delete from todolist where t_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, t_idx);
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
	//내 일정 조회 메서드
	public ArrayList<TodolistDTO> showTodolist(int idx,String date){
		try {
			conn=CodeEffluveDB.getConn();
			String sql = "SELECT * FROM todolist " +
                    "WHERE m_idx=? AND t_time >= TO_DATE(?,'YYYY-MM-DD HH24:MI') "
                    + "AND t_time <= TO_DATE(?,'YYYY-MM-DD HH24:MI') order by t_time";
			ps=conn.prepareStatement(sql);
            ps.setInt(1,idx);
            ps.setString(2, date);
            date+=" 23:59";
            ps.setString(3, date);

            rs = ps.executeQuery();
            ArrayList<TodolistDTO> arr=new ArrayList<>();
            while(rs.next()) {
            	TodolistDTO dto=new TodolistDTO();
            	dto.setM_idx(idx);
            	dto.setT_idx(rs.getInt("t_idx"));
            	dto.setContent(rs.getString("content"));
            	dto.setT_time(rs.getTimestamp("t_time"));
            	dto.setT_memo(rs.getString("t_memo"));
            	dto.setShares(rs.getString("shares"));
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
	
	// 전체공개 일정 조회 메소드
	public ArrayList<TodolistDTO> pubLists() {
		try {
			ArrayList<TodolistDTO> tdtoList = new ArrayList<TodolistDTO>();
			conn = CodeEffluveDB.getConn();
//			String sql = "select  t.t_idx,m.id,t.content,t.t_time from todolist t"
//					+ " join members m"
//					+ " on t.m_idx = m.m_idx"
//					+ " where t.shares = 'public'"
//					+ " order by t.t_time desc;";
			String sql = "select t_idx, m_idx, content, t_time from todolist where shares='public' and trunc(t_time) = trunc(sysdate) order by t_time";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				TodolistDTO tdto = new TodolistDTO();
				tdto.setT_idx(rs.getInt("t_idx"));
				tdto.setM_idx(rs.getInt("m_idx"));
				tdto.setContent(rs.getString("content"));
				tdto.setT_time(rs.getTimestamp("t_time"));
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
}
