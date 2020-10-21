package com.kh.spring.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.board.model.dao.BoardDAO;
import com.kh.spring.board.model.exception.BoardException;
import com.kh.spring.board.model.vo.Board;
import com.kh.spring.board.model.vo.PageInfo;

@Service("bService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BoardDAO bDAO;
	
	@Override
	public int getListCount() {
		return bDAO.getListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Board> selectList(PageInfo pi) {
		return bDAO.selectList(sqlSession, pi);
	}
	
	@Override
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}
	
	@Override
	public Board selectBoard(int bId){
		Board b = null;
		
		//게시글 조회수 증가
		int result= bDAO.addReadCount(sqlSession, bId);
		if(result>0) {
			//bId인 게시글이 존재한다면...
			//게시글 상세 조회
			b= bDAO.selectBoard(sqlSession, bId);
		}
		
		return b;
	}
	
	@Override
	public int bUpdateBoard(Board b) {
		return bDAO.updateBoard(sqlSession, b);
	}
	
	@Override
	public int deleteBoard(int bId) {
		return bDAO.deleteBoard(sqlSession, bId);
	}
}
