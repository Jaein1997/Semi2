package com.codeEffluve.frapprove;

import java.sql.*;
import java.util.*;

public class FrapproveDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public int addApproval(int applicant, int approver) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql = "insert into frapprove values (?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, applicant);
			ps.setInt(2, approver);
			int result = ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public ArrayList<FrapproveDTO> selectApproval(int approver) {
		try {
			ArrayList<FrapproveDTO> frdtoList = new ArrayList<FrapproveDTO>();
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql = "select * from frapprove where approver=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, approver);
			rs = ps.executeQuery();
			while(rs.next()) {
				FrapproveDTO frdto = new FrapproveDTO();
				frdto.setApplicant(rs.getInt("applicant"));
				frdtoList.add(frdto);
			}
			return frdtoList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public ArrayList<FrapproveDTO> selectApplicant(int applicant) {
		try {
			ArrayList<FrapproveDTO> frdtoList = new ArrayList<FrapproveDTO>();
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql = "select * from frapprove where applicant=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, applicant);
			rs = ps.executeQuery();
			while(rs.next()) {
				FrapproveDTO frdto = new FrapproveDTO();
				frdto.setApprover(rs.getInt("approver"));
				frdtoList.add(frdto);
			}
			return frdtoList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public int acceptApproval(int applicant, int approver) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql = "delete from frapprove where applicant=? and approver=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, applicant);
			ps.setInt(2, approver);
			int result = ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null) rs.close();
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public boolean isApprove(int applicant, int approver) {
		try {
			conn = com.codeEffluve.db.CodeEffluveDB.getConn();
			String sql = "select approver from frapprove where applicant=? and approver=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, applicant);
			ps.setInt(2, approver);
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(rs!=null) rs.close();
				if (ps!=null) ps.close();
				if (conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
