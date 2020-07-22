package com.kh.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.board.model.vo.Board;
import com.kh.board.service.BoardService;
import com.kh.view.View;

public class BoardController {

	private BoardService bService= new BoardService();
	private View view =new View();
	
	public void selectAll() {
		ArrayList<Board> bList= bService.selectAll();
		if(!bList.isEmpty()) {
			//bList가 비어있지 않으면
			view.selectAll(bList);
		}else {
			view.displayError("조회결과가 없습니다!");
		}
	}

	public void insertBoard() {
		//글을 입력한다.
		Board board= view.insertBoard();
		
		//서비스를 호출
		int result= bService.insertBoard(board);
		if(result>0) {
			view.displaySuccess("게시글이 등록되었습니다!");
		}else {
			view.displayError("게시글 등록과정 중 오류가 발생했습니다.");
		}
		
	}

	public void selectOne() {
		int no=view.inputBNo(); //글번호를 받는다.
		
		//이후 각자 구현
		//no에 해당하는 글이 존재하는지 확인.
		Board board= bService.selectOne(no);
		
		if(board==null) {
			//no에 해당하는 게시글 board가 존재하지 않는다.
			view.displayError("해당글이 존재하지 않습니다!");
		}else {
			//no에 해당하는 게시글 board가 존재한다
			view.selectOne(board);
		}
	}

	public void updateBoard() {
		// 어떤글을 수정할지
		int no=view.inputBNo();
		
		//수정하려는 글번호가 존재하는지 확인
		Board board= bService.selectOne(no);
		
		if(board!=null) {
			//글이 존재한다.
			//내가 쓴 글만 수정. => 글작성자id와 현재나의아이디가 일치
			String memberId= view.getMemberId(); // 나의 아이디를 가져온다.
			
			if(board.getWriter().equals(memberId)) {
				//글작성자의 아이디와, 현재회원(나)의 아이디가 같다
				//수정이 가능하다.
				int sel= view.updateMenu(); //어떤컬럼데이터를 변경할지를 번호로 나타냄.
				String selStr= null;//변경할 컬럼이름(제목/내용 중 택 1)
				String upStr= null; //변경할 제목/내용
				
				switch(sel) {
				case 1: 
					selStr="Title";
					upStr=view.updateTitle();
					break;
				case 2: 
					selStr="Content";
					upStr=view.updateContent();
					break;
				case 0: return;
				}
				
				// 이후 각자 구현 : no / upStr / selStr
				// no: 수정대상 게시글번호(게시글구분)
				// upStr: 수정할 내용
				// selStr: 수정 대상 컬럼
				int result= bService.updateBoard(no, upStr, selStr);
				
				//업데이트가 성공했는지/ 실패했는지 확인
				if(result>0) {
					//업데이트 성공
					String column;
					if(selStr.contentEquals("Title"))
						column="제목";
					else
						column="내용";
					
					String resultMsg="해당 글"+column +" 수정을 성공적으로 수행하였습니다.";
					view.displaySuccess(resultMsg);
				}else {
					//업데이트 실패
					view.displayError("해당글 수정중에 오류가 발생하였습니다.");
				}
				
			}else {
				//글작성의 아이디와, 현재회원의 아이디가 다르다.
				view.displayError("해당 글을 수정할 수 없습니다!");
			}
			
		}else {
			//글이 존재하지 않는다.
			view.displayError("해당 번호의 글이 존재하지 않습니다.");
		}
	}

	public void deleteBoard() {
		// 어떤글을 삭제(delete_yn 을 n-> y로 업데이트)
		// 삭제하려는 글번호를 받는다.
		int no= view.inputBNo();
		
		// 해당 번호에 맞는 글이 존재하는지 확인
		Board board= bService.selectOne(no);
		
		if(board!=null) { //글이 존재한다.
			
			
			//현재 로그인한계정의 아이디
			String memberId= view.getMemberId();
			
			// 글의 작성자의 아이디와 로그인한 아이디가 일치한지 확인
			if(memberId.equals(board.getWriter())) {
				// 일치한다면 
				// 	=> 진짜삭제하시겠습니까? 확인 메시지 같이 받는다.
				char isDeleted=view.deleteBoard();
				if(isDeleted=='y') {
					//정말 삭제함.
					//게시글 번호 no에 해당하는 글을 삭제한다.
					int result=bService.deleteBoard(no);
					if(result>0) {
						//삭제 성공
						view.displaySuccess("게시물 삭제를 성공하였습니다!");
					}else {
						view.displayError("게시물 삭제를 실패하였습니다!");
					}
					
				}else if(isDeleted=='n') {
					//삭제안함
					view.displayError("게시물 삭제를 취소합니다");
				}else {
					view.displayError("잘못 입력하셨습니다!");
				}
			}else {
				// 일치하지 않으면 삭제를 안되게 한다.
				view.displayError("해당글을 삭제할 수 없습니다!");
			}
			
		}else { //글이 존재하지 않는다.
			view.displayError("해당 번호의 글이 존재하지 않습니다!");
		}
	}
}
