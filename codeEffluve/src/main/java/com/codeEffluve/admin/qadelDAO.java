package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class qadelDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public qadelDAO() {}

    // QA목록
    public ArrayList<qadelDTO> getQAList() {
        ArrayList<qadelDTO> list = new ArrayList<>();
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            
            String sql = "SELECT * FROM qa ORDER BY q_idx DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while(rs.next()) {
                qadelDTO dto = new qadelDTO(
                    rs.getInt("q_idx"),
                    rs.getString("q"),
                    rs.getString("a"),
                    rs.getInt("viewcount")
                );
                list.add(dto);
            }
            return list;

        } catch(Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if(rs != null) rs.close();
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(Exception e2) {}
        }
    }

    // QA삭제
    public int deleteQA(int q_idx) {
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            String sql = "DELETE FROM qa WHERE q_idx=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, q_idx);

            return ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch(Exception e2) {}
        }
    }
}














