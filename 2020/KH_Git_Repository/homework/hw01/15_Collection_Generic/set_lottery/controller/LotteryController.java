package com.kh.practice.set.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.TreeSet;

import com.kh.practice.set.model.compare.SortedLottery;
import com.kh.practice.set.model.vo.Lottery;

public class LotteryController {
	// HashSet rawHash= new HashSet();
	// Warning Message(The line colored yellow. = 노란색 밑줄)
	// HashSet is a raw type. 
	// References to generic type HashSet<E> should be parameterized
	
	private HashSet<Lottery> lottery =new HashSet<Lottery>();
	/* 1. (java collection) Set
		- 중복된 데이터 저장을 허용하지 않는다.
		- 데이터 저장순서를 유지하지 않는다.
	   
	   2. HashSet
	    HashSet<E> sampleHashSet= new HashSet<E>
	    <E> :제너릭
	    => Set에 저장할 수 있는 객체 타입을 제한한다.
	    => 서로다른 타입의 여러객체들도 저장할 수 있지만(raw type),
	       	객체타입별로 모두 구분해야되는 번거로움이 있으므로
	       	제너릭을 이용하여 타입을 제한시킨다.
	*/ 
	
	
	private HashSet<Lottery> win = new HashSet<Lottery>();
	
	//HashSet에 값을 저장하는 메소드
	public boolean insertObject(Lottery l) {
		// 전달받은 l을 lottery에 추가한 후에
		// 추가결과인 boolean을 반환.
		
		//HashSet lottery에 매개변수 l이 가리키는 객체를 
		//넣을 수 있는지 확인
		
		// set에있는 원소와 동등객체일 때, 중복대상임을 알릴려면
		// Lottery.java 의 equals()와 hashCode() 메소드를 오버라이드하여
		// 중복여부를 확인한다.
		
		// String클래스는 정렬기준이 이미 정해져있다.
		// 그러나 사용자가 직접만든 객체인 Lottery의 경우에는 정렬기준이 없기때문에
		// 사용자가 직접 정렬기준을 만들어야한다.
		
		
		// String에 대한 document를 확인해보면, 아래와 같이 선언되어있고
		// public final class String
	    //      implements java.io.Serializable, Comparable<String>, CharSequence
		// String의 경우에는 Comparable<String> 인터페이스를 이용하는걸로 정의되어있다.
	
		
		// <String> : 제너릭에 의해서 String으로 제한해놨다.
		// Comparable은 정렬기준이 하나일 때 사용하는 인터페이스이다. 
		//	"정렬기준이 하나일 때" => Comparable<E> 인터페이스 사용
		//	"정렬기준이 여러개일 때" => Comparator <E> 인터페이스 사용
		
		// 인터페이스는 추상메소드와 상수로 구성되어 있고
		//	 => 추상메소드는 미완성된 메소드이다. 
		// 즉 헤더만 있고, 함수블록({})안에 코드가 존재하지 않는다.
		// 다중상속이 가능하다.
		// 그래서 실제 구현객체에서 추상메소드를 재정의 해줘야한다.
		
		
		//Iterator이용해서 HashSet에 있는 모든 원소에 접근한다.
		Iterator<Lottery> it= lottery.iterator();
		while(it.hasNext()) {
			//lottery의 다음 원소가 존재한다면
			Lottery nowLottery= it.next();
			
			//HashSet에 l의 인스턴스가 이미 존재한다면
			if(nowLottery.equals(l))
				return false;
		}

		//HashSet에 l의 인스턴스가 존재하지 않는다면
		lottery.add(l); //추가한다.
		return true;
		/*
		 * 추가를한다면, 파일에 입력데이터를 저장할수 있으면 얼마나 좋을까?
		 * 파일에 저장되어있는 데이터를 조회해서, 중복여부를 확인한다면 얼마나 좋을까?
		 * */
	}
	
	// 셋에 있는 값을 삭제하는 메소드
	public boolean deleteObject(Lottery l) {
		/*
		 * 전달받은 l은 HashSet lottery에서 삭제된다.
		 * 당첨자 목록(win)중에 삭제된 추첨대상자가 존재할 수 있으니
		 * 삭제결과인 boolean값과 win객체가 null이 아닐때에만
		 * win에도 해당추첨 대상자 삭제
		 * 
		 * => lottery Set에 l이 존재하면 => l을 지운다.
		 * => win Set에서 l이 존재하면 => l을 지운다.
		 * */
		
		// l의 인스턴스가 lottery HashSet에 존재하는가?
		// => 존재한다면 삭제
		if(lottery.contains(l)) {
			lottery.remove(l); //삭제하고
			return true;//리턴true
		}
		
		return false; //삭제를 안한다.
	}
	
