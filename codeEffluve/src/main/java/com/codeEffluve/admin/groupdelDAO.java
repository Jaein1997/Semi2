package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class groupdelDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public groupdelDAO() {}
    
    //전체 그룹 개수 
    public int getTotalCount(String searchId) {
    	try {
    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
    		
    		String sql = "SELECT COUNT(*) FROM group_info g " +
    					 "JOIN members m ON g.leader = m.m_idx ";
    		
    		if (searchId != null && !searchId.equals("")) {
                sql += "WHERE m.id LIKE ? ";
            }

            ps = conn.prepareStatement(sql);

            if (searchId != null && !searchId.equals("")) {
                ps.setString(1, "%" + searchId + "%");
            }

            rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
            
    	}catch(Exception e) {
    		e.printStackTrace();
    		return 0;
    		
    	}finally {
    		try {
    			if(rs != null) rs.close();
    			if(ps != null) ps.close();
    			if(conn != null) conn.close();
    		}catch(Exception e2) {
    		}
    	}
    }

    // 그룹 리스트
    public ArrayList<groupdelDTO> getGroupList(String searchId, int cp, int ls) {
        ArrayList<groupdelDTO> arr = new ArrayList<>();

        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            
            int start = (cp -1) * ls + 1;
            int end = cp * ls;

            String sql =
                    "SELECT * FROM ( " +
                    "   SELECT ROWNUM rnum, a.* FROM ( " +
                    "       SELECT g.g_idx, g.g_name, g.g_memo, g.g_profile, " +
                    "              g.leader, m.id AS leader_id " +
                    "       FROM group_info g " +
                    "       JOIN members m ON g.leader = m.m_idx ";
            		
            if(searchId != null && !searchId.equals("")) {
            	sql += "WHERE m.id LIKE ? ";
            }
            
            sql += "ORDER BY g_idx DESC" +
            	   "   ) a " +
            	   ") WHERE rnum >= ? AND rnum <= ?";
            
            ps = conn.prepareStatement(sql);
            
            int i = 1;
            
            if(searchId != null && !searchId.equals("")) {
            	ps.setString(i++, "%" + searchId + "%");
            }
            
            ps.setInt(i++, start);
            ps.setInt(i, end);
            
            rs = ps.executeQuery();

            while (rs.next()) {
                groupdelDTO dto = new groupdelDTO(
                    rs.getInt("g_idx"),
                    rs.getInt("leader"),
                    rs.getString("g_name"),
                    rs.getString("g_memo"),
                    rs.getString("g_profile"),
                    rs.getString("leader_id")
                );
                arr.add(dto);
            }
            return arr;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {}
        }
    }

    // 그룹 삭제
    public int deleteGroup(int g_idx) {
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            String sql = "DELETE FROM group_info WHERE g_idx=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, g_idx);

            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {}
        }
    }
}
