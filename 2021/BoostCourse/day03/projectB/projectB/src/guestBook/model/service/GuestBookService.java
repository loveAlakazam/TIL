package guestBook.model.service;

import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import guestBook.model.dao.GuestBookDAO;
import guestBook.model.vo.GuestBook;
import static common.JDBCTemplate.*;
public class GuestBookService {

	public int insertGuestBook(GuestBook gb) {
		Connection conn= getConnection();
		int result=new GuestBookDAO().insertGuestBook(conn, gb);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		return result;
	}

	public ArrayList<GuestBook> selectRecentGlist() {
		Connection conn=getConnection();
		ArrayList<GuestBook>glist= new GuestBookDAO().selectRecentGlist(conn);
		if(glist!=null) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return glist;
	}

	public ArrayList<GuestBook> selectAllGuestBooks() {
		Connection conn=getConnection();
		GuestBookDAO gDAO= new GuestBookDAO();
		ArrayList<GuestBook>glist=gDAO.selectAllGuestBooks(conn);
		if(glist!=null) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		return glist;
	}

}
