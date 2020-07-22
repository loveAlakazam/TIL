package com.kh.member.model.dao;

import static com.kh.common.JDBCTemplate.close;


import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.member.model.vo.Member;

public class MemberDAO {

	private Properties prop=null;
	
	public MemberDAO(){
		// MemberDAO 객체 생성할때 바로 query.properties 파일을 읽는다.
		
		prop=new Properties();
		try {
			//query.properties 를 연다.
			prop.load(new FileReader("query.properties"));
			
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	public int login(Connection conn, Member mem) {
		PreparedStatement pstmt= null;
		ResultSet rset= null;
		
		int result=0;
		
		// int타입으로 반환=> member의 아이디와 비밀번호가 일치한 사람의 수 (0/1이상)
		String query= prop.getProperty("login");
		try {
			pstmt=conn.prepareStatement(query); //객체생성
			pstmt.setString(1, mem.getMemberId());
			pstmt.setString(2, mem.getMemberPwd());
			
			rset=pstmt.executeQuery(); //select문 수행
			if(rset.next()) {
				result=rset.getInt(1); //1번째꺼를 가져와라
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			// ResultSet객체, PreparedStatement객체를 닫는다.
			close(rset);
			close(pstmt);
		}
		
		return result;
	}

}
