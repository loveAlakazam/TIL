package board.model.service;
import static common.Template.getSqlSession;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import board.model.dao.BoardDAO;
import board.model.exception.BoardException;
import board.model.vo.Board;
import board.model.vo.PageInfo;
public class BoardService {

	public int getListCount() throws BoardException {
		//SqlSession
		SqlSession session = getSqlSession();
		int listCount=new BoardDAO().getListCount(session);
		
		//세션을 닫는다.
		session.close();
		
		return listCount;
	}

	public ArrayList<Board> selectBoardList(PageInfo pi) throws BoardException {
		SqlSession session= getSqlSession();
		ArrayList<Board> list= new BoardDAO().selectBoardList(session, pi);
		session.close();
		return list;
	}

	public Board selectBoardDetail(int bId) throws BoardException{
		SqlSession session=getSqlSession();
		// 상세게시판 조회
		// 조회수 1증가 시키기
		BoardDAO dao= new BoardDAO();
		int result=dao.updateCount(session, bId);
		
		Board board =null;
		if(result>0) {
			// 상세게시판 불러오기
			board= dao.selectBoardDetail(session, bId);
			session.commit();
			session.close();
		}
		
		return board;
	}

}
