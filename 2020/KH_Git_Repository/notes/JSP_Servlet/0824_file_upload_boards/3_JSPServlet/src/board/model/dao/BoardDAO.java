package board.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import board.model.vo.Attachment;
import board.model.vo.Board;
import board.model.vo.PageInfo;
import board.model.vo.Reply;

public class BoardDAO {

	private Properties prop = new Properties();

	// 생성자
	public BoardDAO() {
		String fileName = BoardDAO.class.getResource("/sql/board/board-query.properties").getPath();

		// 프로퍼티 파일을 불러온다.
		try {
			prop.load(new FileReader(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int getListCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;

		String query = prop.getProperty("getListCount");

		try {
			/*
			 * 실행쿼리문: SELECT COUNT(*) FROM BOARD WHERE BOARD_TYPE=? AND STATUS='Y'
			 * 
			 * 게시글의 전체 개수를 가져온다
			 */
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, 1); // 1번 위치홀더에는 1(1=board_type=일반게시판)을 넣는다.
			rset = pstmt.executeQuery(); // select문 실행결과 ResultSet객체를 리턴받는다.

			if (rset.next()) {// ResultSet객체가 존재한다면
				result = rset.getInt(1); // 게시물의 개수를 가져온다.
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}

		return result;
	}

	public ArrayList<Board> selectList(Connection conn, PageInfo pi) {
		ArrayList<Board> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectList");

		int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1; // 시작페이지
		int endRow = startRow + pi.getBoardLimit() - 1;// 끝페이지

		try {

			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setInt(3, 1); // 일반게시판(Board_type=1)

			// 쿼리문 실행결과
			rset = pstmt.executeQuery();
			list = new ArrayList<Board>();
			while (rset.next()) {
				// db의 result set 결과를 보고 친다.
				Board b = new Board(rset.getInt("board_id"), rset.getInt("board_type"), rset.getString("cate_name"),
						rset.getString("board_title"), rset.getString("board_content"), rset.getString("board_writer"),
						rset.getString("nickName"), rset.getInt("board_count"), rset.getDate("create_date"),
						rset.getDate("modify_date"), rset.getString("status"));

				list.add(b);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return list;
	}

	public Board selectBoard(Connection conn, int bId) {
		Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectBoard");
		// bId에 해당하는 게시글이 있는지 찾는다.
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bId);
			rset = pstmt.executeQuery();
			if (rset.next()) {
				board = new Board(rset.getInt("BOARD_ID"), rset.getInt("BOARD_TYPE"), rset.getString("CATE_NAME"),
						rset.getString("BOARD_TITLE"), rset.getString("BOARD_CONTENT"), rset.getString("BOARD_WRITER"),
						rset.getString("NICKNAME"), rset.getInt("BOARD_COUNT"), rset.getDate("CREATE_DATE"),
						rset.getDate("MODIFY_DATE"), rset.getString("STATUS"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return board;
	}

	public int updateCount(Connection conn, int bId) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = prop.getProperty("updateCount");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bId);
			result = pstmt.executeUpdate(); // 수정
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Reply> selectReplyList(Connection conn, int bId) {
		ArrayList<Reply> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectReplyList");
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, bId);
			rset = pstmt.executeQuery();
			list = new ArrayList<Reply>();
			while (rset.next()) {
				list.add(new Reply(rset.getInt("reply_id"), rset.getString("reply_content"), rset.getInt("ref_bid"),
						rset.getString("nickname"), rset.getDate("create_date"), rset.getDate("modify_date"),
						rset.getString("status")));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return list;
	}

	public int insertReply(Connection conn, Reply r) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = prop.getProperty("insertReply");

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, r.getReplyContent());
			pstmt.setInt(2, r.getRefBid());
			pstmt.setString(3, r.getReplyWriter());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList selectBList(Connection conn) {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<Board> list = null;

		String query = prop.getProperty("selectBList");
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			list = new ArrayList<Board>();

			while (rset.next()) {
				list.add(new Board(rset.getInt("board_id"), rset.getInt("board_type"), rset.getString("cate_name"),
						rset.getString("board_title"), rset.getString("board_content"), rset.getString("board_writer"),
						rset.getString("nickname"), rset.getInt("board_count"), rset.getDate("create_date"),
						rset.getDate("modify_date"), rset.getString("status")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(stmt);
			close(rset);
		}

		return list;
	}

	public ArrayList selectFList(Connection conn) {
		Statement stmt=null;
		ResultSet rset=null;
		ArrayList<Attachment> list=null;
	
		//섬네일만 가져온다 => 파일레벨로 섬네일인지 추가사진인지 구분
		//섬네일의 FILE_LEVEL=0
		String query= prop.getProperty("selectFList");
		try {
			stmt=conn.createStatement();
			rset=stmt.executeQuery(query);
			
			list=new ArrayList<Attachment>();
			while(rset.next()) {
				list.add(new Attachment(
						rset.getInt("board_id"),
						rset.getString("change_name")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(stmt);
			close(rset);
		}
		return list;
	}

	public int insertThread(Connection conn, Board board) {
		PreparedStatement pstmt =null;
		int result=0;
		
		String query=prop.getProperty("insertThBoard");
		
		try {
			pstmt= conn.prepareStatement(query);
			pstmt.setString(1, board.getBoardTitle());
			pstmt.setString(2, board.getBoardContent());
			pstmt.setString(3, board.getBoardWriter());
			result= pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int insertAttachment(Connection conn, ArrayList<Attachment> fileList) {
		int result=0;
		PreparedStatement pstmt= null;
		
		String query= prop.getProperty("insertAttachment");
		
		try {
			for(int i=0; i<fileList.size(); i++) {
				Attachment a = fileList.get(i);
				pstmt= conn.prepareStatement(query);
				pstmt.setString(1, a.getOriginName());
				pstmt.setString(2, a.getChangeName());
				pstmt.setString(3, a.getFilePath());
				pstmt.setInt(4,  a.getFileLevel());
				result+= pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Attachment> selectThumbnail(Connection conn, int bId) {
		PreparedStatement pstmt= null;
		ResultSet rset= null;
		ArrayList<Attachment> list=null;
		
		String query= prop.getProperty("selectThumbnail");
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1,bId);
			
			rset=pstmt.executeQuery();
			list=new ArrayList<Attachment>();
			while(rset.next()) {
				Attachment a = new Attachment();
				
				a.setFileId(rset.getInt("file_id"));
				a.setOriginName(rset.getString("origin_name"));
				a.setChangeName(rset.getString("change_name"));
				a.setFilePath(rset.getString("file_path"));
				a.setUpdateDate(rset.getDate("upload_date"));
				
				list.add(a);			
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return list;
	}

}
