package list.samples;

import java.util.Comparator;

// 음식을 정렬하기 위한 Comparator
// Comparator은 정렬기준이 1개이다.
public class FoodComparator implements Comparator<Food>{

	@Override
	public int compare(Food food1, Food food2) {
		
		// 이름을 기준으로 - 정렬
		String name1= food1.getName();
		String name2= food2.getName();
		int result=name1.compareTo(name2);
		if(result==0) {
			//name1, name2가 서로 같으면
			
		}
		
		return result;
		
	}

}