	// Lottery가 win에 있는지 확인
	public boolean deletedObjectInWinner(Lottery l) {
		if(searchWinner(l)) {
			//win에 l이 있다면 -> 지운다. ->true반환
			win.remove(l);
			return true;
		}
		// win에 l이 존재하지 않는다면
		return false;
	}

	
	
	// 모든 당첨자를 출력하는 메소드
	public HashSet<Lottery> winObject() {
		/*
		 * 추첨 대상자 중에서 랜덤으로 뽑아서 당첨 목록에 넣는 메소드
		 * 랜덤으로 뽑기 위해 lottery를 ArrayList에 담고
		 * 인덱스를 이용해서 win에 당첨자를 저장한다.
		 * 
		 * 이때, 당첨자 수는 무조건 4명이며, 이를 위해 추첨자 수는 4명이상이어야함
		 * 만일 당첨자 목록에 삭제된 추첨대상자가 있다면
		 * 기존에 당첨된 사람은 제외하고 삭제된 사람의 자리만 새로운 추첨자로 채움.->?
		 * */
		
		//lottery를 ArrayList에 담는다.
		ArrayList<Lottery> lotteryList= new ArrayList<Lottery>();
		
		//LotteryList에 lottery를 담는다.
		lotteryList.addAll(lottery);
		
		//LotteryList의 크기를 구한다. (lottery에 몇개의 원소가 저장되어있는지 확인)
		//size: 4명이상
		int size= lotteryList.size();
		
		//win의 크기를 구한다.
		int winnerSize= win.size();
		
		// size는 무조건 4명 이상
		int randomNum;
		Lottery randomLottery;
		
		// 당첨자수는 4명미만.
		if(size>=4 && winnerSize<4) {
			//당첨자 4명을 뽑는다.
			for(int i=winnerSize; i<4; ) {
				//이미 당첨자 목록 win에 있는 사람이라면
				randomNum=(int)(Math.random()*size);
				
				// The type of the expression must be an array type
				// but it resolved to ArrayList<Lottery>
				// ArrayList.get() => get(int index)
				randomLottery= lotteryList.get(randomNum);
				
				//randomLottery가 win set에 이미 존재한다면(중복)
				if(searchWinner(randomLottery))
					continue;
				
				//randomLottery가 win set에 존재하지 않는다면
				win.add(randomLottery);
				i++;	
			}
		}
		return win;
	}
	
	//정렬된 당첨자 목록을 출력하는 메소드
	public TreeSet<Lottery> sortedWinObject() {
		/*
		 * 이름으로 오름차순 정렬하되
		 * 이름이 같으면 번호로 오름차순
		 * => 이름/ 전화번호 두개의 String 타입의 필드를 이용하여 오름차순정렬? => Comparator<E> 를 이용한다.
		 * 
		 * 이때 미리 만들어진 win을 가지고 정렬하기 때문에
		 * 당첨 대상 확인을 꼭 먼저해야한다.
		 * 
		 * 
		 * Lottery는 따로 정렬기준을 만들지 않았다.
		 * 정렬기준이 두개이상이라면 Comparator을 이용한다.
		 * 정렬기준을 만들어서...
		 * 
		 * */
		
		// 그러나 HashSet은 순서를 유지하지않는다.
		// 데이터의 중복을 배제하고
		// 데이터의 저장순서를 유지하고 싶다면, LinkedHashSet을 이용한다.
		LinkedHashSet<Lottery> winnerLinkedHashSet= new LinkedHashSet<Lottery>();
		winnerLinkedHashSet.addAll(win); //win에 해당하는 원소 모두를 한번에  넣는다.

		
		// TreeSet을 이용하여 LinkedHashSet을 정렬한다.
		// 그러나 Lottery는  String처럼 정렬기준이 이미 정해져 있는게 아니라서
		// 정렬기준을 따로 만들어야한다.
		// 그리고 Lottery는 필드가 2개이상이므로, Comparator을 이용하여 정렬한다.
		// 우리는 그 정렬기준을 SortedLottery.java라는 클래스를 통해서 정렬기준을 정한다.
		TreeSet<Lottery> sortedWinners= new TreeSet<Lottery>(new SortedLottery());
		sortedWinners.addAll(winnerLinkedHashSet);
		return sortedWinners;
		
	}

	public boolean searchWinner(Lottery l) {
		//특정 당첨자를 검색하는 메소드
		// Lottery l이 이미 win목록에 있는지 확인하는 메소드
		
		//win set을 리스트에 저장.
		ArrayList<Lottery> winnerList= new ArrayList<Lottery>();
		winnerList.addAll(win);
		
		//l 이 winnerList에  존재하는가?
		return (winnerList.contains(l))?true:false;
	}
	
}
