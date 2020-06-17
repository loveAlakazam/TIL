package com.kh.practice.list.library.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

import com.kh.practice.list.library.model.vo.Book;

public class BookController {
	private ArrayList<Book> bookList =new ArrayList<Book>();
	
	public BookController() {
		//생성자 => 초기값 4개 추가
		bookList.add(new Book("자바의 정석","남궁성","기타", 20000));
		bookList.add(new Book("쉽게 배우는 알고리즘", "문병로", "기타", 15000));
		bookList.add(new Book("대화의 기술", "강보람", "인문",17500));
		bookList.add(new Book("암 정복기", "박신우", "의료",21000));
	}
	
	public void insertBook(Book bk) {
		//새로 생성된 책에서, 책제목과 저자가 동일한 책이
		//이미 lc.bookList에 존재하는지 확인해야한다.
		if(isDuplicatedBook(bk)==-1) { 
			//도서가 중복되지 않은 도서라면, bookList에 없는도서
			bookList.add(bk); //리스트에 bk를 추가.
			System.out.println("도서 추가 성공!");
		}else {
			System.out.println("도서 추가 실패! 이미 존재하는 도서입니다!");
		}
	}
	
	public ArrayList<Book> selectList(){
		//해당 bookList의 주소값을 반환한다.
		return bookList;
		
	}
	
	public ArrayList<Book> searchBook(String keyword){
		ArrayList<Book> searchResult= new ArrayList<Book>();
		//bookList안에 keyword가 포함되어있는지 확인.
		Iterator<Book> it = bookList.iterator();
		while(it.hasNext()) {
			//다음 원소가 존재한다면
			Book currentBook= it.next();
			String currentTitle= currentBook.getTitle();
			if(currentTitle.contains(keyword)) {
				searchResult.add(currentBook);
			}
		}
		return searchResult;
	}
	
	public Book deleteBook(String title, String author) {
		//bookList 리스트의 원소중 
		//매개변수에 전달받은 필드들로 구성된 동등객체가 있는지 확인
		//Book클래스에서, equals()와 hashCode()를 오버라이드.
		Book targetBook= new Book(title, author);
		int index;
		
		if((index=isDuplicatedBook(targetBook))!=-1){
			//중복되지 않은 도서라면, 삭제를 한다.
			return bookList.remove(index); //index에 해당하는 책을 삭제.
		}
		//index==-1
		//중복된 도서라면
		return null;
	}
	
	//오름차순 정렬한다.
	public int ascBook() {
		// Book클래스는 사용자 정의 객체이기 때문에
		// 정렬기준을 알 수 없다. 그러므로 사용자가 직접 정렬기준을 선정해야한다.
		//도서명 하나만 정렬기준을 정했으므로
		// Comparable<Book>을 이용한다.
		// 인터페이스는 추상메소드형식으로 주어져있기때문에
		// 자식클래스(구현클래스)에서는 메소드의 동작부분을 정의해야한다.
		// 그러므로 Comparable 인터페이스의 compareTo()를 정의해야한다.
		
		//ArrayList 정렬
		//1. 정렬기준이 정해져있는 타입일때 => Collections.sort()
		//2. 정렬기준이 정해져있지 않을때   => bookList.sort(정렬기준객체)
		//	Comparator/Comparable의
		//			메소드 compare()/ compareTo() 오버라이드
		Collections.sort(bookList); ///오름차순정렬.
		return 1;
	}
	
	public int isDuplicatedBook(Book book) {
		Iterator<Book> it =bookList.iterator();
		while(it.hasNext()) {
			Book currentBook = it.next();
			
			//도서명과 저자명이 모두 일치한 도서가 존재한다.
			if(currentBook.equals(book))
				return bookList.indexOf(currentBook);
		}
		//도서명 또는 저자명이 일치하지 않은 도서.
		//즉 bookList에 book이 존재하지 않음.
		return -1;
	}
}