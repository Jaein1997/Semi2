package com.codeEffluve.cs;

import com.codeEffluve.members.MembersDAO; 
import java.sql.*;

public class CsDAO {

    
    private static CsDAO instance = new CsDAO();

    private CsDAO() { }

    public static CsDAO getInstance() { return instance; }
    

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

   
    private Connection getConnection() throws Exception {
        return com.codeEffluve.db.CodeEffluveDB.getConn(); 
    }

    private void close() {
        
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int insertProblem(String writerId, String title, String content) {
        int result = 0;
        
        try {
            
            int m_idx = MembersDAO.getInstance().getMemberMidx(writerId); 
            
            if (m_idx <= 0) {
                System.out.println("ERROR: 유효한 M_IDX를 찾을 수 없어 singo 테이블에 저장 불가. ID: " + writerId);
                return 0; 
            }
            
            
            String sql = "insert into singo (s_idx, m_idx, title, content, s_date) " +
                         "values (singo_seq.nextval, ?, ?, ?, sysdate)";
            
           
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, m_idx);        
            ps.setString(2, title);     
            ps.setString(3, content);   
            
            result = ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR: insertProblem (singo) 중 DB 오류 발생: " + e.getMessage());
        } finally {
            close();
        }
        return result;
    }
}