package com.kh.practice.set.model.compare;

import java.util.Comparator;

import com.kh.practice.set.model.vo.Lottery;

public class SortedLottery implements Comparator<Lottery>{

	// Comparator 인터페이스의 메소드compare()은
	// 아직 미완성된 메소드이므로
	// 구현객체(자식클래스)에서 완성을 시켜야한다.
	// HashSet은 데이터의 순서를 유지하지 않으므로, 리스트를 이용하여 정렬해야한다.

	
	// Lottery객체끼리 비교를 해야하고, 정렬 기준이 정해져있지 않았다.

	@Override
	public int compare(Lottery o1, Lottery o2) {
		// 나
		String standardName= o1.getName();
		String otherName=o2.getName();
		
		//이름을 오름차순 정렬하되, 이름이 같으면 번호로 오름차순
		int nameResult=standardName.compareTo(otherName);
		
		//만약에 이름이 같다면
		if(nameResult==0) {
			//번호를 기준으로 오름차순으로 한다.
			String standardPhoneNum=o1.getPhone();
			String otherPhoneNum=o2.getPhone();
			return standardPhoneNum.compareTo(otherPhoneNum);
		}
		
		return nameResult;
	}

	
}
