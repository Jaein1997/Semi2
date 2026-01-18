package com.codeEffluve.admin;

import java.sql.*;
import java.util.*;

public class qadelDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public qadelDAO() {}

    public int getTotalCount(String searchQ) {
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();

            String sql = "SELECT COUNT(*) FROM qa ";

            if(searchQ != null && !searchQ.equals("")) {
                sql += "WHERE q LIKE ? OR a LIKE ? ";
            }

            ps = conn.prepareStatement(sql);

            if(searchQ != null && !searchQ.equals("")) {
                ps.setString(1, "%" + searchQ + "%");
                ps.setString(2, "%" + searchQ + "%");
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
    
   // QA리스트
    public ArrayList<qadelDTO> getQAList(String searchQ, int cp, int ls) {
        ArrayList<qadelDTO> list = new ArrayList<>();
        
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            
            int start = (cp - 1) * ls + 1;
            int end = cp * ls;
          
            String sql =
                    "SELECT * FROM ( " +
                    "    SELECT ROWNUM rnum, a.* FROM ( " +
                    "        SELECT q_idx, q, a, viewcount " +
                    "        FROM qa ";

                if(searchQ != null && !searchQ.equals("")) {
                    sql += "WHERE q LIKE ? OR a LIKE ? ";
                }
            sql += "        ORDER BY viewcount DESC " +
                    "    ) a " +
                    ") WHERE rnum >= ? AND rnum <= ?";

             ps = conn.prepareStatement(sql);

             int i = 1;

             if(searchQ != null && !searchQ.equals("")) {
                 ps.setString(i++, "%" + searchQ + "%");
                 ps.setString(i++, "%" + searchQ + "%");
             }

             ps.setInt(i++, start);
             ps.setInt(i, end);
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
    
    // 조회수 증가
    public int updateViewCount(int q_idx) {
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            
            String sql = "UPDATE qa SET viewcount = viewcount + 1 WHERE q_idx=?";
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
  
    //자주 묻는 질문 추가
    public int insertQA(String q, String a) {
    	try {
    		conn = com.codeEffluve.db.CodeEffluveDB.getConn();
    		String sql = "INSERT INTO qa (q_idx,q,a,viewcount) values(qa_q_idx.nextval,?,?,0)";
    		ps = conn.prepareStatement(sql);
    		ps.setString(1, q);
    		ps.setString(2, a);

    		return ps.executeUpdate();

    	}catch(Exception e) {
    		e.printStackTrace();
    		return -1;
    	}finally {
    		try {
    			if(ps != null) ps.close();
    			if(conn != null) conn.close();
    		}catch(Exception e2) {}
    	}
    }
    
    public ArrayList<qadelDTO> getQALists() {
        ArrayList<qadelDTO> list = new ArrayList<>();
        try {
            conn = com.codeEffluve.db.CodeEffluveDB.getConn();
            
          
            String sql = "SELECT q_idx, q, a, viewcount FROM qa ORDER BY viewcount DESC"; 
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
    
}

