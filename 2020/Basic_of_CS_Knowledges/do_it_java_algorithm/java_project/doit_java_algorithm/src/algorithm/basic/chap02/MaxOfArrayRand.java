package algorithm.basic.chap02;

import java.util.Random;
import java.util.Scanner;

public class MaxOfArrayRand {
	public static int findMaxHeights(int [] heights) {
		//내림차순정렬
		
		return heights[0];
	}
	
	public static void main(String[] args) {
		Random rand= new Random(); //난수를 불러온다.
		Scanner stdIn = new Scanner(System.in);
		
		System.out.println("키의 최댓값을 구합니다.");
		
		System.out.print("사람 수: ");
		int num=stdIn.nextInt();
		
		
		int [ ] heights= new int[num];
		
		System.out.println("\n키는 아래와 같습니다.");
		for(int h : heights) {
			heights[h]=100+rand.nextInt(100);
		}
		
		for(int h: heights) {
			System.out.println("heights["+h+"] : "+heights[h]);
		}
		
		int maxHeight= FindMaxHeight(heights);
		System.out.println("가장 큰 키는 : "+ maxHeight+"cm 입니다.");
	}
}
