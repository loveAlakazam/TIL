package com.kh.model.dao;

// static 메소드를 임포트
import static com.kh.common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.model.vo.Member;

public class MemberDAO {

	//기본생성자에서 query.properties를 불러오도록한다.
	private Properties prop=null;
	public MemberDAO() {
		prop =new Properties();
		try {
			prop.load(new FileReader("query.properties"));
			
		} catch (FileNotFoundException e) {	
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int insertMember(Connection conn, Member mem) {
		PreparedStatement pstmt=null;
		int result=0;
		
		//파일에서 불러온다.
		//query: "INSERT INTO MEMBER VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)"
		String query=prop.getProperty("insertMember");
		
		try {
			
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, mem.getMemberId());
			pstmt.setString(2, mem.getMemberPwd());
			pstmt.setString(3, mem.getMemberName());
			
			//char형을 String으로 
			//pstmt.setChar()함수는 존재하지 않는다.
			pstmt.setString(4,  mem.getGender()+"");
			pstmt.setString(5,  mem.getEmail());
			pstmt.setString(6, mem.getPhone());
			
			pstmt.setString(7, mem.getAddress());
			pstmt.setInt(8, mem.getAge());
			
			
			result= pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//preparedStatement를 닫는다.
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Member> selectAll(Connection conn) {
		Statement stmt=null; // 완전한 쿼리문에서 수행.
		ResultSet rset= null;
		ArrayList<Member> mList=null;
		
		//파일을 불러와서 selectAll에 해당하는 쿼리문 수행
		String query= prop.getProperty("selectAll");
		try {
			stmt=conn.createStatement();
			
			//select문 수행결과 => ResultSet
			rset=stmt.executeQuery(query);
			mList= new ArrayList<Member>();
			Member mem= null;
			while(rset.next()) {
				mem=new Member(rset.getString("member_id"),
								rset.getString("member_pwd"),
								rset.getString("member_name"),
								rset.getString("gender").charAt(0),
								rset.getString("email"),
								rset.getString("phone"),
								rset.getInt("age"),
								rset.getString("address"),
								rset.getDate("enroll_date"));
				mList.add(mem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
		
		return mList;
	}

	public ArrayList<Member> selectMemberId(Connection conn, String id) {
		//Statement 를 이용함 //
//		Statement stmt=null;
//		ResultSet rset=null;
//		
//		ArrayList<Member> mList=null;
//		
//		String query= prop.getProperty("selectMemberId");
//		// selectMemberId="SELECT * FROM MEMBER WHERE MEMBER_ID LIKE"
//		
//		query+=" '%"+id+"%'";
//		try {
//			stmt=conn.createStatement();
//			rset= stmt.executeQuery(query);
//			
//			mList =new ArrayList<Member>();
//			while(rset.next()) {
//				Member mem= new Member(rset.getString("member_id"),
//						rset.getString("member_pwd"),
//						rset.getString("member_name"),
//						rset.getString("gender").charAt(0),
//						rset.getString("email"),
//						rset.getString("phone"),
//						rset.getInt("age"),
//						rset.getString("address"),
//						rset.getDate("enroll_date"));
//				
//				mList.add(mem);
//			}
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			close(rset);
//			close(stmt);
//		}
//		
//		return mList;
		
		// preparedStatement 를 이용함.//
		PreparedStatement pstmt=null;
		ResultSet rset=null;
		ArrayList<Member> mList=null;
		
		String query= prop.getProperty("selectMemberIdPrepared");
		// SELECT * FROM MEMBER WHERE MEMBER_ID LIKE ?
		
		try {
			pstmt=conn.prepareStatement(query);
			
			//위치 홀더에 대응되는 값
			pstmt.setString(1, "%"+id +"%");
			rset= pstmt.executeQuery();
			mList =new ArrayList<Member>();
			
			while(rset.next()) {
				Member mem= new Member(rset.getString("member_id"),
				rset.getString("member_pwd"),
				rset.getString("member_name"),
				rset.getString("gender").charAt(0),
				rset.getString("email"),
				rset.getString("phone"),
				rset.getInt("age"),
				rset.getString("address"),
				rset.getDate("enroll_date"));
				mList.add(mem);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return mList;	
	}

	
	
	public ArrayList<Member> selectMemberGender(Connection conn, char gender) {
		//PreparedStatement//
//		ArrayList<Member> mList= null;
//		PreparedStatement pstmt= null;
//		ResultSet rset= null;
//		
//		String query= prop.getProperty("selectMemberByGender");
//		
//		try {
//			
//			// 쿼리문 실행
//			// prepareStatement를 만든다.
//			pstmt=conn.prepareStatement(query);
//			pstmt.setString(1, gender+""); // 위치홀더에 대응되는 값을 넣는다.
//			
//			//쿼리문 실행결과
//			rset= pstmt.executeQuery();
//			
//			//리스트 정의
//			mList= new ArrayList<Member>();
//			
//			//resultSet에 결과가 존재한다면
//			while(rset.next()) {
//				Member mem= new Member( rset.getString("member_id"),
//										rset.getString("member_pwd"),
//										rset.getString("member_name"),
//										rset.getString("gender").charAt(0),
//										rset.getString("email"),
//										rset.getString("phone"),
//										rset.getInt("age"),
//										rset.getString("address"),
//										rset.getDate("enroll_date"));
//				mList.add(mem);
//			}
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}finally {
//			close(rset);
//			close(pstmt);
//		}
//		
//		return mList;
		
		
		// Statement //
		ArrayList<Member> mList = null;
		Statement stmt=null;
		ResultSet rset=null;
		String query= prop.getProperty("selectMemberByGenderStatement") +"'"+gender+"'";
		System.out.println(query);
		
		//connection객체를 만든다.
		try {
			stmt=conn.createStatement();
			rset= stmt.executeQuery(query);
			mList= new ArrayList<Member>();
			while(rset.next()) {
				Member mem= new Member( rset.getString("member_id"),
				rset.getString("member_pwd"),
				rset.getString("member_name"),
				rset.getString("gender").charAt(0),
				rset.getString("email"),
				rset.getString("phone"),
				rset.getInt("age"),
				rset.getString("address"),
				rset.getDate("enroll_date"));
				mList.add(mem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(stmt);
			close(rset);
		}
		return mList;
	}

	public int checkMember(Connection conn, String memberId) {
		PreparedStatement pstmt= null;
		ResultSet rset= null;
		int check=0;
		
		//카운트 결과값=> int
		//select 조회문이라고 반환형이 무조건 int라고 보면안됨.
		String query= prop.getProperty("checkMember");
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			
			rset=pstmt.executeQuery();
			if(rset.next()) {
				check=rset.getInt(1); //첫번째컬럼.
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return check;
	}

	public int updateMember(Connection conn, int sel, String memberId, String input) {
		// sel 수정할 컬럼 => 비밀번호/ 이메일/ 전화번호/ 주소 만 변경
		// 완성시키기 오늘숙제!
		PreparedStatement pstmt=null;
		int result=0;
		String query= prop.getProperty("updateMember" + sel);
		return ;
	}
}
