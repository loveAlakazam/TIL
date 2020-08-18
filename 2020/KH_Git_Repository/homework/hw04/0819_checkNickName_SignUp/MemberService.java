package member.model.service;

//JDBCTemplate의 공용메소드인 getConnection()을 임포트
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;

import member.model.dao.MemberDAO;
import member.model.vo.Member;

public class MemberService {
	//service패키지: connection을 받아와서 db와 연결하여 트랜젝션 처리.
	
	public Member loginMember(Member member) {
		// 커넥션을 만든다.
		Connection conn= getConnection();
		
		Member loginUser=new MemberDAO().loginMember(conn, member);
		close(conn);
		return loginUser;
	}
	
	public int insertMember(Member member) {
		// update, insert, delete는 숫자값으로 리턴.
		
		Connection conn= getConnection();
		
		int result= new MemberDAO().insertMember(conn, member);
		//쿼리수행결과 성공: 1개이상
		//쿼리수행결과 실패: 0
		
		// Transaction - commit / rollback
		// 쿼리 수행 결과가 1개이상인경우에는 commit -질의 결과 성공
		if(result>0) {
			commit(conn);
		}else {
			//쿼리수행결과가 
			rollback(conn);
		}
		
		//connection을 닫는다.
		close(conn);
		
		return result;
		
	}

	public int checkId(String userId) {
		Connection conn= getConnection();
		int result= new MemberDAO().checkId(conn, userId);
		
		close(conn);
		return result;
	}

	public Member selectMember(String loginUserId) {
		Connection conn= getConnection();
		Member member=new MemberDAO().selectMember(conn, loginUserId); 
		
		close(conn);
		return member;
	}

	public int checkNickName(String nickName) {
		Connection conn= getConnection();
		int result= new MemberDAO().checkNickName(conn, nickName);
		close(conn);
		return result;
	}

}
