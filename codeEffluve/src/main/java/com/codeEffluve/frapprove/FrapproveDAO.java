package com.codeEffluve.frapprove;

import java.sql.*;

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
}
