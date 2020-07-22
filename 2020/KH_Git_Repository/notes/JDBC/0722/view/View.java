package com.kh.view;

import java.util.ArrayList;
import java.util.Scanner;

import com.kh.board.controller.BoardController;
import com.kh.board.model.vo.Board;
import com.kh.member.controller.MemberController;
import com.kh.member.model.vo.Member;

public class View {
	Scanner sc =new Scanner(System.in);
	private static Member mem= null; 
	
	
	public void mainMenu() {
		MemberController mc= new MemberController();
		BoardController bc= new BoardController();
		
		int select= 0;
		do {
			// 로그인이 되어있으면 게시판을 사용할 수 있다.
			// 멤버에 대한 객체 정보가 필요하다.
			System.out.println("\n *** 게시판  프로그램 ***\n");
			
			
			if(mem==null) {
				//로그인을 안되어있는 상태 => 로그인을 한다.
				System.out.println("1. 로그인");
				System.out.println("0. 프로그램 종료");
				System.out.print("선택: ");
				select= Integer.parseInt(sc.nextLine());
				
				switch(select) {
				case 1: mc.login();break;
				case 0: System.out.println("프로그램을 종료합니다.");break;
				default: System.out.println("잘못 입력하셨습니다. 다시 입력해주세요!");
				}
			}else {
				System.out.println("1. 로그아웃");
				System.out.println("2. 글 목록 조회"); // 글은 Board와 관련되어있다.
				System.out.println("3. 게시글 상세 조회"); // 글 한개만 보기
				System.out.println("4. 글 쓰기");
				System.out.println("5. 글 수정");
				System.out.println("6. 글 삭제");
				// 삭제가 아니라, delete_yn컬럼을 'Y'로 UPDATE!
				// 응용 => 보관기한이 지나면(상태값만 바뀜) => 자동탈퇴
				// 함부로 delete를 할 수 없다.
				
				System.out.println("0. 프로그램 종료");
				System.out.print("번호 선택: ");
				select= Integer.parseInt(sc.nextLine());
				
				switch(select) {
					case 1: System.out.println("<<로그 아웃>>"); mem=null; break;
					case 2: bc.selectAll(); break;
					case 3: bc.selectOne(); break;// (ok)
					case 4: bc.insertBoard(); break; //글쓰기
					case 5: bc.updateBoard(); break; //글수정(ok)
					case 6: bc.deleteBoard(); break; //글삭제
					case 0:System.out.println("프로그램을 종료합니다."); break;
					default: System.out.println("잘못입력하셨습니다. 다시 입력해주세요.");
				}
			}
		}while(select!=0);
	}


	public Member inputLogin() {
		//객체가 만들어져야함.
		mem=new Member();
		
		System.out.println("---- 로그인 ----");
		System.out.print("ID: ");
		mem.setMemberId(sc.nextLine()); //아이디 입력
		
		System.out.print("PW: ");
		mem.setMemberPwd(sc.nextLine());//비밀번호 입력
		
		return mem;
	}


	public void displayLoginSuccess() {
		System.out.println(mem.getMemberId()+"님 환영합니다.");
	}


	public void displayLoginError() {
		System.out.println("존재하지 않은 회원입니다. 로그인 실패하였습니다.");
		mem=null;
	}


	public void displayError(String string) {
		System.out.println("서비스 요청 실패: "+string);
	}


	public void selectAll(ArrayList<Board> bList) {
		System.out.printf("%-3s %-15s %-10s %-15s\n",
				"BNO", "TITLE", "WRITER", "CREATE_DATE");
		System.out.println("===================================================");
		for(Board b: bList) {
			System.out.printf("%-3d %-15s %-10s %-15s\n",
					b.getbNo(), b.getTitle(), b.getWriter(), b.getCreateDate());
		}
		
	}


	public Board insertBoard() {
		System.out.println("제목: ");
		String title=sc.nextLine();
		
		// StringBuffer 을 이용하여 내용 입력
		StringBuffer content= new StringBuffer();// 여러개의 한줄씩 읽어온것들의 집합
		StringBuffer str= new StringBuffer(); //한줄씩 읽어옴
		System.out.println("\n================ 내용 입력(종료시 exit 입력) ================\n");
		while(true) {
			str.delete(0, str.capacity());
			str.append(sc.nextLine()); //사용자로부터 입력한 것
			
			// exit을 입력하면 나간다.
			if(str.toString().toLowerCase().equals("exit"))
				break;
			
			content.append(str);
			content.append("\n");
		}
		
		Board board=new Board(title, content.toString(), mem.getMemberId());
		return board;
	}


	public void displaySuccess(String string) {
		System.out.println("서비스 요청 성공: "+ string);
	}


	public int inputBNo() {
		System.out.print("글번호 입력: ");
		int no=Integer.parseInt(sc.nextLine());
		return no;
	}
	
	// 상세조회 성공화면
	public void selectOne(Board board) {
		System.out.println();
		System.out.println("=================================");
		System.out.println("글번호 : "+ board.getbNo());
		System.out.println("글제목: "+ board.getTitle());
		System.out.println("=================================");
		System.out.printf("작성자: %-10s 작성일 : %-15s\n", board.getWriter(), board.getCreateDate());
		System.out.println("=================================");
		System.out.println(board.getContent());
	}


	public String getMemberId() {
		return mem.getMemberId();
	}


	public int updateMenu() {
		int sel=0;
		while(true) {
			System.out.println("1. 제목수정");
			System.out.println("2. 내용수정");
			System.out.println("0. 메인메뉴로 이동");
			System.out.print("번호 선택: ");
			sel=Integer.parseInt(sc.nextLine());
			
			switch(sel) {
			case 1: case 2: case 0: return sel;
			default: System.out.println("잘못 입력하셨습니다. 다시 입력해주세요.");
			}
		}
	}


	public String updateTitle() {
		// 제목 수정
		System.out.println("제목: ");
		String title= sc.nextLine();
		return title;
	}


	public String updateContent() {
		// 내용 수정
		StringBuffer content= new StringBuffer();// 전체 내용(exit제외)
		StringBuffer str=new StringBuffer(); //한줄씩 받아놓음
		System.out.println("-------- 내용 입력 (종료 시 exit 입력) --------------");
		while(true) {
			str.delete(0, str.capacity());
			str.append(sc.nextLine());
			
			if(str.toString().toLowerCase().equals("exit"))
				break;
			content.append(str);
			content.append("\n");
		}
		return content.toString();
	}


	public char deleteBoard() {
		System.out.print("정말로 삭제하시겠습니까?(y/n): ");
		char ans=sc.nextLine().toLowerCase().charAt(0);
		return ans;
	}
}
