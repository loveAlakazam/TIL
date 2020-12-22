package programmers.lesson62048;

public class Solution {
	public long gcd(int w, int h) {
		long big=(w>h)? w:h;
		long small=(w<=h)?w:h;
		
		//최대 공약수
		long tmp=1;
		while(tmp!=0) {
			tmp=big%small;
			big=small;
			small=tmp;
		}
		return big;
	}
	public long solution(int w, int h) {
		
		return (w*h)-(w+h-gcd(w,h));
	}
	
	
}
