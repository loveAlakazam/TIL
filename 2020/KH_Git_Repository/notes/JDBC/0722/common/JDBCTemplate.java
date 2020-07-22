package com.kh.common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {
	// 객체를 생성하지 않아도 공동으로 connection을 사용하도록 한다.
	// 일단은 먼저 null로 초기화한다.
	private static Connection conn=null;
	
	//생성자
	private JDBCTemplate() {}
	
	//객체 생성없이 사용한다.
	public static Connection getConnection() {
		if(conn==null) {
			//connection이 null이라면(연결 안된 상태)
			//connection을 연결한다.
				
			//프로퍼티를 열람할 수 있는 프로퍼티 객체를 만든다.
			Properties prop = new Properties();
			
			
			try {
				//프로퍼티를 연다.
				//driver.properties는 연결하는 데이터베이스에 관한 정보이다.
				prop.load(new FileReader("driver.properties"));
				
		
				Class.forName("oracle.jdbc.driver.OracleDriver"); //드라이버 이름=> DriverManager을 생성한다.
				
				// DriverManager을 만든뒤에, Connection을 만든다.
				conn=DriverManager.getConnection(
						prop.getProperty("url"), //내가 사용하고 있는 데이터베이스 정보
						prop.getProperty("user"),//접속하려는 데이터베이스 계정 이름
						prop.getProperty("password"));//접속하려는 데이터베이스 계정 비밀번호
				
				conn.setAutoCommit(false); //자동커밋 방지
				
			} catch (IOException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return conn; // 만든 커넥션을 리턴한다.
	}
	
	
	//트렌젝션처리
	public static void commit(Connection conn) {
		try {
			// connection이 존재하고, 닫혀있지 않은 상태라면 => commit을 한다.
			if(conn!=null && !conn.isClosed()) {
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//Connection을 닫는다.
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
	
	// Statement/PreparedStatement 객체를 닫는다.
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
