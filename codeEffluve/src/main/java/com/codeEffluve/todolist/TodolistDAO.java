package com.codeEffluve.todolist;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import com.codeEffluve.db.*;

public class TodolistDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	//내 일정 추가 메서드
	
	
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
				
			}catch(Exception e2) {
				
			}
		}
		
	}
	//내 일정 조회 메서드
	public ArrayList<TodolistDTO> showTodolist(int idx,Date date){
		try {
			conn=CodeEffluveDB.getConn();
			String sql = "SELECT * FROM todolist " +
                    "WHERE m_idx=? AND a.t_time >= ? AND a.t_time < ?";
			ps=conn.prepareStatement(sql);
            ps.setInt(1,idx);
            ps.setDate(2, date); 
          
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            cal.add(Calendar.DATE, 1);
            java.sql.Date nextDate = new java.sql.Date(cal.getTimeInMillis());
            
            ps.setDate(3, nextDate);

            rs = ps.executeQuery();
            ArrayList<TodolistDTO> arr=new ArrayList<>();
            while(rs.next()) {
            	TodolistDTO dto=new TodolistDTO();
            	dto.setT_idx(rs.getInt("t_idx"));
            	dto.setContent("content");
            	dto.setT_time(rs.getDate("t_time"));
            	dto.setT_memo(rs.getString("t_memo"));
            	arr.add(dto);
            }
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(conn!=null)conn.close();
				if(ps!=null)ps.close();
				if(rs!=null)rs.close();
			}catch(Exception e2) {
				
			}
		}
	}
}
