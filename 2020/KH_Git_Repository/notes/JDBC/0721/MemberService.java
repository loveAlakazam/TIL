package com.kh.service;

import static com.kh.common.JDBCTemplate.commit;
import static com.kh.common.JDBCTemplate.getConnection;
import static com.kh.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.model.dao.MemberDAO;
import com.kh.model.vo.Member;


public class MemberService {

	public int insertMember(Member mem) {
		// JDBC Connection객체를 연결
		Connection conn= getConnection();
		
		// DAO 영역(데이터베이스에 접근)
		MemberDAO mDAO = new MemberDAO();
		
		// 접근이후, DAO영역에서 insert쿼리문을 실행한다.
		// INSERT 쿼리문 수행후 반환타입은 int타입이다.
		int result=mDAO.insertMember(conn, mem);
		
		// (service) result결과값에 따라 commit과 rollback의 transaction 수행.
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	public ArrayList<Member> selectAll() {
		// Connection객체를 만든다.
		Connection conn= getConnection();
		
		// DAO객체를 만든다.
		MemberDAO mDAO =new MemberDAO();
		
		// select만 하니까 transaction 필요없다.
		// MemberDAO를 통해 DB에 INSERT 쿼리문을 수행한다.
		ArrayList<Member> mList=mDAO.selectAll(conn); 
		return mList;
	}

	public ArrayList<Member> selectMemberId(String id) {
		 
		Connection conn= getConnection();
		MemberDAO mDAO = new MemberDAO();
		
		ArrayList<Member> mList=mDAO.selectMemberId(conn, id);
		
		
		return mList;
	}

	public ArrayList<Member> selectMemberGender(char gender) {
		Connection conn= getConnection();
		MemberDAO mDAO = new MemberDAO();
		ArrayList<Member> mList= mDAO.selectMemberGender(conn, gender);
		
		return mList;
	}

	public int checkMemberId(String memberId) {
		Connection conn = getConnection();
		MemberDAO mDAO= new MemberDAO();
		
		int check=mDAO.checkMember(conn, memberId);
		return check;
	}

	public int updateMember(int sel, String memberId, String input) {
		Connection conn= getConnection();
		MemberDAO mDAO = new MemberDAO();
		
		int result= mDAO.updateMember(conn, sel, memberId, input);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

}
