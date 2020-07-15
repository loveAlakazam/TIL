package list;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

import list.samples.Food;
import list.samples.Music;

public class LinkedList1 {

	public void doList1() {
		// <E> =Generic
		// 콜렉션을 구성하는 원소의 타입을 지정.
		// 제너릭이 String 인 경우
		
		//1. 리스트 정의 및 생성
		ArrayList<String> list1= new ArrayList<String>();
		
		//2. 리스트 데이터 추가
		list1.add("커피");
		list1.add("김치 볶음밥");
		list1.add("떡라면");
		
		//3. 리스트 조회
		System.out.println(list1);// [커피, 김치 볶음밥, 떡라면]
		
		
		//4. 리스트에 담겨있는 데이터 개수 조회
		int len1= list1.size(); 
		System.out.println("list1의 길이: "+len1); //list1의 길이: 3
		
	}
	
	public void doList2() {
		//제너릭이 기본타입/기본참조타입이 아닌, 사용자 정의 클래스인경우
		ArrayList<Food> list2= new ArrayList<Food>();
		
		list2.add(new Food("라면"));
		list2.add(new Food("키위","과일", 40));
		list2.add(new Food("아메리카노", 200)); //37번 라인 코드
		
		System.out.println("list2: "+list2);
		// toString() 오버라이드
		//list2: [라면, 키위, 아메리카노]
		
		//특정 인덱스에 새로운 음식객체를 넣는다.
		//1번인덱스에 "에그스크램블"을 넣는다.
		list2.add(1, new Food("에그스크램블"));
		
		System.out.println("list2: "+ list2);
		// list2: [라면, 에그스크램블, 키위, 아메리카노]
		
		
		//리스트에 있는 데이터 삭제하기 //
		//1) 인덱스 0번 데이터 삭제
		list2.remove(0);
		System.out.println("list2: "+ list2);
		//list2: [에그스크램블, 키위, 아메리카노]
		
//equals(), hashCode() 오버라이드 이전.		
//		//2) new Food("아메리카노", 200) 객체를 삭제해보자.
//		list2.remove(new Food("아메리카노", 200)); //61번 라인코드
//		
//		//삭제가 됐는가? => no
//		System.out.println("삭제후 list2: "+list2);
//		// 삭제후 list2: [에그스크램블, 키위, 아메리카노]
//		// 여전히 남아있다.
		
		// 37번 라인에서 생성된 객체와 61번 라인에서 생성된 객체는
		// 내용이 같지만, 객체의 실제 주소가 다르다.
		// 클래스 Food에서 equals()와 hashCode()함수를 오버라이드
		
//equals(), hashCode() 오버라이드 이후
		//2) new Food("아메리카노", 200) 객체를 삭제해보자
		list2.remove(new Food("아메리카노", 200));
		System.out.println("삭제 후 list2 => "+list2);
		// 삭제 후 list2 => [에그스크램블, 키위]
		
		
		//1) 음식의 이름을 기준으로 정렬을 시켜보자.(정렬기준 한개 = Comparable) //
		// 음식 이름 name 은 String이므로 -> 정렬기준이 이미 정해져있는 상태이다.
		// 정렬기준이 name 하나이므로  Comparable을 이용 한다.
		
		//데이터 추가
		list2.add(new Food("샌드위치", 300));
		list2.add(2,new Food("돈까스",700));
		list2.add(3,new Food("부대찌개"));
		list2.add(new Food("비빔냉면"));
		System.out.println("before sorting list2=> "+list2);
		//[에그스크램블, 키위, 돈까스, 부대찌개, 샌드위치, 비빔냉면]
		
		//1-1) Food에 Comparable을 implements하여 compareTo()함수를 재정의
		//1-2) Collections.sort(리스트);
		Collections.sort(list2);
		
		System.out.println("after sorting list2 by Comparable\n=> "+list2);
		//  [돈까스, 부대찌개, 비빔냉면, 샌드위치, 에그스크램블, 키위]
		
		
		//2) 정렬기준이 여러개인 경우 
		list2.add(new Food("된장찌개"));
		list2.add(new Food("김치찌개",980));
		
		// FoodComparator 을 가져와서 정렬
//		System.out.println("after sorting list2 by Comparator\n=> "+list2);
		
	}
	
	
	public void seeElements(ArrayList<Music> list) {
		Iterator<Music> it=list.iterator(); //iterator정의
		
		
		while(it.hasNext()) { //다음 원소가 존재하는가?
			Music nowMusic= (Music) it.next(); //다음원소를 가져온다.
			String nowTitle=nowMusic.getTitle();
			System.out.println(nowTitle);
		}
	}
	
