package board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;

import board.model.service.BoardService;
import board.model.vo.Attachment;
import board.model.vo.Board;
import common.MyFileRenamePolicy;
import member.model.vo.Member;

/**
 * Servlet implementation class ThumbnailInsertServlet
 */
@WebServlet("/insert.th")
public class ThumbnailInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ThumbnailInsertServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

//		String title= request.getParameter("title");
//		System.out.println("선택 사진게시판 제목: "+title);

		// encType이 multipart/form-data 로 전송됐는지 확인
		if (ServletFileUpload.isMultipartContent(request)) {
			int maxSize = 1024 * 1024 * 10; // 10MB
			String root = request.getSession().getServletContext().getRealPath("/");
			System.out.println("root: "+ root); // D:\2020_projects\javaServlet\3_JSPServlet\WebContent\
			
			String savePath = root + "thumbnail_uploadFiles/"; // 파일 넣는 곳

			System.out.println(savePath);// 이미지 파일저장경로
			MultipartRequest multiRequest= new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			File file= new File(savePath);
			if(!file.exists()) {
				file.mkdirs();
			}
			
			//바뀐파일의 이름을 저장한 ArrayList
			ArrayList<String> saveFiles= new ArrayList<String>();
			
			// 원본파일의 이름을 저장할 ArrayList
			ArrayList<String> originFiles= new ArrayList<String>();
			
			
			Enumeration<String> files= multiRequest.getFileNames(); // getFileNames(): 폼에서 전송된 File의 name을 반환
			while(files.hasMoreElements()) {
				String name= files.nextElement();
				
				if(multiRequest.getFilesystemName(name)!=null) {
					// getFilesystemName(): RenamePolicy의 rename()에서 작성한 대로 rename된 파일명
					// 작성한대로 이름이 바뀐 파일이름들
					saveFiles.add(multiRequest.getFilesystemName(name));
					originFiles.add(multiRequest.getOriginalFileName(name)); //실제업로드한 파일이름
				}
			}
			
			String title= multiRequest.getParameter("title");
			String content= multiRequest.getParameter("content");
			String bWriter= ((Member)request.getSession().getAttribute("loginUser")).getUserId();
			Board board= new Board();
			board.setBoardTitle(title);
			board.setBoardContent(content);
			board.setBoardWriter(bWriter);
			
			System.out.println(board);
			System.out.println(originFiles);
			System.out.println(saveFiles);
			
			ArrayList<Attachment> fileList= new ArrayList<Attachment>();
			for(int i=originFiles.size()-1; i>=0; i--) {
				Attachment at= new Attachment();
				at.setFilePath(savePath);
				at.setOriginName(originFiles.get(i));
				at.setChangeName(saveFiles.get(i));
				
				if(i== originFiles.size()-1) {
					at.setFileLevel(0);
				}else {
					at.setFileLevel(1);
				}
				
				fileList.add(at);
			}
			
			int result= new BoardService().insertThumbnail(board, fileList);
			if(result>0) {
				response.sendRedirect("list.th");
			}else {
				for(int i=0; i<saveFiles.size(); i++) {
					File failedFile= new File(savePath + saveFiles.get(i));
					failedFile.delete();
				}
				request.setAttribute("msg", "사진 게시판 등록에 실패하였습니다.");
				request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
			}
			
			/*
			 파일명  변환 및 저장 작업
			 사용자가 올린 파일명을 그대로 저장하지 않는 것이 원칙이다.
			 1) 같은 파일명이 있는 경우 기존 파일을 덮어쓰거나 시스템이 지정한 이름대로 바꿔서 저장될 수 있기 때문이다.
			 2) 특수기호나 띄어쓰기가 들어있는 파일이 서버에 들어가면 문제가 생기는 이름으로 저장될 수 있기 때문이다.
			 
			
			# 파일 이름 변환
			DefaultFileRenamePolicy (cos.jar 안에 존재하는 클래스)
			같은 파일명이 있는지 확인 후, 있을경우에는 파일명 뒤에 숫자를 붙여준다.
				ex) aaa.png, aaa1.png, aaa2.png 뒤에 숫자를 붙여서 이름을 변경.
			
			# 사용방법
			- request객체: 어떤 요청받는 클래스가 무엇인지
			- savePath: 어디다가 이미지 파일들을 저장을 할것인지
			- maxSize: 들어오는 파일의 최대크기
			- encoding: 어떤식으로 인코딩
			- 5번째 :rename을 한다면 어떠한 정책으로 따라서 이름을 변경할 것인지 => cos.jar에 있는 DefaultFileRenamePolicy() 를 따름.
					사용자가 직접 이름변경정책(rename-policy)를 만들 수있다. 
			MultipartRequest multiRequest= new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			* */
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
