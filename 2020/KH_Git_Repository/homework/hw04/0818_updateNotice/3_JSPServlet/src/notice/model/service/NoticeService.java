package notice.model.service;

import static common.JDBCTemplate.getConnection;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;

import notice.model.dao.NoticeDAO;
import notice.model.vo.Notice;

public class NoticeService {

	public ArrayList<Notice> selectList() {
		Connection conn = getConnection();
		ArrayList<Notice>  list =new NoticeDAO().selectList(conn);
		close(conn);
		return list;
	}

	public int insertNotice(Notice n) {
		Connection conn= getConnection();
		int result=new NoticeDAO().insertNotice(conn, n);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}
	
	public Notice selectNotice(int no) {
		Connection conn= getConnection();
		// 공지 읽기 기능
		// 1) 디테일을 상세보기
		// 2) 게시글을 보면 조회수가 올라감.
		
		// 동시에 일어남=> 하나의 비즈니스 로직 안에서 일어난다.
		// 비즈니스 로직안에서 동시에 일어난다=> 같은 서비스단을 가져야한다.
		// 같은 비즈니스 로직=> 서비스 단에 같이 간다음에 나눠진다.
		
		NoticeDAO nDAO= new NoticeDAO();
		
		// 게시글 조회수 증가
		int result =nDAO.updateCount(conn, no); //조회수 증가
		
		Notice notice=null;
		if(result>0) {
			//조회된 게시글이 존재한다면, no에 해당하는 게시글을 읽는다.
			notice=nDAO.selectNotice(conn, no);
			commit(conn); 
		}else {
			rollback(conn);
		}
		
		return notice;
	}

	public int updateNotice(int no, String title, String content, Date date) {
		Connection conn= getConnection();
		
		//DAO로 connection객체와 같이 보낸다.
		int result=new NoticeDAO().updateNotice(conn, no, title, content, date);
		
		//service는 Connection객체를 바로 이용(드라이버로 데이터베이스와 연결)하여
		//바로 DAO에게 데이터를 전달
		
		//그리고 데이터베이스의 쿼리 결과에따라서
		//트랜젝션 처리까지 담당.
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		return result;
	}
	
}
