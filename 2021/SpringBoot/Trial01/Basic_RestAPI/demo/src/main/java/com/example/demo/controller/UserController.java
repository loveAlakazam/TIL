package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.User;

@RestController
public class UserController {
	private Map<String, User> userMap;
	
	@PostConstruct
	public void init() {
		userMap= new HashMap<String, User>();
		userMap.put("1", new User("1", "김철수", "111-111", "서울시 강남구 대치동"));
		userMap.put("2", new User("2", "김철수", "222-222", "서울시 강남구 대치동"));
		userMap.put("3", new User("3", "김철수", "113-113", "서울시 강남구 대치동"));
		
	}
	
	//확인은 postman에서 사용할수있다.
	//@GetMapping - 데이터조회
	//@PostMapping -데이터수정
	//@PutMapping - 데이터생성
	//@DeleteMapping - 데이터삭제
	
	//데이터 조회
	//localhost:[portNo]/user/[입력아이디]
	@GetMapping("/user/{id}")
	public User getUser(@PathVariable String id) {
		return userMap.get(id);
	}
	
	@GetMapping("/user/all")
	public List<User> getAllUsers(){
		return new ArrayList<User>(userMap.values());
	}
	
	//데이터 생성
	@PutMapping("/user/{id}")
	public void putUser(@PathVariable String id,
			@RequestParam("name") String name, 
			@RequestParam("phone") String phone,
			@RequestParam("address") String address) {
		User user= new User(id, name, phone, address);
		userMap.put(id, user);
		
	}
	
	//수정
	@PostMapping("/user/{id}")
	public void postUser(@PathVariable String id,
			@RequestParam("name") String name, 
			@RequestParam("phone") String phone,
			@RequestParam("address") String address) {
		User user= userMap.get(id);
		user.setName(name);
		user.setAddress(address);
		user.setPhone(phone);
	}
	
	//삭제
	@DeleteMapping("/user/{id}")
	public void deleteUser(@PathVariable String id) {
		userMap.remove(id);
	}
	
}
