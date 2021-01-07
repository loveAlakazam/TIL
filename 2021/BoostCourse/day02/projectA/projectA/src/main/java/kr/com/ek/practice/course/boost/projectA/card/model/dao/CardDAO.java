package kr.com.ek.practice.course.boost.projectA.card.model.dao;

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

import kr.com.ek.practice.course.boost.projectA.card.model.vo.Card;
import static kr.com.ek.practice.course.boost.projectA.common.JDBCTemplate.close;

public class CardDAO {
	
	private Properties prop=null;
	public CardDAO() {
		prop=new Properties();
		try {
			prop.load(new FileReader("query.properties"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Card> selectAll(Connection conn) {
		Statement stmt=null;
		ResultSet rset=null;
		
		ArrayList<Card> cList=null;
		String query=prop.getProperty("selectAll");
		
		try {
			//statement객체생성
			stmt=conn.createStatement();
			
			//select쿼리문 수행.
			rset=stmt.executeQuery(query);
			
			cList=new ArrayList<Card>();
			while(rset.next()) {
				Card card= new Card(rset.getInt("CARD_NO"),
						rset.getString("NAME"),
						rset.getString("TEL"),
						rset.getString("COMPANY_NAME")
				);
				
				cList.add(card);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//닫는다.
			close(rset);
			close(stmt);
		}
		
		return cList;
	}

	public int insertOneCard(Connection conn, Card card) {
		int result=0;
		String query=prop.getProperty("insertOneCard");
		PreparedStatement pstmt= null;
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, card.getName());
			pstmt.setString(2, card.getTel());
			pstmt.setString(3, card.getCompayName());
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int isDuplicatedName(Connection conn, String name) {
		int result=0;
		String query=prop.getProperty("isDuplicatedName");
		PreparedStatement pstmt=null;
		ResultSet rset=null;
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, name);
			rset=pstmt.executeQuery();
			if(rset.next()) {
				result=rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		return result;
	}

	public ArrayList<Card> selectCardNo(Connection conn, int cardNo) {
		PreparedStatement pstmt=null;
		ResultSet rset= null;
		String query= prop.getProperty("selectCardNo");
		ArrayList<Card> cList= new ArrayList<Card>();
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, cardNo);
			rset=pstmt.executeQuery();
			while(rset.next()) {
				Card card= new Card(rset.getInt("CARD_NO"),
						rset.getString("NAME"),
						rset.getString("TEL"),
						rset.getString("COMPANY_NAME"));
				
				cList.add(card);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return cList;
	}

	public ArrayList<Card> selectName(Connection conn, String name) {
		ArrayList<Card> cList= new ArrayList<Card>();
		PreparedStatement pstmt=null;
		ResultSet rset=null;
		String query= prop.getProperty("selectName");
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, "%"+name+"%");
			rset=pstmt.executeQuery();
			while(rset.next()) {
				Card card=new Card(rset.getInt("CARD_NO"),
							rset.getString("NAME"),
							rset.getString("TEL"),
							rset.getString("COMPANY_NAME")
				);
				cList.add(card);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return cList;
	}

	public int updateName(Connection conn, Card card) {
		int result=0;
		PreparedStatement pstmt=null;
		String query =prop.getProperty("updateName");
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, card.getName());
			pstmt.setInt(2, card.getCardNo());
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int updateTel(Connection conn, Card card) {
		int result=0;
		PreparedStatement pstmt=null;
		String query= prop.getProperty("updateTel");
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, card.getTel());
			pstmt.setInt(2, card.getCardNo());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateCompanyName(Connection conn, Card card) {
		int result=0;
		PreparedStatement pstmt=null;
		String query= prop.getProperty("updateCompanyName");
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, card.getCompayName());
			pstmt.setInt(2, card.getCardNo());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteOneCard(Connection conn, int cardNo) {
		int result=0;
		PreparedStatement pstmt=null;
		String query =prop.getProperty("deleteOneCard");
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, cardNo);
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
}
