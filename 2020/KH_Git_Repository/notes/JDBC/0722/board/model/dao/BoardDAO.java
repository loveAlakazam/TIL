package com.kh.board.model.dao;

import static com.kh.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.board.model.vo.Board;

public class BoardDAO {

	private Properties prop= null;
	
	public BoardDAO() {
		//프로퍼티 객체를 생성한다.
		prop=new Properties();
		
		try {	
			//BoardDAO객체를 생성하자마자.
			// query.properties 파일을 읽어온다.
			prop.load(new FileReader("query.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public ArrayList<Board> selectAll(Connection conn) {
		Statement stmt= null;
		ResultSet rset= null;
		ArrayList<Board> bList=null;
		
		String query= prop.getProperty("selectAll"); 
		try {
			stmt=conn.createStatement(); //Statement는 완전한 쿼리문을 수행한다.
			rset=stmt.executeQuery(query); //쿼리문 실행
			
			bList=new ArrayList<Board>();
			while(rset.next()) {
				Board board= new Board(rset.getInt("bno"),
										rset.getString("title"),
										rset.getString("content"),
										rset.getDate("create_date"),
										rset.getString("writer"));
				bList.add(board);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return bList;
	}


	public int insertBoard(Connection conn, Board board) {
		int result=0;
		PreparedStatement pstmt= null;
		
		//쿼리문을 작성한다.
		String query= prop.getProperty("insertBoard");
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getWriter());
			
			//쿼리 수행
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
	
		return result;
	}


	public Board selectOne(Connection conn, int no) {
		Board board=null;
		PreparedStatement pstmt= null;
		ResultSet rset= null;
		
		//쿼리문을 만든다.
		String query=prop.getProperty("selectOne");
		
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setInt(1, no);
			rset=pstmt.executeQuery(); //쿼리문을 수행
			
			if(rset.next()) {
				board= new Board(
						rset.getInt("bno"),
						rset.getString("title"),
						rset.getString("content"),
						rset.getDate("create_date"),
						rset.getString("writer"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return board;
	}


	public int updateBoard(Connection conn, int no, String upStr, String selStr) {
		int result=0;
		PreparedStatement pstmt= null;
		
		String query=prop.getProperty("updateBoard"+selStr);
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, upStr);
			pstmt.setInt(2, no);
			
			result=pstmt.executeUpdate(); //update 쿼리문 수행
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}


	public int deleteBoard(Connection conn, int no) {
		int result=0;
		PreparedStatement pstmt=null;
		
		String query= prop.getProperty("deleteBoard");
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, no);
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
}
