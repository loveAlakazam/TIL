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
		// Connection객체를 만든다.
		Connection conn = getConnection();
		
		// 데이터베이스와 연결할 준비를 한다.
		MemberDAO mDAO= new MemberDAO();
		
		// Connection객체와 memberId를 받아서 데이터베이스에서 select 쿼리문을 수행한다.
		// 쿼리문 수행 결과를 int타입으로 받는다 =>(성공) 1 (아이디1개) / (실패) 0
		// 입력받은 아이디가 존재하는지 확인
		int check=mDAO.checkMember(conn, memberId);
		return check;
	}

	public int updateMember(int sel, String memberId, String input) {
		Connection conn= getConnection();
		MemberDAO mDAO = new MemberDAO();
		
		// 멤버 정보 변경에 대한 쿼리문이 성공했는지 확인한다.
		int result= mDAO.updateMember(conn, sel, memberId, input);
		if(result>0) {
			//변경이 성공했다면 commit을 (상태저장)
			commit(conn);
		}else {
			//변경이 실패했다면, 데이터변경이전으로 롤백.
			rollback(conn);
		}
		return result;
	}

	public int deleteMember(String memberId) {
		Connection conn= getConnection(); //Connection을 만든다.
		MemberDAO mDAO = new MemberDAO(); //MemberDAO객체를 만든다.
		
		int result=mDAO.deleteMember(conn, memberId);
		if(result>0) {
			//삭제결과가 성공하면
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

}
