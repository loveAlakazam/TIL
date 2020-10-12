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

	public ArrayList<Board> selectBoardList(PageInfo pi) {
		SqlSession session= getSqlSession();
		ArrayList<Board> list= new BoardDAO().selectBoardList(session, pi);
		
		return list;
	}

}
