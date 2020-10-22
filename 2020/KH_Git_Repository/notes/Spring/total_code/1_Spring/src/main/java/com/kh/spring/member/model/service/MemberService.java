package com.kh.spring.member.model.service;

import com.kh.spring.member.model.vo.Member;

public interface MemberService {

	Member memberLogin(Member m);

	int insertMember(Member m);

	int updateMember(Member m);

	int updatePwd(Member m);
	/*
	 * 선생님답
	 int updatePwd(HashMap<String, String> map);
	 * */

	int deleteMember(Member m);

	int checkIdDup(String id);

}
