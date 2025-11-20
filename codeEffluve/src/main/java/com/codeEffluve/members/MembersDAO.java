package com.codeEffluve.members;

import java.sql.*;
import java.util.*;

public class MembersDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	
	private static MembersDAO mdao = new MembersDAO();
	
	public static MembersDAO getInstance() {
	    return mdao;
	}
	
	
	public static final int WRONG_ID = 1;
	public static final int WRONG_PWD = 2; 
	public static final int CORRECT_IDPWD = 3;
	public static final int ERROR = -1;
	
	public MembersDAO() {
		
	}
	
	public int getMemberMidx(String id) {
	    int m_idx = 0;
	    
	    
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    String sql = "select m_idx from members where id = ?"; 
	    
	    try {
	    
	        conn = com.codeEffluve.db.CodeEffluveDB.getConn(); 
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, id);
	        
	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            m_idx = rs.getInt("M_IDX");
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("ERROR: getMemberMidx 중 DB 오류 발생: " + e.getMessage());
	    } finally {
	        // DB 리소스 해제
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (conn != null) conn.close(); 
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	    }
	    return m_idx;
	}
	
	
	public int makeAccount(MembersDTO mdto) {
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
	
	public int idCheck(String id) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			
			String sql = "select * from members where id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				return 1; 
			}
			return 0; 
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
	
	
	
	
	public MembersDTO getMemberInfo(String id) {
	    MembersDTO dto = null;
	    try {
	        conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	        
	        String sql = "select * from members where id=?";
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, id);
	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            dto = new MembersDTO();
	            dto.setM_idx(rs.getInt("M_IDX")); 
	            dto.setId(rs.getString("ID"));
	            dto.setPwd(rs.getString("PWD")); 
	            dto.setM_name(rs.getString("M_NAME"));
	            dto.setSex(rs.getString("SEX"));
	            dto.setBirthday(rs.getDate("BIRTHDAY"));
	            dto.setTel(rs.getString("TEL"));
	            dto.setM_profile(rs.getString("M_PROFILE"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(rs!=null)rs.close();
	            if(ps!=null)ps.close();
	            if(conn!=null)conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return dto;
	}
	
	public int updateMember(MembersDTO dto) {
	    int count = 0;
	    try {
	        conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	        
	        String sql = "update members set pwd=?, m_name=?, sex=?, birthday=?, tel=?, m_profile=? where m_idx=?";
	        
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, dto.getPwd());     
	        ps.setString(2, dto.getM_name());
	        ps.setString(3, dto.getSex());
	        ps.setDate(4, dto.getBirthday());
	        ps.setString(5, dto.getTel());
	        ps.setString(6, dto.getM_profile());
	        ps.setInt(7, dto.getM_idx()); 
	        
	        count = ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(ps!=null)ps.close();
	            if(conn!=null)conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return count;
	}
	
	public boolean checkPassword(int mIdx, String encryptedPwd) {
	    boolean result = false;
	   
	    ResultSet tempRs = null;
	    PreparedStatement tempPs = null;
	    Connection tempConn = null;

	    try {
	        tempConn = com.codeEffluve.db.CodeEffluveDB.getConn();
	        
	        String sql = "select pwd from members where m_idx=?";
	        tempPs = tempConn.prepareStatement(sql);
	        tempPs.setInt(1, mIdx);
	        tempRs = tempPs.executeQuery();
	        
	        if (tempRs.next()) {
	            String dbPwd = tempRs.getString("PWD");
	            if (dbPwd.equals(encryptedPwd)) {
	                result = true;
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(tempRs!=null)tempRs.close();
	            if(tempPs!=null)tempPs.close();
	            if(tempConn!=null)tempConn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return result;
	}
	
	public int deleteMember(int m_idx) {
	    int count = 0;
	    try {
	        conn = com.codeEffluve.db.CodeEffluveDB.getConn();
	        
	      
	        String sql = "delete from members where m_idx=?";
	        
	        ps = conn.prepareStatement(sql);
	        ps.setInt(1, m_idx);
	        
	        count = ps.executeUpdate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(ps!=null)ps.close();
	            if(conn!=null)conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return count;
	}
	
}