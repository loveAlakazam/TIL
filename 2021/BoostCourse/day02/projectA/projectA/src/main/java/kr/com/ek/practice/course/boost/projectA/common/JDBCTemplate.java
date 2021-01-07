package kr.com.ek.practice.course.boost.projectA.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCTemplate {
	private static Connection conn=null;
	
	//객체 생성자를 private로 하고
	private JDBCTemplate() {}
	
	//객체생성없이 사용한다. (싱글톤 패턴)
	// 드라이버연결하여 커넥션객체를 바로 반환해주는 메소드
	public static Connection getConnection() {
		// Connection 객체가 존재하지 않으면 => 드라이버로부터 객체를 생성한다.
		if(conn==null) {
			
			try {
				//드라이버를 연다.
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				//드라이버로부터 커넥션을 불러온다.
				conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/connectdb?serverTimezone=UTC", 
													"connectuser", 
													"connect123!@#");
				
				//자동커밋 방지
				conn.setAutoCommit(false);
			
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
	
	
	//트랜젝션 처리
	public static void commit(Connection conn) {
		//connection객체가 존재하고, 닫혀있지 않은 상태
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void rollback(Connection conn) {
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//Conenction, ResultSet, PreparedStatement, Statement 객체를 닫아준다.
	public static void close(Connection conn) {
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(ResultSet rset) {
		try {
			if(rset!=null && !rset.isClosed()) {
				rset.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Statement stmt) {
		try {
			if(stmt!=null && !stmt.isClosed()) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(PreparedStatement pstmt) {
		try {
			if(pstmt!=null && !pstmt.isClosed()) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
