package algorithm.basic.chap01;

import java.util.Scanner;

public class Max3 {

	public static void main(String[] args) {
		Scanner stdIn= new Scanner(System.in);
		
		System.out.println("세정수의 최댓값을 구한다.");
		System.out.print("a값: ");
		int a= stdIn.nextInt();
		
		System.out.print("b값: ");
		int b= stdIn.nextInt();
		
		System.out.print("c값: ");
		int c= stdIn.nextInt();
		
		int max=a; //a를 최댓값으로 가정하자
		if(b>max) {
			//b가 max보다 크면
			max=b;
		}
		if(c>max) {
			//c가 max보다 크면
			max=c;
		}
		
		System.out.println("최댓값 : "+ max);
	}

}
