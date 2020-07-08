package com.kh.project.mini.cafe.model.vo;

import java.io.Serializable;
import java.util.ArrayList;

public class Member implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2703421044361782678L;
	private String id;
	private String pwd;
	private String name;
	private String birthday;
	private String address;
	
	private int orderCnt = 0; //총 주문횟수 (0으로 초기화)
//	private String latestOrderMenu; //가장최근에 주문한 메뉴
	private String orderHistory; //최근에 주문한 날짜
	private ArrayList<String> orderList= new ArrayList<String>();
	
	//	private LinkedList<> orderLog //(심화)주문기록로그- (주문날짜와 주문메뉴가 기록)
	
	//주문리스트
	
	public Member() {}
	public Member(String pwd, String name, String birthday, String address) {
		this.pwd = pwd;
		this.name = name;
		this.birthday = birthday;
		this.address = address;
				
	}
	
	public Member(String pwd, String name, String birthday, String address,
			String id) {
		this(pwd, name, birthday, address);
		this.id=id;
				
	}

	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	
//	public String getLatestOrderMenu() {
//		return latestOrderMenu;
//	}
//	
//	public void setLatestOrderMenu(String latestOrderMenu) {
//		this.latestOrderMenu = latestOrderMenu;
//	}
	
	public int getOrderCnt() {
		return orderCnt;
	}
	
	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}
	
	public String getOrderHistory() {
		return orderHistory;
	}
	public void setOrderHistory(String orderHistory) {
		this.orderHistory = orderHistory;
	}
	
	//주문 내역 조회
	public ArrayList<String> getOrderList() {
		return orderList;
	}
	public void setOrderList(ArrayList<String> orderList) {
		this.orderList = orderList;
	}
	
	
	@Override
	public String toString() {
		return id+" "+pwd +" "+ name + birthday + address +
				" ("+orderHistory +" / 총 "+orderCnt+"개 주문)";
	}

}