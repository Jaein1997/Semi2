package com.codeEffluve.members;

import java.sql.*;
import java.util.*;

public class MembersDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public static final int WRONG_ID = 1;
	public static final int WRONG_PWD = 2; 
	public static final int CORRECT_IDPWD = 3;
	public static final int ERROR = -1;
	
	public MembersDAO() {
		
	}
	
	public int makeAccount(MembersDTO mdto) {  //회원가입 처리
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "insert into members values(members_m_idx.nextval,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,mdto.getId());
			String temp = com.codeEffluve.javasecur.JavaDataSecurModule.getSHA256(mdto.getPwd());  // 암호화
			ps.setString(2, temp);
			ps.setString(3,mdto.getM_name());
			
			ps.setString(4,mdto.getSex());
			ps.setDate(5, mdto.getBirthday());
			ps.setString(6,mdto.getTel());
			ps.setString(7, mdto.getM_profile());
			int count = ps.executeUpdate();
			return count;	
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
				if(rs!=null) rs.close();
 			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public int idCheck(String id) {  //중복검사
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "select * from members where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				return 1;
			}
			return ERROR;
		}	catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
				if(rs!=null) rs.close();
 			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public int loginCheck(String id, String pwd) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "select pwd from members where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,id);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				String dbpwd = rs.getString(1);
				pwd = com.codeEffluve.javasecur.JavaDataSecurModule.getSHA256(pwd);
				if(dbpwd.equals(pwd)) {
					return CORRECT_IDPWD;
				} else {
					return WRONG_PWD;
				}
			} else {
				return WRONG_ID;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
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
	
	public String getUserInfo(String id) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "select m_name from members where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,id);
			rs = ps.executeQuery();
			
			if(rs.next())
				return rs.getString("m_name");
			
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
		return null;
	}
	
	
}
