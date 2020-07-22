package com.kh.board.service;

import static com.kh.common.JDBCTemplate.getConnection;
import static com.kh.common.JDBCTemplate.commit;
import static com.kh.common.JDBCTemplate.rollback;
import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BoardDAO;
import com.kh.board.model.vo.Board;

public class BoardService {

	
	public ArrayList<Board> selectAll() {
		Connection conn=getConnection(); //connection만들기
		BoardDAO bDAO= new BoardDAO();
		ArrayList<Board> bList= bDAO.selectAll(conn);
		return bList;
	}

	public int insertBoard(Board board) {
		Connection conn= getConnection();
		BoardDAO bDAO = new BoardDAO();
		
		int result=bDAO.insertBoard(conn, board);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	public Board selectOne(int no) {
		// Connection 객체를 만든다.
		Connection conn=getConnection();
		BoardDAO bDAO = new BoardDAO();
		Board board= bDAO.selectOne(conn, no);
		return board;
	}

	public int updateBoard(int no, String upStr, String selStr) {
		Connection conn=getConnection();
		BoardDAO bDAO= new BoardDAO();
		
		int result=bDAO.updateBoard(conn, no, upStr, selStr);
		
		if(result>0) {
			// 수정이 성공적으로 이뤄지면 => commit
			commit(conn);
		}else {
			// 수정이 실패하면 => rollback;
			rollback(conn);
		}
		return result;
	}

	public int deleteBoard(int no) {
		Connection conn=getConnection();
		BoardDAO bDAO= new BoardDAO();
		
		int result=bDAO.deleteBoard(conn, no);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

}
