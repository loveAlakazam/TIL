package algorithm.basic.chap01;

public class Max302 {
	public static int max3(int a, int b, int c) {
		int max=a;
		if(b>max) max=b;
		if(c>max) max=c;
		return max;
	}
	
	public static int max4(int [] arr) {
		int max=arr[0]; //0번째 인덱스의 숫자가 가장 큰수라고 하자.
		for(int i=1; i<arr.length; i++) {
			if(arr[i]>max) 
				max=arr[i];
		}
		return max;
	}
	
	public static int min3(int a, int b, int c) {
		int min3=a;
		
		return min3;
	}
	
	public static int min4(int a, int b, int c, int d) {
		int min4=a;
		return min4;
	}
	
	public static void main(String[] args) {
		int resultMin3= min3(33,2225, 11);
		System.out.println("resultMin3 => "+resultMin3);
		
		int resultMin4= min4(113, 163, 113, 38);
		System.out.println("resultMin4 => "+resultMin4);
		
		int resultMax4=max4(new int[] {33, 22, 55, 11});
		System.out.println("resultMax4 => "+ resultMax4);
	}
}
