package guestBook.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Properties;

import guestBook.model.vo.GuestBook;

public class GuestBookDAO {
	private Properties prop= new Properties();
	
	public GuestBookDAO() {
		String fileName= GuestBookDAO.class.getResource("/sql/guestBook/guestBook-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int insertGuestBook(Connection conn, GuestBook gb) {
		PreparedStatement pstmt= null;
		
		String query=prop.getProperty("insertGuestBook");
		int result=0;
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, gb.getName());
			pstmt.setString(2, gb.getContent());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<GuestBook> selectRecentGlist(Connection conn) {
		ArrayList<GuestBook> glist=null;
		
		Statement stmt=null;
		ResultSet rset=null;

		String query=prop.getProperty("selectRecentGlist");
		
		try {
			stmt=conn.createStatement();
			rset=stmt.executeQuery(query);
			glist=new ArrayList<GuestBook>();
			while(rset.next()) {
				GuestBook gb=new GuestBook(rset.getInt("GID"), 
						rset.getString("NAME"), 
						rset.getString("CONTENT"), 
						rset.getDate("GDATE"));
				glist.add(gb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			close(rset);
			close(stmt);
		}
		
		return glist;
	}

	public ArrayList<GuestBook> selectAllGuestBooks(Connection conn) {
		ArrayList<GuestBook> glist=null;
		Statement stmt=null;
		ResultSet rset=null;
		String query= prop.getProperty("selectAllGlist");
		
		try {
			stmt=conn.createStatement();
			rset=stmt.executeQuery(query);
			glist=new ArrayList<GuestBook>();
			while(rset.next()) {
				GuestBook gb= new GuestBook(
					rset.getInt("GID"),
					rset.getString("NAME"),
					rset.getString("CONTENT"),
					rset.getDate("GDATE")
				);
				
				Calendar cal=Calendar.getInstance();
				
				// 시간차이가 3시간 차이난다...
				java.util.Date utilDate= new java.util.Date(rset.getTimestamp("GDATE",cal).getTime());
				gb.setuDate(utilDate);
				glist.add(gb);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			close(stmt);
			close(rset);
		}
		
		return glist;
	}

}
