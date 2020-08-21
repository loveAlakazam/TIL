<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.model.vo.Notice, java.sql.Date"%>
    
<%
	//scriptlet을 넣어서 현재글번호를 알아내자.
	Notice notice = (Notice) request.getAttribute("notice");
	int no =notice.getNoticeNo();
	String title= notice.getNoticeTitle();
	String writer=notice.getNoticeWriter();
	Date date= notice.getNoticeDate();
	String content= notice.getNoticeContent();

	System.out.println(no+"-"+title+"-"+writer+"-"+date+"-"+content);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=notice.getNoticeNo() %>번 게시판공지사항 수정</title>
<style type="text/css">
   .outer{
      width: 600px; height: 500px; background-color: rgba(255, 255, 255, 0.4); border: 5px solid white;
      margin-left: auto; margin-right: auto; margin-top: 50px;
   }
   .tableArea {width:450px; height:350px; margin-left:auto; margin-right:auto;}
   #updateNoBtn{background: #B2CCFF;}
   #cancelBtn{background: #D1B2FF;}
</style>
</head>
<body>
   <%@ include file="../common/menubar.jsp" %>
   <div class="outer">
      <br>
      <h2 align="center">공지사항 수정</h2>
      <div class="tableArea">
      	 <%-- 
      	 	(저장)버튼을 누르면 /update.no에 요청한다.
      	 	/update.no URL을 담당하는 서블릿은 NoticeUpdateServlet이다.
      	 	
      	 	NoticeUpdateServlet은 현재 noticeUpdateForm.jsp 페이지에서
      	 	입력한 내용들을 모두 받는다.
      	  --%>
         <form action="<%=request.getContextPath() %>/update.no" method="post">
            <table>
               <tr>
                  <th>제목</th>
                  <td colspan="3">
                  	<input type="text" size="50" name="title" value="<%=notice.getNoticeTitle() %>">
                  	<input type="hidden" name="no" value=<%=notice.getNoticeNo() %> />
                  </td>            
               </tr>
               
               
               
               <tr>
                  <th>작성자</th>
                  <td>
                  	<input type="text" size="50" name="writer" value="<%=notice.getNoticeWriter()%>" disabled>
                  </td>
               </tr>
               
               <tr>
                  <th>작성일</th>
                  <td>
                  	<input type="date" size="50" name="date"  value="<%=notice.getNoticeDate()%>">
                  </td>
               </tr>
               
               <tr>
                  <th>내용</th>
               </tr>
               
               <tr>
               	<td colspan="4">
                  <textarea name="content" cols="60" rows="15" style="resize:none;"><%=notice.getNoticeContent()%></textarea>
                </td>
               </tr>              
            </table>
            
            <br>
            
            <div align="center">
           <input type="submit" id="updateNoBtn" value="저장">
        	
         	<%-- <input type="button" id="updateNoBtn" value="저장">    
         	<script>
            	$('#updateNoBtn').click(function(){
            		location.href="<%=request.getContextPath() %>/update.no?no="+<%=notice.getNoticeNo() %>;
            	});

            </script> --%>

               <%--
	               	수정데이터를 입력 후
	               	(저장) 버튼을 누르면  /update.no url을 요청하게되고
	               	
	               	/update.no url과 매핑된 서블릿에서 요청에 대한 처리를 한다.
	               	위의 4개의 데이터를 모두 얻는다.
	               	
	               	(질문) 나는 get방식으로 글번호를 전달하는 방식으로 했지만
	               	만일 post방식으로한다면 어떻게 풀까?
               --%>
               <input type="button" onclick="location.href='javascript:history.go(-1);'" id="cancelBtn" value="취소">
            </div>
         </form>
      </div>
   </div>

</body>
</html>