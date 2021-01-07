package kr.com.ek.practice.course.boost.projectA.card.controller;

import java.util.ArrayList;

import kr.com.ek.practice.course.boost.projectA.card.model.service.CardService;
import kr.com.ek.practice.course.boost.projectA.card.model.vo.Card;
import kr.com.ek.practice.course.boost.projectA.view.View;

public class CardController {
	
	private View view=new View();
	private CardService cService= new CardService();
	
	
	//1. 카드 조회
	public void selectAll() {
		ArrayList<Card> cList=  cService.selectAll();
		if(!cList.isEmpty()) {
			view.selectAll(cList);
		}else {
			view.displayError("명함이 존재하지 않습니다!");
		}
	}


	//2. 카드 추가
	public void insertOneCard() {
		Card card= view.insertOneCard();
		int result=0;
		if(card!=null) {
			result=cService.insertOneCard(card);
			
			if(result>0) {
				view.displaySuccess("명함추가를 성공하였습니다.");
				selectAll();
			}else {
				view.displayError("명함추가에 실패하였습니다.");
			}
		}
	}
	
	//이름중복확인
	public int searchName(String name) {
		//입력한 이름이 이미 존재하고 있는지 확인하기.
		//이미 존재하면 result값이 1
		//존재하지 않으면 result값이 0
		int result=cService.isDuplicatedName(name);
		return result;
	}
	

	//3. 카드 검색
	public void selectOneCard() {
		int searchNo= view.selectOneCard();
		
		//검색조건 선택하기
		switch(searchNo) {
			case 1:searchCardNo();break;//명함번호
			case 2:searchName();break;//이름
			default:System.out.println("검색을 취소합니다.");//검색취소
		}
		
	}
	
	//명함번호 검색
	public void searchCardNo() {
		//명함번호 입력
		int cardNo= view.searchCardNo();
		ArrayList<Card> cList=cService.searchCardNo(cardNo);
		if(!cList.isEmpty()) {
			view.selectAll(cList);
		}else {
			view.displayError("검색실패: "+cardNo+"번 카드는 존재하지 않습니다.");
		}
	}
	
	//이름검색
	public void searchName() {
		//이름번호 입력
		String name= view.searchName();
		ArrayList<Card> cList=cService.searchName(name);
		if(!cList.isEmpty()) {
			view.selectAll(cList);
		}else {
			view.displayError("검색실패: '"+name+"' 이름의 명함이 존재하지 않습니다!");
		}
		
		
	}
	
	
	//4. 명함 수정
	public void updateOneCard() {
		// 명함번호 입력
		int cardNo= view.insertCardNo();
		
		// 입력한 명함번호에 해당하는 명함이 있는지 확인
		ArrayList<Card> cardNoList= cService.searchCardNo(cardNo);
		if(!cardNoList.isEmpty()) {
			//이미 존재
			Card card= cardNoList.get(0);
			int menuNo=view.selectMenu();
			switch(menuNo) {
			case 1:updateName(card);break;
			case 2:updateTel(card);break;
			case 3:updateCompanyName(card);break;
			default: view.displaySuccess("명함수정을 취소합니다");
			}
		}else {
			view.displayError("수정실패: 카드번호가 "+cardNo+"번 명함은 존재하지 않습니다.");
		}
	}
	
	
	public void updateName(Card card) {
		//이름 수정
		//이름 중복확인
		String name;
		int result=0;
		do {
			name=view.getChangeName();
			result=searchName(name);
			if(result>0) {
				view.displayError("해당 이름은 이미 존재합니다. 다시 입력해주세요.");
			}
		
		}while(result>0);
		
		card.setName(name); //이름 변경.
		int result2=cService.updateName(card);
		if(result2>0) {
			view.displaySuccess("이름변경을 성공하였습니다.");
		}else {
			view.displayError("이름변경을 실패하였습니다.");
		}
		
	}
	
	public void updateTel(Card card) {
		String tel=view.getChangeTel();
		card.setTel(tel);
		int result=cService.updateTel(card);
		if(result>0) {
			view.displaySuccess("전화번호 변경을 성공하였습니다");
		}else {
			view.displayError("전화번호 변경을 실패하였습니다");
		}
		
	}
	
	public void updateCompanyName(Card card) {
		String companyName= view.getChangeCompanyName();
		card.setCompayName(companyName);
		int result=cService.updateCompanyName(card);
		if(result>0) {
			view.displaySuccess("회사이름 변경을 성공하였습니다.");
		}else {
			view.displayError("회사이름 변경을 실패하였습니다.");
		}
		
	}
	

	//5. 명함 삭제
	public void deleteOneCard() {
		int cardNo= view.insertCardNo();
		ArrayList<Card> cList= cService.searchCardNo(cardNo);
		if(!cList.isEmpty()) {
			int result=cService.deleteCard(cardNo);
			if(result>0) {
				view.displaySuccess("성공적으로 삭제하였습니다.");
				selectAll();
			}else {
				view.displayError("명함 삭제에 실패하였습니다.");
			}
		}else {
			view.displayError("해당 번호의 명함은 존재하지 않습니다!");
		}
		
	}
	
	
}
