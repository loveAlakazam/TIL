package hashMapPractice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

public class HashMapKeyList {
	public static void main(String [] args) {
		ArrayList<String> list1= new ArrayList<>();
		list1.add("최은강");
		list1.add("김기쁨");
		list1.add("김수진");
		list1.add("김미경");
		list1.add("명다정");
		list1.add("이서영");
		list1.add("최하윤");
		list1.add("이영실");
		list1.add("박신우");
		
		
		ArrayList<String>list2= new ArrayList<>();
		list2.add("남우현");
		list2.add("문종렬");
		list2.add("홍민기");
		list2.add("김원");
		list2.add("김대근");
		list2.add("정민찬");
		list2.add("김록원");
		list2.add("이원형");
		list2.add("박찬수");
		list2.add("이예빈");
		list2.add("김윤주");
		
		ArrayList<String>list3=new ArrayList<>();
		list3.add("이규호");
		list3.add("최호영");
		list3.add("김수환");
		list3.add("김용연");
		list3.add("정창섭");
		list3.add("정규동");
		list3.add("박상준");
		list3.add("우민혁");
		list3.add("권기현");
		
		
		//해시맵
		HashMap<String, ArrayList<String>> map= new HashMap<>();
		map.put("kh여자",list1);
		map.put("상명친구", list2);
		map.put("kh남자", list3);
		
		//entry: key+value
		for(Entry<String, ArrayList<String>> personEntry: map.entrySet()) {
			String key= (String)personEntry.getKey();
			ArrayList<String> listValue=(ArrayList)personEntry.getValue();
			
			System.out.println("key => "+ key);
			for(String personName: listValue)
				System.out.println("name: "+personName);
			System.out.println("========================");
		}
	}
}
