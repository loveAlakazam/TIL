package list.samples;

public class Food implements Comparable<Food>{
	//필드
	private String name; //음식이름
	private String type; //음식종류
	private double calories; //칼로리

	//생성자
	public Food() {} //기본생성자
	
	// 생성자 오버로딩
	// 오버로딩: 동일한 이름의 생성자가 여러개가 있음.
	
	// 단, 매개변수의 개수/ 순서/ 타입에 따라 
	// 같은이름의 메소드(생성자 포함) 여러개를 만들 수 있다.
	public Food(String name) {
		this.name=name; 
	}
	
	public Food(String name, double calories) {
		this(name);
		this.calories=calories;
	}
	
	public Food(String name, String type, double calories) {
		this(name,calories);
		this.type=type;
	}
	
	
	// getter-setter method
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name=name;
	}
	
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type=type;
	}
	
	
	
	public double getCalories() {
		return calories;
	}
	
	public void setCalories(double calories) {
		this.calories= calories;
	}
	
	//Obejct객체의 메소드인 toString을 오버라이드
	//Object클래스는 모든 클래스의 부모클래스이다.
	@Override
	public String toString() {
		return name;
	}
	
	
	// equals()와 hashCode()를 오버라이드
	// 왜 사용하지? => "리스트 안에있는 객체를 이름을 기준으로 삭제" 할때 
	// Object클래스 => 같다고 생각한 기준 => 객체의 주소를 기준으로
	// 내가 재정의 => name을 기준으로 
	@Override
	public int hashCode() {
		final int PRIME=31;
		int result=1;
		
		result= PRIME * result+(name==null? 0: name.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		//현재 객체의 주소와 obj의 주소가 서로같은가?
		if(this==obj) 
			return true;
		
		//obj가 null인가?
		if(obj==null)
			return false;
		
		//this가 null인가?
		if(this==null)
			return false;
		
		//서로다른클래스인가?
		if(getClass()!=obj.getClass())
			return false;
		
		//서로 같은 클래스라면,obj를  Food 클래스타입으로 다운캐스팅
		Food otherFood=(Food)obj;
		
		//name이 null인가?
		if(name ==null)
			return false;
		
		//otherFood.name이 null인가?
		if(otherFood.name==null)
			return false;
		
		//필드 이름 문자열 자체 비교
		if(!name.equals(otherFood.name))
			return false;
		
		return true;
	}

	
	// 정렬기준이 한개일 경우 정렬함수를 재정의
	@Override
	public int compareTo(Food other) {
		// name필드에 대해서 비교.
		return this.name.compareTo(other.name);
	}

}
