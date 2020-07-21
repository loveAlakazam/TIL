package com.kh.controller;

import java.util.ArrayList;

import com.kh.model.vo.Member;
import com.kh.service.MemberService;
import com.kh.view.Menu;

public class MemberController {

	//private MemberDAO md= new MemberDAO();
	private MemberService mService= new MemberService();
	private Menu menu =new Menu();
	
	
	// 멤버 추가하기
	public void insertMember() {
		// view에서 추가멤버 정보를 입력한 후에 그 정보들을 바탕으로한
		// 멤버객체를 만든다.
		Member mem= menu.insertMember();
		
		// MemberDAO의 insertMember
//		int result= md.insertMember(mem);
		
		// MemberService 에서의 insertMember
		// 데이터베이스와 연결을하고
		int result= mService.insertMember(mem);
		
		if(result>0) {
			menu.displaySuccess(result+"개 행이 추가되었습니다.");
		}else {
			menu.displayError("데이터 추가에서 오류가 발생했습니다.");
		}
	}


	public void selectAll() {
		ArrayList<Member> mList= mService.selectAll();
		if(!mList.isEmpty()) {
			menu.displayMember(mList);
		}else {
			menu.displayError("조회결과가 업습니다.");
		}
		
	}


	public void selectMember() {
		// 특정조건의 사람을 검색
		int sel= menu.selectMember();
		
		ArrayList<Member> mList= null;
		
		switch(sel) {
		case 1: //아이디로 회원조회
			String id= menu.inputMemberId(); // view에서 조회할 아이디를 입력받는다.
			mList=mService.selectMemberId(id); //서비스영역에서 데이터베이스를 접근 및 트렌젝션
			break;
			
		case 2: //성별로 조회
			char gender=menu.inputGender();// view에서 조회할 성별(M/F)을 입력받는다.
			mList=mService.selectMemberGender(gender);// 서비스영역에서 데이터베이스에 접근 및 트렌젝션
			break;
		case 0:
			return;
		}
		
		if(!mList.isEmpty()) {
			menu.displayMember(mList);
		}else {
			menu.displayError("조회 결과가 없습니다!");
		}
	}


	public void updateMember() {
		String memberId=menu.inputMemberId();
		
		//업데이트 (int형으로 반환) 반환값
		int check= mService.checkMemberId(memberId);
		
		if(check==0) {
			//존재하지 않음
			menu.displayError("입력한 아이디가 존재하지 않습니다!");
		}else {
			//업데이트
			//어떤항목에 대해서 업데이트할지를 받아준다.
			
			//sel: 변경할 컬럼 구분자.
			int sel= menu.updateMember(); 
			if(sel==0) {
				return;//종료
			}
			
			// input: 변경내용
			String input=menu.inputUpdate();
			
			int result= mService.updateMember(sel, memberId, input);
			if(result>0) {
				menu.displaySuccess(result+"개의 행이 수정되었습니다.");
			}else {
				menu.displayError("데이터 수정 과정 중 오류가 발생하였습니다.");
			}
		}
	}
}
