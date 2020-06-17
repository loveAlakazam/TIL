package com.kh.practice.set.model.vo;

public class Lottery {
	private String name;
	private String phone;
	
	public Lottery() {}
	public Lottery(String name, String phone) {
		this.name=name;
		this.phone=phone;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name=name;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone=phone;
	}
	
	// 메소드 오버라이드 //
	// Object 클래스의 메소드를 상속받는다. - 모든 클래스의 부모는 Object클래스이다.
	//객체의 주소값이 아닌 필드 phone과 name을 이용하여 출력.
	@Override
	public String toString() {
		return name+"("+phone+")";
	}
	
	// HashSet에 중복된 객체가 존재하는지 확인하는 함수.
	// equals()를 오버라이드 하기전엔, 객체의 주소값이 동일한지 여부를 따졌다.
	// 기존의 equals()를 이용했을때, 동등객체는 다르다고 판별한다.
	// 왜냐면, new연산자로 인해서 만들어진 객체는 필드값이 동일하더라도, 다른 주소값을 갖기 때문이다.
	// 동등객체는 객체의주소는 다르지만, 필드의 내용이 같은경우를 의미한다.
	// 동등객체일때 중복이 된다는 것을 나타내기위해 메소드를 오버라이드했다.
	@Override
	public boolean equals(Object obj) {
		// 1. 객체의 주소를 비교
		// this: 현재 객체 자신을 나타낸다. 
		// 객체자신의 주소값을 저장하는 참조변수(인스턴스 변수)이다.
		
		// 현재객체와 비교대상인 obj의 주소값이 서로같다면-> true
		if(this==obj) {
			return true;
		}
		
		//obj가 null이다. -> false
		if(obj==null) {
			return false;
		}
		
		//this의 클래스와,obj의 클래스가 서로 다르다면 -> false
		if(getClass()!= obj.getClass()) {
			return false;
		}
			
		// 2. 객체가 갖는 필드값이 같은지를 비교
		// 매개변수 obj의 타입은 Object이고, 부모클래스이다.
		// 부모클래스는 자식클래스로 형변환이 가능하다. 
		// => 자식클래스만이 갖고있는 필드/메소드/재정의한 메소드를 사용하고 싶다면
		// 자식클래스로 다운캐스팅을 하여 사용한다.
		Lottery others= (Lottery)obj; //다형성을 이용-> DownCasting
		
		//name필드가 서로 다르다면
		if( !name.equals(others.name)) {
			return false;
		}
		
		if( !phone.equals(others.phone)) {
			return false;
		}
		
		return true;
	}
	
	
	// equals()를 재정의하기위해서 필요한 함수.
	// 헤시코드를 리턴하는 메소드
	@Override
	public int hashCode() {
		// 상수의 접근제한자는 public, (default)은 가능하지만, private는 불가능하다.
		// 왜냐 부모클래스 Object클래스의 hashCode()의 접근제한자가
		// 상속받게되면 자식에서는 접근제한자는 수정할 수있는데, 부모의 메소드의 접근제한자보다 더 넓어야한다.
		// 부모메소드의 접근제한자가 default라면, 자식메소드에서 재정의를 할때 접근제한자의 범위는 default, public 이다.
		final int PRIME=31; 
		int result=1;
		result=PRIME*result+(name==null?0:name.hashCode());
		result=PRIME*result+(phone==null?0:phone.hashCode());
		return result;
	}
	
	
}
