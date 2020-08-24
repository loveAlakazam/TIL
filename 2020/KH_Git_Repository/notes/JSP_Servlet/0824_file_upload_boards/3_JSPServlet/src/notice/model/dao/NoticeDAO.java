package notice.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import notice.model.vo.Notice;

public class NoticeDAO {

	private Properties prop= new Properties();
	
	//생성자
	public NoticeDAO() {
		String fileName= NoticeDAO.class.getResource("/sql/notice/notice-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Notice> selectList(Connection conn) {
		Statement stmt= null;
		ResultSet rset= null;
		ArrayList<Notice> list=null;
		
		String query = prop.getProperty("selectNotices");
		
		try {
			stmt= conn.createStatement();
			rset=stmt.executeQuery(query); //select문은 executeQuery, 나머지는(update, delete, insert)는 executeUpdate
			
			list=new ArrayList<Notice>();
			while(rset.next()) {
				Notice no= new Notice(
						rset.getInt("notice_no"),
						rset.getString("notice_title"),
						rset.getString("notice_content"),
						rset.getString("nickname"),
						rset.getInt("notice_count"),
						rset.getDate("notice_date")
				);

				list.add(no);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}

	public int insertNotice(Connection conn, Notice n) {
		PreparedStatement pstmt= null;
		int result=0;
		
		String query=prop.getProperty("insertNotice");
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, n.getNoticeTitle());
			pstmt.setString(2, n.getNoticeContent());
			pstmt.setString(3, n.getNoticeWriter());
			pstmt.setDate(4, n.getNoticeDate());
			result= pstmt.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int updateCount(Connection conn, int no) {
		PreparedStatement pstmt= null;
		int result = 0;
		
		String query = prop.getProperty("updateCount");
		
		
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setInt(1, no);
			result= pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public Notice selectNotice(Connection conn, int no) {
		PreparedStatement pstmt= null;
		ResultSet rset=null;
		Notice notice =null;
		
		String query= prop.getProperty("selectNotice");
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, no);
			rset=pstmt.executeQuery();
			if (rset.next()) {
				notice= new Notice(
							rset.getInt("NOTICE_NO"),
							rset.getString("NOTICE_TITLE"),
							rset.getString("NOTICE_CONTENT"),
							rset.getString("NOTICE_WRITER"),
							rset.getString("NICKNAME"),
							rset.getInt("Notice_count"),
							rset.getDate("NOTICE_DATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return notice;
	}

	public int updateNotice(Connection conn, int no, String title, String content, Date date) {
		int result=0;
		PreparedStatement pstmt=null;
		String query= prop.getProperty("updateNotice");
		
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setDate(3, date);
			pstmt.setInt(4, no);
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

}
