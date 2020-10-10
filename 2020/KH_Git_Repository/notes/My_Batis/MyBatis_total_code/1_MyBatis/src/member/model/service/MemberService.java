package member.model.service;

import static common.Template.getSqlSession;

import org.apache.ibatis.session.SqlSession;

import member.model.dao.MemberDAO;
import member.model.exception.MemberException;
import member.model.vo.Member;

public class MemberService {

	public Member selectMember(Member m) throws MemberException{
		SqlSession session = getSqlSession();
		System.out.println(session);
		
		Member member=new MemberDAO().selectMember(session, m);
		
		return member;
	}

	public void insertMember(Member m) throws MemberException{
		SqlSession session= getSqlSession();
		new MemberDAO().insertMember(session, m);
		
		//DAO에서 강제발생된 예외에 걸리지 않고 잘 수행됐으므로
		session.commit();
		session.close();
		
	}

}
