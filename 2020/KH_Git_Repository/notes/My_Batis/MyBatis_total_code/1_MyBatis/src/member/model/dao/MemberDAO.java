package member.model.dao;

import org.apache.ibatis.session.SqlSession;

import member.model.exception.MemberException;
import member.model.vo.Member;

public class MemberDAO {

	public Member selectMember(SqlSession session, Member m) throws MemberException{
		/*
		 session.selectOne(arg0, arg1)
		 
		 arg0: 어느쿼리를 가져올 지에 대한 id값(쿼리문ID)을 받아온다.
		 
		 즉, arg0은 query.properties 파일에 있는 많은 sql쿼리문들 중에서 특정쿼리문에 대응되는 ID를 의미한다.
		 
		 - 구체적인 예시
		 [query.properties 파일]
		 selectMember= SELECT * FROM MEMBER WHERE USER_ID=? AND MSTATUS='N'
		 ---쿼리문 ID--  --------------------ID에 대응되는 쿼리문--------------
		 
		 
		 
		 - MemberDAO의 selectMember()메소드를 통해서, 프로퍼티파일로부터 id에 대응되는 쿼리문을 불러온다.
		 prop.getProperty("selectMember");
		 
		 
		 arg1: member-mapper.xml에서 id가 loginMember인 쿼리한테 보내야한다.
		 
		 */
		
		Member member=session.selectOne("memberMapper.loginMember", m);
//		System.out.println(member);
		
		if(member==null) {
			//존재하지 않은 회원/ 아이디와 비밀번호가 일치하지 않다면 => 예외를 발생시킨다.
			
			//에러가 발생하면 session을 닫는다.
			session.close();
			
			//throw: 예외 강제 발생 => try-catch문을 사용해도 의미가 없다.
			//throws를 붙여서 현재 메소드를 호출한 곳에서 위임하도록함.
			throw new MemberException("로그인에 실패하였습니다.");
		}
		return member;
	}

	public void insertMember(SqlSession session, Member m) throws MemberException {
		int result=session.insert("memberMapper.insertMember", m);
		if(result<=0) {
			//세션 롤백후에 세션을 닫는다 
			session.rollback();
			session.close();
			
			//에러발생(예외강제발생)
			throw new MemberException("회원가입에 실패하였습니다.");
		}
	}

}
