package com.kh.spring.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.spring.board.model.exception.BoardException;
import com.kh.spring.board.model.service.BoardService;
import com.kh.spring.board.model.vo.Board;
import com.kh.spring.board.model.vo.PageInfo;
import com.kh.spring.board.model.vo.Reply;
import com.kh.spring.common.Pagination;
import com.kh.spring.member.model.vo.Member;

@Controller
public class BoardController {
	@Autowired
	private BoardService bService;
	
	/*
	 Integer과 int
	 page에서 아무것도 안받을 경우(null)일때 고려.
	 * */
	
	
	//400에러(브라우저에러) => @RequestParam("page") => page 가 존재하지 않음! => page를 존재하게하려면?
	/*
	 page: get방식
	 게시판 들어갈때는 페이징번호는 없어도됨.
	 페이지번호를 누르면 페이지가 생김
	 
	 페이지변수는 url에 있을 수도있고, 없을 수도있다.
	 
	 @RequestParam("page") => 무조건 페이지가 있어야한다!
	 page는 value값 하나만 갖는다.
	 required 속성을 추가한다. 
	 => required: true  >> 반드시 필요함
	 => required: false >> 반드시 필요하지 않음.(꼭있을 필요도없고, 없을수도있다)
	 
	 defaultValue="1"
	 =>페이지가 아무것도 없을때는 기본값을 넣을 수 있다.
	 =>기본값은 1이며, 페이지가 url에 표시되지 않을때, 1페이지로 되어있다.
	 
	 (@RequestParam(value="page", required=false, defaultValue="1") 
	 * */
	@RequestMapping("blist.bo")
	public ModelAndView boardList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) throws BoardException {
		
		int currentPage=1;
		if(page !=null) {
			currentPage=page;
		}
		
		int listCount= bService.getListCount();
		
		PageInfo pi= Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Board> list= bService.selectList(pi);
		if(list!=null) {
			mv.addObject("list", list);
			mv.addObject("pi", pi);
			mv.setViewName("boardListView");
		}else {
			throw new BoardException("게시글 전체 조회에 실패하였습니다!");
		}
		return mv;
	}
	
	@RequestMapping("binsertView.bo")
	public String BoardInsertView() {
		return "boardInsertForm";
	}
	
	@RequestMapping("binsert.bo")
	public String boardInsert(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile uploadFile,
													   HttpServletRequest request) throws BoardException 
	{
		//		System.out.println("b=> "+ b);
		//		System.out.println("uploadFile=> "+ uploadFile);
		
		//uploadFile.getOriginalFilename() 파일을 집어넣었는지 않았는지 확인할 수 있다.
		//파일을 넣지 않았다 => ""
		//파일을 넣었다        => 파일제목
		System.out.println(uploadFile.getOriginalFilename());
		
		//파일을 넣지 않았다면
		if(!uploadFile.getOriginalFilename().equals("")) {
			/*
			 *조건식 !uploadFile.getOriginalFilename().equals("")(의미: 파일을 넣었다. , 업로드파일명이 ""이 아니다.)
			 *조건식 uploadFile != null && !uploadFile.isEmpty()  와 의미가 같다.(파일이 비어있지않고, null이 아니다)
			 * */
			String renameFileName= saveFile(uploadFile, request);//파일경로저장
			if(renameFileName !=null) {
				b.setOriginalFileName(uploadFile.getOriginalFilename());
				b.setRenameFileName(renameFileName);
			}
		}
		int result= bService.insertBoard(b);
		if(result<0) {
			throw new BoardException("게시글 등록에 실패하였습니다!"); 
		}
		
		return "redirect:blist.bo";
	}
	
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		//resource에 접근
		String root=request.getSession().getServletContext().getRealPath("resources");
		
		//C:\Users\USER\Documents\GitHub\TIL\2020\KH_Git_Repository\notes\Spring\total_code\1_Spring\src\main\webapp\resources
		System.out.println("root=> "+root);
		
		String savePath= root+"\\buploadFiles";
		
		File folder= new File(savePath);
		if(!folder.exists()) {
			//폴더가 존재하지 않는다면 => 폴더를 만든다.
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMddHHmmss");
		
		//원본파일 이름
		String originFileName= file.getOriginalFilename();
		String renameFileName= sdf.format(new Date(System.currentTimeMillis()))+"."
								+originFileName.substring(originFileName.lastIndexOf(".") +1 );
		
		String renamePath=folder+"\\"+ renameFileName;
		try {
			file.transferTo(new File(renamePath));
		}  catch(Exception e) {
			System.out.println("파일전송 에러: "+ e.getMessage());
			e.printStackTrace();
		}
		
		return renameFileName;
	}
	
	@RequestMapping("bdetail.bo")
	public ModelAndView boardDetail(@RequestParam("bId") int bId, 
							  @RequestParam("page") int page, ModelAndView mv) throws BoardException {
		Board board= bService.selectBoard(bId);
		
		
		if(board!=null) {
			mv.addObject("board", board)
			.addObject("page", page)
			.setViewName("boardDetailView");
		}else {
			throw new BoardException("게시글 상세보기에 실패하였습니다.");
		}
		return mv;
	}
	
	
	@RequestMapping("bupView.bo")
	public ModelAndView boardUpdateView(@RequestParam("bId") int bId, @RequestParam("page") int page, ModelAndView mv) {
		Board board= bService.selectBoard(bId);
		mv.addObject("board", board)
		.addObject("page", page)
		.setViewName("boardUpdateForm");
		
		return mv;
	}
	
	@RequestMapping("bupdate.bo")
	public ModelAndView boardUpdate(@ModelAttribute Board b, @RequestParam("page") int page,
													   @RequestParam("reloadFile") MultipartFile reloadFile,
													   HttpServletRequest request,
													   ModelAndView mv) throws BoardException{
		
		//수정이전에 파일을 올려놓은 상태라면
		if(reloadFile !=null && !reloadFile.isEmpty()) {
			
			//기존에 올렸던 파일이 null이 아니라면..
			if(b.getRenameFileName() !=null) {
				//기존에 올렸던 파일을 지운다.
				deleteFile(b.getRenameFileName(), request);
			}
			
			// 새로 업데이트할 파일 
			String renameFileName= saveFile(reloadFile, request);
			
			if(renameFileName !=null) {
				//새로 업데이트할 파일이 null이 아니라면
				b.setOriginalFileName(reloadFile.getOriginalFilename());
				b.setRenameFileName(renameFileName);
			}
		}
		
		// 파일업데이트
		int result= bService.bUpdateBoard(b);
		
		//수정 성공
		if(result>0) {
			mv.addObject("page", page)
			.setViewName("redirect:bdetail.bo?bId="+b.getbId());
		}else {
			throw new BoardException("게시판 수정에 실패하였습니다.");
		}
		
		return mv;
	}
	
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root= request.getSession().getServletContext().getRealPath("resources");
		String savePath= root+ "\\buploadFiles";
		File f = new File(savePath + "\\" + fileName);
		
		//파일이 존재한다면
		if(f.exists()) {
			f.delete(); //파일을 지운다.
		}
	}
	
	@RequestMapping("bdelete.bo")
	public String deleteBoard(@RequestParam("bId") int bId, HttpServletRequest request) throws BoardException {
		Board b= bService.selectBoard(bId);
		if(b.getOriginalFileName()!=null) {
			deleteFile(b.getRenameFileName(), request);
		}
		int result = bService.deleteBoard(bId);
		if(result>0) {
			return "redirect:blist.bo";
		}else {
			throw new BoardException("게시물 삭제에 실패하였습니다.");
		}
		
	}
	
	//덧글등록
	@RequestMapping("addReply.bo")
	@ResponseBody
	public String addReply(Reply r, HttpSession session) throws BoardException{
		Member loginUser= (Member) session.getAttribute("loginUser");
		String rWriter= loginUser.getId();
		r.setrWriter(rWriter);

		System.out.println("reply=> "+r );
		int result= bService.insertReply(r);
	
		if(result>0) {
			return "success";
		}else {
			throw new BoardException("댓글등록에 실패하였습니다.");
		}
	}
	
	@RequestMapping("rlist.bo")
	public void getReplyList(int bId, HttpServletResponse response) throws JsonIOException, IOException {
		ArrayList<Reply> list= bService.selectReplyList(bId);
		response.setContentType("application/json; charset=UTF-8");
		
		//형식에 맞는 날짜로 바꾸기.
//		GsonBuilder gb= new GsonBuilder();
//		GsonBuilder df= gb.setDateFormat("yyyy-MM-dd");
//		Gson gson = df.create();
		
		//gson을이용하여 객체를 쉽게 전달하게끔한다.
		new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(list, response.getWriter());
		
	}
	
	@RequestMapping("topList.bo")
	public void boardTopList(HttpServletResponse response) throws JsonIOException, IOException {
		ArrayList<Board> list= bService.selectTopList();
		
		response.setContentType("application/json; charset=UTF-8");
//		Gson gson =new Gson();
		//gson을이용하여 객체를 쉽게 전달하게끔한다.
		new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(list, response.getWriter());

	}
}