	public void doList3() {
		//음악객체 리스트를 만들자.
		ArrayList <Music> musicList = new ArrayList<Music>();
		
		// 리스트에 원소 추가하기 //
		// 5개를 추가하자.
		musicList.add(new Music("OHIO", "Crush", "OHIO"));
		musicList.add(new Music("여름안에서", "싹쓰리", "여름안에서"));
		musicList.add(new Music("아직 너의 시간에 살아","이수현", "사이코지만 괜찮아 OST"));
		
		musicList.add(new Music("Bangarang", "Skrillex", "Skrillex"));
		musicList.add(new Music("Pollarity Waves", "Sublab", "Sublab"));
		
		// 1번 인덱스에 추가한다.
		musicList.add(1, new Music("Ego Death","Ty Dollar $ign", "Ego Death"));

		//확인
		System.out.println("musicList.size(): "+ musicList.size()); //musicList.size(): 6
		System.out.println("musicList => "+ musicList);
		//musicList => [OHIO (Crush OHIO), Ego Death (Ty Dollar $ign Ego Death), 여름안에서 (싹쓰리 여름안에서), 아직 너의 시간에 살아 (이수현 사이코지만 괜찮아 OST),
		//              Bangarang (Skrillex Skrillex), Pollarity Waves (Sublab Sublab)]
		
		
		// 리스트 안의 원소를 삭제하기 //
		musicList.remove(new Music("OHIO", "Crush", "OHIO"));
		System.out.println("musicList.size(): "+ musicList.size()); //musicList.size(): 5
		
		
		// 리스트안에 있는 원소를 조회하기 //
		// 리스트안에 있는 음악객체의 Title 필드만을 출력.
		System.out.println("Using Iterator in ArrayList");
		seeElements(musicList);
		/*
		 * 	Using Iterator in ArrayList
			Ego Death
			여름안에서
			아직 너의 시간에 살아
			Bangarang
			Pollarity Waves
		 * */
		
		// 리스트 안에 있는 원소의 인덱스를 확인한다.
		int targetMusicIdx=musicList.indexOf(new Music("Ego Death","Ty Dollar $ign", "Ego Death"));
		System.out.println("타겟 음악의 인덱스 번호=> "+ targetMusicIdx); // 타겟 음악의 인덱스 번호=> 0
		
		// 리스트에 존재하지 않은 원소의 인덱스를 확인
		targetMusicIdx=musicList.indexOf(new Music("Space Invaders","MDK", "SPACE INVADERS!"));
		System.out.println("타겟 음악의 인덱스번호 => "+ targetMusicIdx); //타겟 음악의 인덱스번호 => -1
		

		
		
		// 데이터 수정
		//1) 인덱스번호에 해당하는 음악을 바로 수정
		//   musicList.set(index, element)
		System.out.println("before setting => "+ musicList);
		// before setting => [Ego Death (Ty Dollar $ign Ego Death), 여름안에서 (싹쓰리 여름안에서), 아직 너의 시간에 살아 (이수현 사이코지만 괜찮아 OST),
		// 						Bangarang (Skrillex Skrillex), Pollarity Waves (Sublab Sublab)]
		
		// 리스트의 0번째에 위치한 음악을 수정.
		musicList.set(0, new Music("EGO DEATH","Kanye West, Skrillex, FKA TWIG", "EGO DEATH"));
		System.out.println("after setting =>  "+ musicList);
		// after setting =>  [EGO DEATH (Kanye West, Skrillex, FKA TWIG EGO DEATH), 여름안에서 (싹쓰리 여름안에서), 아직 너의 시간에 살아 (이수현 사이코지만 괜찮아 OST),
		//						Bangarang (Skrillex Skrillex), Pollarity Waves (Sublab Sublab)]
		
		System.out.println(musicList.size());
		
		//2) 인덱스에 해당하는 음악을 얻는다.
		// get(index) =>   0<=index && index<musicList.size()
		Music obtainedMusic= musicList.get(4);
		System.out.println("obtainedMusic => "+obtainedMusic);
		
		
		// 연결리스트 안의 모든 데이터를 정렬한다.
		// 그러나 Music클래스의 정렬기준 Comparator을 정의하지 않았다.
		
		// 0번 인덱스에 해당하는 음악 내용 수정 & 1번인덱스에 가수명만 다른 음악 추가
		musicList.set(0,new Music("EGO DEATH","Kanye West", "EGO DEATH"));
		musicList.add(1,new Music("EGO DEATH", "Skrillex", "EGO DEATH"));
		
		// 정렬하기
		// Music 정렬기준 => 여러개 => Comparator 이용

		
	}
	
}
