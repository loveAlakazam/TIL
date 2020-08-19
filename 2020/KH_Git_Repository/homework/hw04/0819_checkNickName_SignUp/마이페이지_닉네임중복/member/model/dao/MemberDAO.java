package member.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import member.model.vo.Member;

public class MemberDAO {
	private Properties prop =new Properties();
	public MemberDAO() {
		String fileName= MemberDAO.class.getResource("/sql/member/member-query.properties").getPath();
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public Member loginMember(Connection conn, Member member) {
		/**
		 * (조회) ?(위치홀더) => 위치홀더는 PreparedStatement를 이용하여 값을 넣는다.
		 * SELECT * FROM MEMBER WHERE USER_ID=? AND USER_PWD=?;
		 */
	
		//위치홀더를 이용
		PreparedStatement pstmt= null;
		
		//select조회문의 반환: ResultSet
		ResultSet rset=null;
		
		Member loginUser=null;
		
		String query = prop.getProperty("loginMember");
		
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, member.getUserId());
			pstmt.setString(2, member.getUserPwd());
			rset=pstmt.executeQuery(); //아이디(구분자), 비밀번호 일치시 1개(최대)/ 일치안함: 0개
			
			if(rset.next()) {
				loginUser=new Member(
							rset.getString("USER_ID"),
							rset.getString("USER_PWD"),
							rset.getString("USER_NAME"),
							rset.getString("NICKNAME"),
							rset.getString("PHONE"),
							rset.getString("EMAIL"),
							rset.getString("ADDRESS"),
							rset.getString("INTEREST"),
							rset.getDate("ENROLL_DATE"),
							rset.getDate("MODIFY_DATE"),
							rset.getString("STATUS"));
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return loginUser;
		
	}


	public int insertMember(Connection conn, Member member) {
		
		
		//위치홀더를 이용한다.
		PreparedStatement pstmt= null;
		
		//insert() 수행하면 리턴값은 숫자
		int result=0; //초기화
		
		// 프로퍼티이름을 insertMember
		// insertMember=INSERT INTO MEMBER VALUES ( ?, ?, ? , ?, ?, ?, ?, ?)
		String query= prop.getProperty("insertMember");
		
		//쿼리문을 실행한다.
		try {
			pstmt=conn.prepareStatement(query);
			
			//위치홀더에 대응되는 값을 넣는다.
			pstmt.setString( 1, member.getUserId() ); //USER_ID
			pstmt.setString( 2, member.getUserPwd()); //USER_PWD
			pstmt.setString( 3, member.getUserName());//USER_NAME
			pstmt.setString(4, member.getNickName());
			pstmt.setString(5,  member.getPhone());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getInterest());
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			// pstmt를 닫는다
			close(pstmt);
		}
		
		return result;
	}


	public int checkId(Connection conn, String userId) {
		PreparedStatement pstmt= null;
		ResultSet rset=null;
		
		int result=0;
		
		String query = prop.getProperty("idCheck");
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1,  userId);
			
			rset= pstmt.executeQuery(); //쿼리문 수행
			//무조건 1개들어가있다. => count(*) => 행한개(아이디 개수), 컬럼한개
			if(rset.next()) {
				result= rset.getInt(1); //첫번째 컬럼에 있는 값을 갖고오겠다.
				System.out.println(result);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}		
		return result;
	}


	public Member selectMember(Connection conn, String loginUserId) {
		PreparedStatement pstmt= null;
		ResultSet rset= null;
		Member member= null;
		
		String query = prop.getProperty("selectMember");
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, loginUserId);
			rset= pstmt.executeQuery(); //1개 (로그인상태)
			
			if(rset.next()) {
				member= new Member(
						rset.getString("user_id"),
						rset.getString("user_pwd"),
						rset.getString("user_name"),
						rset.getString("nickName"),
						rset.getString("phone"),
						rset.getString("email"),
						rset.getString("address"),
						rset.getString("interest"),
						rset.getDate("enroll_date"),
						rset.getDate("modify_date"),
						rset.getString("status"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		return member;
	}


	public int checkNickName(Connection conn, String nickName) {
		PreparedStatement pstmt= null;
		ResultSet rset= null;
		int result=0;
		
		// 불러올 프로퍼티의 키값이 존재하지 않으면 => java.sql.SQLException이 발생.
		String query=prop.getProperty("checkNickName");
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, nickName);
			rset=pstmt.executeQuery();
			if(rset.next()) {
				//이미 닉네임이 있다.
				result=rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}


	public int updateMember(Connection conn, Member myInfo) {
		int result=0;
		PreparedStatement pstmt=null;
		
		//아이디, 비밀번호를 제외한 나머지 정보를 수정한다.
		String query= prop.getProperty("updateMember");
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, myInfo.getUserName());
			pstmt.setString(2, myInfo.getNickName());
			pstmt.setString(3, myInfo.getPhone());
			pstmt.setString(4, myInfo.getEmail());
			pstmt.setString(5, myInfo.getAddress());
			pstmt.setString(6, myInfo.getInterest());
			pstmt.setString(7, myInfo.getUserId());
			
			result=pstmt.executeUpdate(); //쿼리문 실행결과
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

}
