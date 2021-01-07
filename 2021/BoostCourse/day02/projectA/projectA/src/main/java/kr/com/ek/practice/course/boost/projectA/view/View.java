package kr.com.ek.practice.course.boost.projectA.view;

import java.util.ArrayList;
import java.util.Scanner;

import kr.com.ek.practice.course.boost.projectA.card.controller.CardController;
import kr.com.ek.practice.course.boost.projectA.card.model.vo.Card;

public class View {
	Scanner sc= new Scanner(System.in);
	private static Card card=null;
	private static CardController cc=null;
	
	public void mainMenu(){
		
		int select=0;
		cc=new CardController();
		do {
			System.out.println("=========================================================");
			System.out.println("1. 명함 조회");
			System.out.println("2. 명함 입력");
			System.out.println("3. 명함 검색");
			System.out.println("4. 명함 수정");
			System.out.println("5. 명함 삭제");
			System.out.println("6. 종료");
			
			System.out.println("=========================================================");
			System.out.print("메뉴를 입력하세요: ");
			select= Integer.parseInt(sc.nextLine());
			
			switch(select){
				case 1:cc.selectAll();break;
				case 2:cc.insertOneCard();break;
				case 3:cc.selectOneCard();break;
				case 4:cc.updateOneCard();break;
				case 5:cc.deleteOneCard();break;
				case 6:System.out.println("프로그램을 종료합니다.");break;
				default: System.out.println("1~6 숫자를 입력해주세요!");
			}
		}while(select!=6);
		
	}
	
	
	//성공메시지
	public void displaySuccess(String msg) {
		System.out.println(msg+"\n");
	}
	
	//에러메시지
	public void displayError(String msg) {
		System.out.println("서비스요청 실패: "+ msg+"\n");
	}


	//1.명함 조회
	//검색결과 출력
	public void selectAll(ArrayList<Card> cList) {
		System.out.printf("%-5s %-5s %-15s %-20s\n", "NO", "이름", "전화번호", "회사이름");
		System.out.println("=========================================================");
		for(Card c : cList) {
			System.out.printf("%-5s %-5s %-10s %-20s\n", c.getCardNo() , c.getName(), c.getTel(), c.getCompayName());
		}
		System.out.println("=========================================================");
	}


	//2. 명함 추가
	public Card insertOneCard() {
		Card card= null;
		String name;
		String tel;
		String companyName;
		
		boolean isAvailable=false;
		do {
			System.out.print("이름을 입력하세요: ");
			name= sc.nextLine();
			
		}while(name.length()<=0 || name.length()>3 ); 
		
		
		//이미 존재하는 이름인지 확인
		if(cc.searchName(name)==0) {
			isAvailable=true;
			
			do {
				System.out.print("전화번호를 입력하세요('-'포함, 예: 010-1234-5678): ");
				tel=sc.nextLine();
			}while(tel.length()<=0);
			
			do {
				System.out.print("회사이름을 입력하세요: ");
				companyName= sc.nextLine();
			}while(companyName.length()<=0);
			
			if(isAvailable) {
				card=new Card(name, tel, companyName);
			}
		}else {
			System.out.println("\n해당이름의 명함이 이미 존재합니다.");
		}
		
		return card;
	}

	// 3. 카드 검색
	public int selectOneCard() {
		System.out.println("=========================================================");
		System.out.println("1: 명함 번호");
		System.out.println("2: 이름");
		System.out.println("1,2 이외 다른숫자: 검색 취소");
		
		System.out.println("=========================================================");
		System.out.print("검색조건 입력 해주세요: ");
		int searchNo= Integer.parseInt(sc.nextLine());
		
		return searchNo;
	}


	//3-1. 명함번호 입력
	public int searchCardNo() {
		int cardNo;
		System.out.print("검색할 카드번호(숫자)를 입력해주세요: ");
		cardNo=Integer.parseInt(sc.nextLine());
	
		return cardNo;
	}


	//3-2. 이름 입력
	public String searchName() {
		String name;
		do {
			System.out.print("검색할 이름을 입력해주세요: ");
			name=sc.nextLine();
		}while(name.length()<=0);
		return name;
	}


	//4. 명함 수정
	//명함 번호 입력
	public int insertCardNo() {
		int cardNo;
		do {
			System.out.print("명함 번호를 입력하세요: ");
			cardNo=Integer.parseInt(sc.nextLine());
		}while(cardNo<=0);
		return cardNo;
	}
	
	public int selectMenu() {
		int menuNo=0;
		do {
			System.out.println("[어떤 정보를 수정할까요?]");
			System.out.println("=========================================================");
			System.out.println("1: 이름");
			System.out.println("2: 전화번호");
			System.out.println("3: 회사이름");
			System.out.println("0: 수정취소");
			
			System.out.println("=========================================================");
			System.out.print("입력 메뉴번호 => ");
			menuNo=Integer.parseInt(sc.nextLine());
		}while(menuNo<0 || menuNo>3);
		return menuNo;
	}


	public String getChangeName() {
		String name;
		do {
			System.out.print("수정할 이름 입력: ");
			name=sc.nextLine();
		}while(name.length()<=0);
		return name;
	}


	public String getChangeTel() {
		String tel;
		do {
			System.out.print("수정할 전화번호 입력(- 포함, 예: 010-1234-5678): ");
			tel=sc.nextLine();
		}while(tel.length()<=0);
		return tel;
	}


	public String getChangeCompanyName() {
		String companyName;
		do {
			System.out.print("수정할 회사 이름 입력: ");
			companyName=sc.nextLine();
		}while(companyName.length()<=0);
		return companyName;
	}
	
	
	
	
}
