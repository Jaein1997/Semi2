package com.codeEffluve.db;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class CodeEffluveDB {
	
	static DataSource ds;
	
	static{  //프로그램 시작하자마자 실행
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConn() throws Exception {	
		return ds.getConnection();
	}
}
