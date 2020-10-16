package com.kh.spring.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.vo.Member;

@Service("mService")
public class MemberServiceImpl implements MemberService {
	//이미 만들어진 객체를 집어넣어야한다.(의존성 주입)
	/*
	 객체를 받아왔고, 객체를 생성은 하지 않았다.
	 Autowired는 받아놓은 객체를 생성해야한다.
	 **/
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member memberLogin(Member m) {
		// TODO Auto-generated method stub
		return null;
	}
	


}
