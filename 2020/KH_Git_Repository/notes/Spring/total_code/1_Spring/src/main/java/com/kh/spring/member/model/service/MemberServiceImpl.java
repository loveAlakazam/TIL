package com.kh.spring.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dao.MemberDAO;
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
	
	@Autowired
	private MemberDAO mDAO;
	
	@Override
	public Member memberLogin(Member m) {
		return mDAO.memberLogin(sqlSession, m);
	}
	
	@Override
	public int insertMember(Member m) {
		return mDAO.insertMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(sqlSession, m);
	}
	
	//비밀번호 수정
	@Override
	public int updatePwd(Member m) {
		return mDAO.updatePwd(sqlSession, m);
	}
	
	//회원탈퇴
	@Override
	public int deleteMember(Member m) {
		return mDAO.deleteMember(sqlSession, m);
	}
}
