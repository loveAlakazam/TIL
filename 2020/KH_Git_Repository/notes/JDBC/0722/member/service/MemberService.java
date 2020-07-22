package com.kh.member.service;

import static com.kh.common.JDBCTemplate.getConnection;
import static com.kh.common.JDBCTemplate.rollback;
import static com.kh.common.JDBCTemplate.commit;

import java.sql.Connection;

import com.kh.member.model.dao.MemberDAO;
import com.kh.member.model.vo.Member;

public class MemberService {
	// connection

	public int login(Member mem) {
		// 존재한다면 1명이, 존재하지 않는다면 0명
		Connection conn= getConnection();
		MemberDAO mDAO = new MemberDAO();
		
		//JDBCTemplate로부터 얻은 커넥션과
		//로그인을 하려는 멤버객체를 가지고
		//데이터베이스 접근한다. (데이터베이스에 멤버객체가 있는지 확인)
		int result=mDAO.login(conn, mem);
		if(result==0) {
			//로그인 실패
			rollback(conn);
		}else {
			//로그인성공
			commit(conn);
		}
		return result;
	}

}
