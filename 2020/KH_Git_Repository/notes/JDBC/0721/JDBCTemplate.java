package com.kh.common;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {
	// 공용으로 사용한다. => static
	// singleTone 패턴
	// 필드와 메소드는 static으로한다.
	private static Connection conn=null;
	
	//생성자도 private접근제한자.
	private JDBCTemplate() {}
	
	// 드라이버 등록 & DB연결
	public static Connection getConnection() {
		if(conn==null) {
			try {
				Properties prop =new Properties();
				
				prop.load(new FileReader("driver.properties"));
				
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn=DriverManager.getConnection(prop.getProperty("url"),
												prop.getProperty("user"),
												prop.getProperty("password"));
				
				conn.setAutoCommit(false); //알아서 commit을 못하게 막는다.
				
				//파일을 만들어서 불러올 수 있다.
				/*
				 * Class.forName()
				 * getConnection() 안에있는 문자열 인자.
				 * 
				 * 요즘추세는 그냥 직접 쓰는것임.
				 * 
				 * 파일을 불러오는 방법을 어떻게 해야되지?
				 * 파일에 넣어서 관리하는 방법
				 * 
				 * Key와 Value가 모두 String 타입인 Properties
				 * 
				 * */
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {				
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {		
				e.printStackTrace();
			}
		}
	
		return conn;
	}
	
	
	// 트랜젝션 처리
	public static void commit(Connection conn) {
		// connection 객체가 존재하고, 닫혀있지않다면(열려있다면) => Connection객체의 메소드 commit()실행
		try {
			if(conn != null && !conn.isClosed()) {
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void rollback(Connection conn) {
		// connection 객체가 존재하고, 닫혀있지않다면(열려있다면) => Connection객체의 메소드 rollback()실행.
		try {
			if(conn !=null && !conn.isClosed()) {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// Connection을 닫는다.
	public static void close(Connection conn) {
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// resultSet도 닫는다.
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed()) {
				rset.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// PreparedStatement는 굳이 닫을 필요없다.
	// Statement하나로만 써서 PreparedStatement를 닫아주도록 한다.
	// PreparedStatement는 Statement의 자식클래스이고
	// 업캐스팅을 이용하여 close를 수행할 수 있다.
	public static void close(Statement stmt) {
		try {
			if(stmt !=null && !stmt.isClosed()) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
