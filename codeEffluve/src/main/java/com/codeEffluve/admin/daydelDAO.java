package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class daydelDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public daydelDAO() {}

    
    // 전체 일정 개수 
    public int getTotalCount(String searchId) {
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();

            String sql = "SELECT COUNT(*) FROM todolist t JOIN members m ON t.m_idx = m.m_idx ";

            if(searchId != null && !searchId.equals("")) {
                sql += "WHERE m.id LIKE ? ";
            }

            ps = conn.prepareStatement(sql);

            if(searchId != null && !searchId.equals("")) {
                ps.setString(1, "%" + searchId + "%");
            }

            rs = ps.executeQuery();
            rs.next();

            return rs.getInt(1);

        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            try {
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(Exception e2){}
        }
    }



    // 일정 리스트
    public ArrayList<daydelDTO> getTodoList(String searchId, int cp, int ls) {
        ArrayList<daydelDTO> arr = new ArrayList<>();

        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();

            int start = (cp - 1) * ls + 1;
            int end = cp * ls;

            String sql =
                "SELECT * FROM ( " +
                "   SELECT ROWNUM rnum, a.* FROM ( " +
                "       SELECT t.t_idx, t.m_idx, m.id AS member_id, t.content, t.t_time, t.t_memo, t.shares " +
                "       FROM todolist t " +
                "       JOIN members m ON t.m_idx = m.m_idx ";

            if(searchId != null && !searchId.equals("")) {
                sql += "WHERE m.id LIKE ? ";
            }

            sql += "       ORDER BY t.t_idx DESC " +
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

            while(rs.next()) {
                daydelDTO dto = new daydelDTO(
                        rs.getInt("t_idx"),
                        rs.getInt("m_idx"),
                        rs.getString("member_id"),
                        rs.getString("content"),
                        rs.getDate("t_time"),
                        rs.getString("t_memo"),
                        rs.getString("shares")
                );
                arr.add(dto);
            }

            return arr;

        } catch(Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(Exception e2){}
        }
    }



    // 일정 삭제
    public int deleteTodo(int t_idx) {
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            String sql = "DELETE FROM todolist WHERE t_idx=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, t_idx);
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
