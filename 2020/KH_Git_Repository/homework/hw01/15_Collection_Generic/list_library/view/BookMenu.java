package com.kh.practice.list.library.view;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Scanner;

import com.kh.practice.list.library.controller.BookController;
import com.kh.practice.list.library.model.vo.Book;

public class BookMenu {
	private Scanner sc =new Scanner(System.in);
	private BookController bc =new BookController();
	private String [] BookKinds= {"인문","과학","의료","기타"};
	
	public void mainMenu() {
		do {
			System.out.println("========= Welcome KH Library =========");
			System.out.println("[ 메인 메뉴 ]");
			System.out.println("1. 새 도서 추가 ");
			System.out.println("2. 도서 전체 조회");
			System.out.println("3. 도서 검색 조회");
			System.out.println("4. 도서 삭제");
			System.out.println("5. 도서명 오름차순 정렬");
			System.out.println("9. 종료");
			System.out.print("메뉴 번호 선택: >>> ");
			int menu=Integer.parseInt(sc.nextLine());
			switch(menu) {
				case 1:insertBook(); break;
				case 2:selectList(); break;
				case 3:searchBook(); break;
				case 4:deleteBook(); break;
				case 5:ascBook(); break;
				case 9:
					System.out.println("프로그램을 종료합니다.");return;
				default:
					System.out.println("잘못 입력했습니다. 다시 입력해주세요!");
			}
			System.out.println();
		}while(true);
	}
	
	
	public void insertBook() {
		System.out.println("[ 1. 새 도서 추가 ]");
		System.out.println("책정보를 입력해주세요.");
		System.out.print("도서 명: ");
		String bookName= sc.nextLine();
		
		System.out.print("저자명: ");
		String authorName= sc.nextLine();

		
		String category=null;
		
		/*
		 * [code reinforcing]
		 * 조금더 심화시킨다면, 1,2,3,4,5 등 숫자타입의 값을 입력하지 않고
		 * 인문/과학/ 외국어 이런 문자열형식으로 category에 입력한다거나
		 * 엉뚱한 값을 입력했다면?
		 * */
		try {
			System.out.print("장르(1. 인문/ 2. 과학/ 3. 의료/ 4. 기타): ");
			category=sc.nextLine(); //숫자로 입력받는다.
			
		}catch(NumberFormatException e) {
			//그런데 숫자 형식이 아닌 문자열로 입력이 된다거나 다른 형식으로 입력한다면.
			if(category.trim().equals("인문"))
				category="1";
			else if(category.trim().equals("과학"))
				category="2";
			else if(category.trim().equals("의료"))
				category="3";
			else //기타
				category="4";
		}
		
		category=BookKinds[Integer.parseInt(category)-1];
		
		System.out.print("가격: ");
		int price=Integer.parseInt(sc.nextLine());
		Book newBook = new Book(bookName, authorName, category, price);
		bc.insertBook(newBook);
	}
	
	
	
	
	//2. 도서 전체용 view 메소드
	public void selectList() {
		System.out.println("[ 2. 도서 전체 조회 ]");
		
		/*	1. bc(BookController)의 selectList()메소드 호출 후
			결과값을 임의의 리스트(ArrayList<Book> bookList)에 대입
		*/
		ArrayList<Book> bookList= bc.selectList();
		
		if(bookList.isEmpty()) {
			//2-1. bookList가 비어있는 경우
			System.out.println("존재하는 도서가 없습니다!");
		} else {
			//2-2. bookList가 비어있지 않은 경우, 출력
			printBooks(bookList);
		}
		System.out.println();
	}
	
	
	// 책리스트가 비어있지 않는다면 출력한다.
	public void printBooks(ArrayList<Book> books) {
		Iterator <Book> it= books.iterator();
		while(it.hasNext()) {
			System.out.println("\t"+it.next());
		}
	}
	
	
	public void searchBook() {
		System.out.println("[ 3. 도서 검색 ]");
		System.out.print("검색 키워드 : ");
		String searchKeyword= sc.nextLine();
		
		//검색 키워드 가 포함한 책들의 집합들을 
		ArrayList<Book> searchResult=bc.searchBook(searchKeyword);
		
		//3-1.검색결과가 비어있는가?
		if(searchResult.isEmpty()) {
			System.out.println("검색 결과가 없습니다!");
		}else {
			//3-2. 검색결과가 비어있지 않는다면, 출력
			printBooks(searchResult);
		}
		System.out.println();
	}
	
	
	public void deleteBook() {
		System.out.println("[ 4. 도서 삭제 ]");
		System.out.print("삭제할 도서 명: ");
		String deletedBookName= sc.nextLine();
		
		System.out.print("삭제할 저자 명: ");
		String deletedAuthorName= sc.nextLine();
		
		Book deletedBook = bc.deleteBook(deletedBookName, deletedAuthorName);
		String result="입력하신 도서"+ deletedBookName+" ("+deletedAuthorName+")";
		
		if(deletedBook!=null)
			result=result+" 삭제 성공!";
		else
			result="[실패] "+result+"는 존재하지 않습니다!";
		
		System.out.println(result);
	}
	
	// 책이름을 오름차순으로 정렬
	public void ascBook() {
		
		//정렬에 성공
		if(bc.ascBook()==1) {
			System.out.println("정렬성공!");
			printBooks(bc.selectList());
		}
		
		//정렬에 실패
		else {
			System.out.println("정렬 실패!");
		}
	}
}
