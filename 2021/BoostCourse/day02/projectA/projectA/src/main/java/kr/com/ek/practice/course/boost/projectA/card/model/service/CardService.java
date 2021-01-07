
package kr.com.ek.practice.course.boost.projectA.card.model.service;


import static kr.com.ek.practice.course.boost.projectA.common.JDBCTemplate.getConnection;
import static kr.com.ek.practice.course.boost.projectA.common.JDBCTemplate.commit;
import static kr.com.ek.practice.course.boost.projectA.common.JDBCTemplate.rollback;


import java.sql.Connection;
import java.util.ArrayList;

import kr.com.ek.practice.course.boost.projectA.card.model.dao.CardDAO;
import kr.com.ek.practice.course.boost.projectA.card.model.vo.Card;

public class CardService {

	public ArrayList<Card> selectAll() {
		Connection conn=getConnection();
		CardDAO cDAO= new CardDAO();
		ArrayList<Card> cList= cDAO.selectAll(conn);
		return cList;
	}

	public int isDuplicatedName(String name) {
		Connection conn=getConnection();
		CardDAO cDAO=new CardDAO();
		int result=cDAO.isDuplicatedName(conn, name);
		return result;
	}

	public int insertOneCard(Card card) {
		Connection conn=getConnection();
		CardDAO cDAO= new CardDAO();
		int result=cDAO.insertOneCard(conn, card);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	public ArrayList<Card> searchCardNo(int cardNo) {
		Connection conn=getConnection();
		CardDAO cDAO= new CardDAO();
		ArrayList <Card> cList= cDAO.selectCardNo(conn,cardNo);
		return cList;
	}

	public ArrayList<Card> searchName(String name) {
		Connection conn= getConnection();
		CardDAO cDAO=new CardDAO();
		ArrayList<Card> cList=cDAO.selectName(conn, name);
		return cList;
	}

	//이름 변경
	public int updateName(Card card) {
		Connection conn= getConnection();
		CardDAO cDAO= new CardDAO();
		int result= cDAO.updateName(conn, card);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	public int updateTel(Card card) {
		Connection conn=getConnection();
		CardDAO cDAO=new CardDAO();
		int result= cDAO.updateTel(conn, card);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	public int updateCompanyName(Card card) {
		CardDAO cDAO= new CardDAO();
		Connection conn= getConnection();
		int result=cDAO.updateCompanyName(conn, card);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

	public int deleteCard(int cardNo) {
		CardDAO cDAO= new CardDAO();
		Connection conn= getConnection();
		int result=cDAO.deleteOneCard(conn, cardNo);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}

}
