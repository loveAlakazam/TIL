package board.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import board.model.dao.BoardDAO;
import board.model.vo.Attachment;
import board.model.vo.Board;
import board.model.vo.PageInfo;
import board.model.vo.Reply;

public class BoardService {

	public int getListCount() {
		//데이터베이스 연결커넥션을 만든다.
		Connection conn= getConnection();
		int result=new BoardDAO().getListCount(conn);
		
		//select문은 commit이 필요없다. (데이터를 단순히 조회)
		close(conn);
		return result;
	}

	public ArrayList<Board> selectList(PageInfo pi) {
		Connection conn=getConnection(); //커넥션
		ArrayList<Board> blist= null;
		
		blist=new BoardDAO().selectList(conn, pi);
		if(blist!=null) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn); //connection을 닫는다.
		return blist;
	}

	public Board selectBoard(int bId) {
		Connection conn= getConnection();
		
		//게시글 조회수 증가 - bId에 해당한 게시글을 읽게되므로, board_count가 1씩올라간다.
		BoardDAO Bdao= new BoardDAO();
		
		int result=Bdao.updateCount(conn, bId);
		
		//게시글번호가 bId인 게시글이 존재하는지 확인
		Board board= null;
		if(result>0) {
			board=Bdao.selectBoard(conn, bId);
			if(board!=null) {
				//게시글번호가 bId인 게시글이 존재하면
				commit(conn);
			}else {
				//게시글번호가 bId인 게시글이 존재하지 않다면
				rollback(conn);
			}
		}else {
			//게시글이 존재하지 않는다면
			rollback(conn);
		}
		close(conn);
		return board;
	}

	public ArrayList<Reply> selectReplyList(int bId) {
		Connection conn = getConnection();
		ArrayList<Reply> list= new BoardDAO().selectReplyList(conn, bId);
		close(conn);
		return list;
	}

	public ArrayList<Reply> insertReply(Reply reply) {
		Connection conn= getConnection();
		BoardDAO dao= new BoardDAO();
		
		int result=0;
		result= dao.insertReply(conn, reply);
		
		ArrayList<Reply> list= null;
		if(result>0) {
			commit(conn);
			list= dao.selectReplyList(conn, reply.getRefBid());
		}else {
			rollback(conn);
		}
		
		close(conn);
		return list;
	}

	public ArrayList selectTlist(int i) {
		Connection conn= getConnection();
		ArrayList list= null;
		BoardDAO dao= new BoardDAO();
		
		//int i를 이용하여 board를 가져올건지, 썸네일을 가져올지를 결정
		// i=1 => 게시판을
		// i=2 => 썸네일을
		if(i==1) {
			list= dao.selectBList(conn);
		}else {
			list=dao.selectFList(conn);
		}
		
		close(conn);
		return list;
	}

	public int insertThumbnail(Board board, ArrayList<Attachment> fileList) {
		Connection conn= getConnection();
		BoardDAO dao= new BoardDAO();
		
		int result1= dao.insertThread(conn, board);
		int result2= dao.insertAttachment(conn, fileList);
		
		if(result1>0 && result2>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return result1;
	}

	public ArrayList<Attachment> selectThumbnail(int bId) {
		Connection conn= getConnection();
		int result= new BoardDAO().updateCount(conn, bId);
		ArrayList<Attachment> list= null;
		
		if(result>0) {
			list=new BoardDAO().selectThumbnail(conn, bId);
		
			if(list!=null) {
				commit(conn);
			}else {
				rollback(conn);
			}
		}else {
			rollback(conn);
		}
		return list;
	}

}
