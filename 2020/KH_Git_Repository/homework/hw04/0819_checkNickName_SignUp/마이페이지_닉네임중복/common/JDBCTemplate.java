package common;

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
	private JDBCTemplate() {
	}

	// 데이터베이스 접근할때 객체 생성없이 공동으로 접근하도록한다.
	public static Connection getConnection() {
		// java.sql.Connection
		Connection conn = null;

		// 프로퍼티를 이용하여 드라이버 정보를 가져온다.
		// java.util.Properties
		Properties prop = new Properties();

		String fileName=JDBCTemplate.class.getResource("/sql/driver.properties").getPath();
		
		
			try {
				prop.load(new FileReader(fileName) );
				Class.forName(prop.getProperty("driver"));
				conn=DriverManager.getConnection(prop.getProperty("url"),
						prop.getProperty("user"),
						prop.getProperty("password"));
				
				conn.setAutoCommit(false); //자동커밋 방지.
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		return conn;
	}
	
	
	public static void close(Connection conn) {
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	

	public static void commit(Connection conn) {
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
	
	//ResultSet을 닫는다.
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
	
	
	
}