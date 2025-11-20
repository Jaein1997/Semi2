package com.yong.db;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class YongDB {
	
	static DataSource ds;
	
	static{
		try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		ds = (DataSource)envContext.lookup("jdbc/myoracle");
		}catch(Exception e) {
			
		}
	}
	public static Connection getConn() throws Exception {
		
		//Connection conn = ds.getConnection();
		System.out.println("스태틱 메소드 실행됨!");
		return ds.getConnection();
	}
	
}
