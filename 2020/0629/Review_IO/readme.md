# IO 복습
## 직렬화와 역직렬화 개념

- 직렬화(Serialization)
  - ```객체```를 ```데이터```로 변환
  - Serializable 인터페이스를 implements하여 구현한다.
  - 객체를 직렬화할때 private 필드를 포함한 모든 필드를 바이트로 변환한다.
  - ```transient``` 키워드를 사용하는 필드는 직렬화에서 제외된다.

- 역직렬화(DeSerialization)
  - ```데이터```를 ```객체```로 변환
  - 직렬화했을 때마다 같은 클래스를 사용해야한다.
  - <strong>단, 클래스 이름이 같더라도, 클래스 내용이 변경되면 역직렬화가 실패된다.</strong>


- serialVersionUID 필드
  - 직렬화한 클래스와 같은 클래스임을 알려주는 식별자 역할
  - 컴파일시 JVM이 자동으로 serialVersionUID 정적 필드를 추가해
  - 별도로 작성하지 않아도 오류는 나지 않지만
    - 자동생성시 역직렬화에서 예상하지 못한 InvalidClassException을 유발할 수있어서
    - serialVersionUID를 명시하는걸 권장한다.

<br>

<hr>


# 객체 직렬화 - 파일 저장 메소드

>  ### ObjectDAO.java

```java
import java.io.*;
public class ObjectDAO {
	
	//파일 저장.
	public void fileSave(String fileName) {
		//객체와 IO연결
		
		//객체 배열
		Member [] mArr= {
			new Member("user01", "pass01", "박신우", "park01@iei.or.co.kr", 20, '여', 99.9),
			new Member("user02", "pass02", "우민혁", "wmh@naver.com", 28, '남', 86.2),
			new Member("user03", "pass03", "최호영", "choi3@gmail.com", 24, '남', 44.2)
		};
		
		// try- resource with
		try(//1. 기반스트림을 만든다.
			FileOutputStream fos= new FileOutputStream(fileName);
			
			//2. 객체 연결 스트림을 만든다 (보조스트림)
			//		매개변수로는 기반스트림을 넣는다.
			ObjectOutputStream oos=new ObjectOutputStream(fos);){
			
			//java.io.NotSerializableException 발생
			// serializable => Member객체를 직렬화해야한다.
			
			for(int i=0; i<mArr.length; i++) {
				//mArr[i] 번째의 멤버객체를 가지고와서 쓴다.
				oos.writeObject(mArr[i]);
			}
			
			
			
		} catch (FileNotFoundException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	
	
	// 파일을 읽어온다.
	//파일에 저장된 데이터를 읽어와서 객체 배열에 저장
	public void fileOpen(String fileName) {
		Member [] mArr= new Member[3];
		
		//파일에 저장된 데이터를 읽어와서 객체 배열에 저장
		// 읽기 => InputStream , Reader
		// 파일 저장=> FileOutputStream(바이트), FileWriter(문자)
		// 파일 읽기=> FileInputStream(바이트), FileReader(문자)
		
		// 객체 => ObjectInputStream(읽어온다)
		//			FileInputStream
		
		try(ObjectInputStream ois = new ObjectInputStream(new FileInputStream(fileName));) {
			for(int i=0; i<mArr.length; i++) {
				// 파일에서 읽어온 애를 객체로 변환한다.(역직렬화)
				// Unhandled exception type ClassNotFoundException
				mArr[i]= (Member) ois.readObject();
			}
			
			//파일에서 불러온 객체를 출력한다.
			for(Member member : mArr) {
				System.out.println(member.toString());
			}
		
		}catch(FileNotFoundException |  ClassNotFoundException e) {//상속구조가 아닐때 이용가능			
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		} 
	}
}

```

<br>

<hr>

> ### Member.java

```java
package com.kh.example.chap03_assist.part02_object.model.vo;

import java.io.Serializable;

// 멤버객체 직렬화
public class Member  implements Serializable{
	
	// The serializable class Member does not declare 
	// a static final serialVersionUID field of type long
  // generate Serial Verison ID를 추가해야한다.
		
	/**
	 * 
	 */
	private static final long serialVersionUID = -317919167845418272L;
	
	
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private int age;
	private char gender;
	private double point;
	
	public Member() {
		
	}
	
	public Member(String userId, String userPwd, String userName) {
		this.userId=userId;
		this.userPwd=userPwd;
		this.userName= userName;
	}
	
	public Member(String userId, String userPwd, String userName,
			String email, int age, char gender, double point){
		this(userId, userPwd, userName);
		this.email=email;
		this.age=age;
		this.gender=gender;
		this.point=point;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public double getPoint() {
		return point;
	}

	public void setPoint(double point) {
		this.point = point;
	}
	
	@Override
	public String toString() {
		return "Member [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", email=" + email
				+ ", age=" + age + ", gender=" + gender + ", point=" + point + "]";
	}	
}

```
