package member.model.service;

import static common.Template.getSqlSession;

import java.util.HashMap;

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

	public void updateMember(Member m) throws MemberException {
		SqlSession session= getSqlSession();
		new MemberDAO().updateMember(session, m);
		
		//여기서는 예외가 성공적으로 처리가 됐음을 의미함.
		//commit()후 세션을 닫는다.
		session.commit();
		session.close();
	}

	public void pwdUpdate(HashMap<String, String> map) throws MemberException {
		SqlSession session= getSqlSession();
		new MemberDAO().pwdUpdate(session, map);
		
		session.commit();
		session.close();
	}

	public void deleteMember(String userId) throws MemberException {
		SqlSession session=getSqlSession();
		new MemberDAO().deleteMember(session, userId);
		
		session.commit();
		session.close();
		
	}

}
