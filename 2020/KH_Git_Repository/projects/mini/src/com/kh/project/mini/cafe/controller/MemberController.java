package com.kh.project.mini.cafe.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

import com.kh.project.mini.cafe.model.dao.ModelDao;
import com.kh.project.mini.cafe.model.vo.Member;

public class MemberController {
	private HashMap<String, Member> map = new HashMap<String, Member>();
	private ModelDao md =new ModelDao();
//// map에 관리자 계정을 넣는다.(딱한번만 넣는다)
//	public final void inputRoot() {
//		map.put("root", new Member("root", "root", "20200101", "None"));
//	}
//
//	public MemberController() {
//		inputRoot();
//		}
//
////	// 변경이된 멤버정보를 업데이트한다.
//	public Member updateMemberInfo(String id) {
//		return map.get(id);
//	}
	
	public MemberController() {
		//dao에서 맵을 불러온다.
		map=md.fileOpen();
		
		//가입된 회원의 정보를 조회.
		showEnrolledMember();
	}
	
	//아이디에 해당하는 회원객체를 갖고온다.
	public Member getMemberFromID(String id) {
		return map.get(id);
		//존재하면 객체를, 존재하지 않으면 null을 반환
	}
	

	// 회원가입
	public boolean memberJoinMenu(String id, Member m) {
		// 아이디(hash map의 Key)가 중복되는지 확인
		if (!map.containsKey(id)) {
			map.put(id, m);
			return true;
		}
		return false;
	}

	// 로그인 확인
	// 이미 가입된 회원이라면 -> 회원의 이름을 리턴.
	public Member logIn(String id, String password) {
		// map에 존재하는 아이디?
		if (map.containsKey(id)) {
			// 이미 가입된 회원이라면
			Member m = (Member) map.get(id);// key(id)에 대한 value(id에 대응하는 Member객체)
			String savedPw = m.getPwd();// 패스워드를 갖고온다.

			// 등록된 비밀번호와 같은가?
			if (savedPw.equals(password))
				return m;
		}
		return null; // 없음.
	}

	// 중복된 아이디를 갖는 회원인지 확인.
	public boolean isDuplicatedMember(String id) {
		return map.containsKey(id) ? true : false;
	}

	// 회원가입이 성공하면, map에 등록한다.
	public void joinMember(String id, Member newMember) {
		map.put(id, newMember); 
		//map에 추가하고
		//map을 아예 새로 덮어쓴다..
		md.fileSave(map);
	}

	// 회원 비밀번호 변경.
	public void changePassword(String id, String newPw) {
		Member m = map.get(id); // id에 대응하는 value(Member)을 갖고온다.
		m.setPwd(newPw);//변경
		md.fileSave(map); //수정사항을 덮어쓴다.
	}

	// 회원 이름 변경
	public void changeName(String id, String newName) {
		Member m = map.get(id);
		m.setName(newName); //변경
		md.fileSave(map); //수정사항을 덮어쓴다.
	}


	// 회원 주소값 변경
	public void changeAddress(String id, String newAddress) {
		Member m = map.get(id);
		System.out.println("[controller-changeAddress] m: "+m);
		m.setAddress(newAddress);//변경
		md.fileSave(map); //수정사항을 덮어쓴다.
	}
	
	//주문내역 표시
	public void updateOrderHistory(String id, String history) {
		Member m=map.get(id);
		
		//주문횟수 카운트
		int orderCnt=m.getOrderCnt()+1;
		
		//주문횟수와 연결리스트 저장.
		m.setOrderCnt(orderCnt);
		m.setOrderHistory(history);
		
		md.fileSave(map);
	}
	
	

	// 회원탈퇴
	public Member dropOutMember(String id) {
		Member dropOuted = map.remove(id);
		md.fileSave(map); //탈퇴이후 map을 저장.
		return dropOuted;
	}

	
	//
	// 현재 등록된 회원들을 보여준다.
	public HashMap<String, Member> enrolledMembers() {
		return map;
	}
	
	public void showEnrolledMember() {
		//현재 등록된 회원 조회
		for(Entry<String, Member> e: map.entrySet()) {
			System.out.println("id: "+e.getKey() +"\t=>"+e.getValue() );
		}
	}
	

	// 새로운 멤버 가입/ 기존 멤버탈퇴/ 멤버 정보 변경 이 발생한경우
	// enrolled.txt 에 멤버 정보를 업데이트 한다.
	// 현재 등록된 멤버들을 저장한다. -> (review - 1단계) 파일입출력 io를 이용하여
	// (upgrade - 2단계) mysql db에 저장.


	// 비밀번호(char형 배열)을 문자열로 나타내기
	public String getPassWordToText(char[] passWords) {
		String cArrToString = ""; // 문자 배열에서 문자열로 변환
		for (int i = 0; i < passWords.length; i++)
			cArrToString += passWords[i];

		return cArrToString;
	}
	
	

}