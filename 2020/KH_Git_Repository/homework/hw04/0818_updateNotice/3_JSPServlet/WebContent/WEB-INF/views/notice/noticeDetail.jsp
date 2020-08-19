<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="notice.model.vo.Notice" %>
    
    
<%
	Notice notice= (Notice)request.getAttribute("notice"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style type="text/css">
   .outer{
      width: 600px; height: 500px; background-color: rgba(255, 255, 255, 0.4); border: 5px solid white;
      margin-left: auto; margin-right: auto; margin-top: 50px;
   }
   .tableArea {width:450px; height:350px; margin-left:auto; margin-right:auto;}
   #updateNoBtn{background: #D1B2FF;}
   #cancelBtn{background: #B2CCFF;}
   #deleteNoBtn{background: #D5D5D5;}
</style>
</head>
<body>
   <%@ include file="../common/menubar.jsp" %>
   <div class="outer">
      <br>
      <h2 align="center">공지사항</h2>
      <div class="tableArea">
      	 <%--
      	 	(수정) 버튼을 누르면 updateNoticeForm.no 에 요청한다.
      	 	action="updateNoticeForm.no" 
      	 --%>
         <form action="<%=request.getContextPath() %>/updateNoticeForm.no" id="detailForm" name="detailForm">
            <table>
               <tr>
                  <th>제목</th>
                  <td>
                  <%= notice.getNoticeTitle() %>
                  <input type="hidden" size="50" name="title" value="<%= notice.getNoticeTitle()%>"></td>        
                  <td colspan="3">    
               </tr>
               <tr>
                  <th>작성자</th>
                  <td>
                     <%= notice.getNickName() %>
                     <input type="hidden" size=50 name="writer" value="<%=notice.getNoticeWriter() %>">
                  </td>
                  
                  <th>작성일</th>
                  <td>
                  	<%=notice.getNoticeDate() %>
                  	<input type="hidden" name="date" value="<%=notice.getNoticeDate() %>">
                  </td>
               </tr>
               <tr>
                  <th>내용</th>
               </tr>
               <tr>
                  <td colspan="4">
                     <textarea name="content" cols="60" rows="15" style="resize:none;" readonly>
                     <%=notice.getNoticeContent() %>
                     </textarea>
                  </td>
               </tr>
            </table>
         
            <br>
            
            <div align="center">
               <% if(loginUser!=null  && loginUser.getUserId().equals(notice.getNoticeWriter())){ %>	
               <input type="button" id="updateNoBtn" value="수정">
               <%-- 수정버튼을 누르면 /updateNoticeForm.no url을 매핑한 서블릿을 호출한다. 
               		updateNoticeForm.no 와 매핑된 서블릿은
               		수정페이지 폼 뷰를 랜더링할 뿐이다.
               --%>
               
               
               <input type="button" onclick="location.href='javascript:history.go(-1);'" id="cancelBtn" value="취소">
               <%}else{ %>
               <input type="button" onclick="location.href='javascript:history.go(-1);'" id="cancelBtn" value="취소">
               <%} %>
            </div>
         </form>
      </div>
   </div>
   
   <script>
   //(수정)버튼을 클릭(submit) => 클릭이벤트 발생 =>해당 글번호를 알아낸다.
  	$('#updateNoBtn').click(function(){
	   let num=<%=notice.getNoticeNo()%>;
	   location.href="<%= request.getContextPath()%>/updateNoticeForm.no?no="+num;
	   return true;

   }).mouseenter(function(){
	   
	   //확인용
	   let num=<%=notice.getNoticeNo()%>;
	   console.log(num);
	   
	   console.log("<%= request.getContextPath()%>/updateNoticeForm.no?no="+num );
   });
   </script>
</body>
</html>