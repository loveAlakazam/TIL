package board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import board.model.exception.BoardException;
import board.model.vo.Board;
import board.model.vo.PageInfo;
import board.model.vo.SearchCondition;

public class BoardDAO {

	public int getListCount(SqlSession session) throws BoardException {
		//게시글의 총 개수 => 내가 가지고 올값 1개(COUNT결과값)
		int listCount=session.selectOne("boardMapper.selectListCount");
		
		if(listCount<=0) {
			session.close();
			throw new BoardException("게시글이 존재하지 않습니다! - 게시글 조회에 실패하였습니다!");
		}
		return listCount;
	}

	public ArrayList<Board> selectBoardList(SqlSession session, PageInfo pi) throws BoardException {
		/*paging처리에서 mybatis가 편하다.*/
		
		/*
		 [1페이지]
		 글1
		 글2
		 글3
		 글4
		 글5
		 
		 [2페이지]
		 글6
		 글7
		 글8
		 글9
		 글10
		 
		 [3페이지]
		 글11
		 글12
		 글13
		 글14
		 글15
		 
		 내가 현재 1페이지에 위치: 0개 뛰어넘음
		 내가 현재 2페이지에 위치: 5개 뛰어넘음
		 내가 현재 3페이지에 위치: 10개 뛰어넘음
		 
		 boardLimit: 한페이지에 있는 게시글 개수: 5개
		 * */
		
		//offset: 몇개의 게시글을 건너 뛸것인 지를 말함
		//			offset= (현재내페이지-1) * boardLimit
		int offset=(pi.getCurrentPage()-1)*pi.getBoardLimit();
		
		
		//RowBounds 
		// MyBatis가 제공하는 페이징처리를 위한 클래스이다.
		// limit: offset만큼 건너뛴 후에 현재 페이지에 있는 게시글 몇개 가지고 올거야?
		// 예: 3페이지에있는 게시글 몇개 가지고올거야?
		RowBounds rowBounds= new RowBounds(offset, pi.getBoardLimit());
		
		//arg0: 어떤쿼리에 접근할지 mapper이름을 넣는다
		
		//arg1: 매개변수로부터 넘겨받을값
		// => 그런데 이미 pi는 RowBounds에서 사용됨.
		// => 전달할 값이 존재하지 않는다면, null을 표기!
		
		//arg2: Rowbounds객체
		ArrayList<Board> list=(ArrayList) session.selectList("boardMapper.selectBoardList", null, rowBounds);
//		System.out.println(list);
		
		if(list==null) {
			session.close();
			throw new BoardException("게시글 조회 실패");
		}
		return list;
	}
	

	public int updateCount(SqlSession session, int bId) throws BoardException {
		int result=session.update("boardMapper.updateCount", bId);
		if(result<=0) {
			session.rollback();
			session.close();
			
			throw new BoardException("게시글 상세 조회 - 조회수 카운트 실패");
		}
		return result;
	}
	

	public Board selectBoardDetail(SqlSession session, int bId) throws BoardException {
		Board board= session.selectOne("boardMapper.selectBoardDetail", bId);
		
		if(board==null) {
			session.close();
			throw new BoardException("게시글 상세조회에 실패하였습니다.");
		}
		return board;
	}

	public int getSearchResultListCount(SqlSession session, SearchCondition sc) throws BoardException {
		int result=session.selectOne("boardMapper.selectSearchResultCount", sc);
		
		if(result<=0) {
			session.close();
			throw new BoardException("검색 결과 카운트 조회에 실패하였습니다.");
		}
		return result;
	}

	public ArrayList<Board> selectSearchResultList(SqlSession session, SearchCondition sc, PageInfo pi) throws BoardException {
		// offset: 한페이지당 몇개의 게시물을 건너뛸것인지
		int offset= (pi.getCurrentPage()-1)*pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		
		//전달할 값 SearchCondition 객체가 있다.
		ArrayList<Board> list= (ArrayList) session.selectList("boardMapper.selectSearchResultList", sc , rowBounds);
		
		if(list==null) {
			session.close();
			throw new BoardException("검색결과 리스트 조회에 실패하였습니다.");
		}
		return list;
	}


}
