package com.kh.practice.set.view;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Scanner;
import java.util.TreeSet;

import com.kh.practice.set.controller.LotteryController;
import com.kh.practice.set.model.vo.Lottery;

public class LotteryMenu {
	private Scanner sc= new Scanner(System.in);
	private LotteryController lc =new LotteryController();
	
	public void mainMenu() {
		int menu;
		do {
			System.out.println("============= KH 추첨 프로그램 =============\n");
			System.out.println("[메인 메뉴]");
			System.out.println("1. 추첨 대상 추가");
			System.out.println("2. 추첨 대상 삭제");
			System.out.println("3. 당첨 대상 확인");
			System.out.println("4. 정렬된 당첨대상 확인");
			System.out.println("5. 당첨 대상 검색");
			System.out.println("9. 종료");
			System.out.print("메뉴번호 선택 >> ");
			menu= Integer.parseInt(sc.nextLine());
			switch(menu) {
				case 1: insertObject(); break;
				case 2: deleteObject(); break;
				case 3: winObject(); break;
				case 4: sortedWinObject(); break;
				case 5: searchWinner(); break;
				case 9:
					System.out.println("프로그램을 종료합니다.");
					return;
					
				default:
					System.out.println("잘못 입력하였습니다.");
			}
			System.out.println();
		}while(true);
	}
	
	
	//추첨대상 추가를 위해 정보를 받는 메소드
	public void insertObject() {
		/*
		 * 추가할 추첨 대상수를 입력받아 입력한 수만큼 
		 * 추첨자 이름과 추첨자 핸드폰 번호를 받고
		 * 매개변수 생성자를 이용해 Lottery객체에 추첨자 정보저장.
		 * 
		 * Lottery 객체를 lc(LotteryController)의
		 * insertObject()로 전달 하는데
		 * 
		 * 단, 중복된 추첨대상 입력했거나 또는
		 * 이미 추천 Set에 대상이 있는 경우에는
		 * 
		 * "중복된 대상입니다. 다시 입력해주세요." 출력 후
		 * 
		 * 다시 객체 입력.
		 * 
		 * 모든입력이 완료되면, "추가 완료되었습니다"를 출력.
		 * 
		 * */
		//1. 추가할 추첨 대상 수를 구한다.
		System.out.print("추가할 추첨 대상수: ");
		int nums=Integer.parseInt(sc.nextLine());
		
		//2. 추첨자 이름과 추첨자 핸드폰 번호를 받는다.
		String name;
		String phone;
		for(int i=0; i<nums;) {
			System.out.print("이름: ");
			name=sc.nextLine();
			
			System.out.print("핸드폰 번호(- 제외): ");
			phone=sc.nextLine();
			
			//3. l이 가리키는 대상이 중복된 대상인지 확인
			// HashSet lottery에 있는 원소와 중복된경우 - false
			if(!lc.insertObject(new Lottery(name,phone))) {
				System.out.println("중복된 대상입니다. 다시 입력해주세요!");
				continue;
				//continue 이후의 코드를 실행하지 않음.
			}
			
			// 중복되지 않은 경우 - true
			System.out.println("추가 완료되었습니다!\n");
			i++;
		}
		System.out.println(nums+"명이 추가되었습니다!");
	}
	
	// 특정 추점 대상 삭제 결과를 알리는 메소드
	public void deleteObject() {
		/*
		 * */
		System.out.println("삭제할 대상의 이름과 현드폰 번호를 입력하세요.");
		System.out.print("이름: ");
		String name=sc.nextLine();
		
		System.out.print("핸드폰 번호('-'제외): ");
		String phone=sc.nextLine();
		
		// 추첨대상(lottery) 삭제가 되었다면
		if(lc.deleteObject(new Lottery(name,phone))){
			System.out.println("추첨대상에서 삭제 완료 되었습니다!");
		}else {
			//삭제가 안되었다면
			System.out.println("[삭제 실패] 추첨대상에 존재하지 않습니다!");
		}
		
		// 당첨된 대상(win) 삭제 되었다면
		if(lc.deletedObjectInWinner(new Lottery(name,phone))) {
			System.out.println("당첨대상에서 삭제 완료되었습니다!");
		}else {
			System.out.println("[삭제 실패] 당첨대상에 존재하지 않습니다!");
		}
	}
	
	//println메소드를 이용하여 당첨 대상자를 출력하는 메소드
	public void winObject() {
		//lc에서 받아온 Set객체를 println()메소드를 통해 출력한다.
		HashSet <Lottery> winList= lc.winObject();
		System.out.println(winList);
	}
	
	
	public void sortedWinObject() {
		// lc에서 받아온 Set객체를 Iterator를 통해 출력.
		// 정렬기준을 오름차순형식으로 한다.
		TreeSet<Lottery> sortedWinners=lc.sortedWinObject();

		//Iterator을 이용하여 출력
		Iterator<Lottery> it= sortedWinners.iterator();
		while(it.hasNext()) {
			//다음 원소가 존재한다면-> 다음원소 출력
			System.out.println(it.next());
		}
	}
	
	//당첨자 중 특정 대상이 있는지 결과를 출력하는 메소드
	public void searchWinner() {
		/*
		 * 검색할 대상의 이름과 핸드폰 번호를 받고
		 * 매개변수 있는 Lottery 생성자를 이용해
		 * 객체에 정보를 담아 lc에 객체를 보낸다.
		 * 
		 * 받은 결과에 따라 true면 "축하합니다. 당첨 목록에 존재합니다"
		 * false면 "안타깝지만 당첨 목록에 존재하지 않습니다"
		 * */
		System.out.print("이름: ");
		String searchName=sc.nextLine();
		
		System.out.print("핸드폰 번호('-'빼고): ");
		String searchPhone= sc.nextLine();
		
		if(lc.searchWinner(new Lottery(searchName, searchPhone) )) {
			//true;
			System.out.println(searchName+"님 축하합니다. 당첨목록에 존재합니다.");
		}else {
			System.out.println("안타깝지만 당첨목록에 존재하지 않습니다.");
		}
	}
	
}
