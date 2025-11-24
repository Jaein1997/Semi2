package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class groupdelDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public groupdelDAO() {}

    // 그룹 리스트
    public ArrayList<groupdelDTO> getGroupList() {
        ArrayList<groupdelDTO> arr = new ArrayList<>();

        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();

            String sql = "SELECT * FROM group_info ORDER BY g_idx DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                groupdelDTO dto = new groupdelDTO(
                    rs.getInt("g_idx"),
                    rs.getString("g_name"),
                    rs.getString("g_memo"),
                    rs.getString("g_profile"),
                    rs.getInt("leader")
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
