package com.exam.boostcourse.practice.mvcexam.DTO;

public class User {
	//name속성값과 객체의 필드와 일치하는지.
	//getter(), setter() 메소드가필요. 왜냐면, 필드들은 모두 private접근제한자를 갖기때문.
	private String name;
	private String email;
	private int age;
	
	/*
	public User() {}
	public User(String name, String email, int age) {
		this.name=name;
		this.email=email;
		this.age=age;
	}
	*/
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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


	@Override
	public String toString() {
		return "User [name=" + name + ", email=" + email + ", age=" + age + "]";
	}
	
}
