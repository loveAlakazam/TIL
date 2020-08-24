<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	
	import ="java.util.ArrayList, board.model.vo.*" 
%>
    
<%
	// BoardListServlet.java(url: list.bo) 서블릿에서 얻어온 리스트를 가져온다.
	ArrayList<Board> list= (ArrayList<Board>)request.getAttribute("list");

	PageInfo pi=(PageInfo) request.getAttribute("pi");
	
	int listCount= pi.getListCount();
	int currentPage= pi.getCurrentPage();
	int maxPage= pi.getMaxPage();
	int startPage= pi.getStartPage();
	int endPage= pi.getEndPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style type="text/css">
   .outer{
      width: 800px; 
      height: 500px; 
      background: rgba(255, 255, 255, 0.4); 
      border: 5px solid white;
      margin-left: auto; 
      margin-right: auto; 
      margin-top: 50px;
   }
   
   #listArea{text-align: center;}
   
   .tableArea{
   		width:650px;   
   		height:350px; 
   		margin-left:auto;   
   		margin-right:auto;
   }
   
   th{
   		border-bottom: 1px solid grey;
   }
   
   .pagingArea button{
   		border-radius: 15px;
		background: #D5D5D5;
   	}
   
   .buttonArea{
   		margin-right: 50px;
   }
   
   .buttonArea button{
   		background: #D1B2FF;
		border-radius: 5px;
		color: white; width: 80px;
		heigth: 25px;
		text-align: center;
	}
	
   button:hover{
   		cursor: pointer;
   }
   
   #numBtn{
   		background: #B2CCFF;
   }
   
   #choosen{
   		background: #FFD8D8;
   }
   
   #listArea{
   		margin: auto;
   }
</style>
</head>
<body>
   <%@ include file="../common/menubar.jsp" %>
   <div class="outer">
      <br>
      <h2 align="center">게시판</h2>
      <div class="tableArea">
         <table id="listArea">
            <tr>
               <th width="100px">글번호</th>
               <th width="100px">카테고리</th>
               <th width="300px">글제목</th>
               <th width="100px">작성자</th>
               <th width="100px">조회수</th>
               <th width="150px">작성일</th>
            </tr>
            <tr>
            <% if(list.isEmpty()){ //리스트가 비어있을 때           %>
            		<td colspan="6">조회된 리스트가 없습니다.</td>
           	<%
           	} else{ //리스트가 비어있지 않을 때
           		for(Board b: list){
           	%>
	            <tr>
	            	<td>
	            		<input type="hidden" value="<%=b.getBoardId() %>">
	            		<%=b.getBoardId() %>
	            	</td>
	            	<td><%= b.getCategory() %></td>
	            	<td><%= b.getBoardTitle() %></td>
	            	<td><%= b.getNickName() %></td>
	            	<td><%= b.getBoardCount() %></td>
	            	<td><%= b.getModifyDate() %></td>
	            </tr>
				<%} %>
            <%} %>

         </table>
         <!--  페이징 -->
         <div class="paginArea" align="center">
         	<!--  맨처음으로: 현재페이지가 1 -->
         	<button onclick="location.href='<%=request.getContextPath() %>/list.bo?currentPage=1'">&lt;&lt;</button>
         	
         	<!--  이전페이지로 이동:
         		현재페이지 1일때 -> 이전페이지를 누르지 못하게 해야한다. 0페이지는 없으니까.
         	 -->
         	<button onclick="location.href='<%=request.getContextPath() %>/list.bo?currentPage=<%=currentPage-1%>'" 
         			id="beforeBtn">&lt;</button>
         	<script>
         		if(<%=currentPage%><=1){
         			//현재페이지가 1이라면, 이전페이지 누르지 못하게함.
         			let before=$('#beforeBtn');
         			before.attr('disabled', 'true'); //이전페이지를 누르지못하게끔 disable시킴. (클릭실행하지 못하도록, 더이상 1페이지의 이전페이지로 갈수없게끔.)
         		}
         	</script>
         			
         	<!-- 10개의 페이지 목록 (페이징 숫자 ex: 1,2,3,4,5,6,7,8,9,10) -->
         	<%for(int p=startPage; p<=endPage; p++) {%>
         		<%--현재페이지는 더이상 누를 수 없고, 다른페이지는 누를수있다. --%>
         		<%if(p==currentPage){ //p가 현재페이지(currentPage)와 같다면 => 현재페이지에 해당하는 페이징은 선택될 수 없도록함.%>
         			<button id="choosen" disabled><%=p %></button>
         		<%}else{ //p가 현재페이지와 같지 않다면 => 현재페이지에 해당하는 페이징은 선택될 수 있다.%>
         			<button id="numBtn" 
         				onclick="location.href='<%=request.getContextPath() %>/list.bo?currentPage=<%=p %>'"><%=p %></button>
         		<%} %>
         	<%} %>
         	
         	<!-- 다음페이지 -->
         	<button onclick="location.href='<%=request.getContextPath() %>/list.bo?currentPage=<%=currentPage+1%>'" 
         			id="afterBtn">&gt;</button>
         			
         	<script>
         		if(<%=currentPage%> >=<%=maxPage%>){
         			//현재페이지가 마지막페이지보다 크거나 같게되면 이동하지 못하도록해야한다.
         			let afterBtn=$('#afterBtn');
         			afterBtn.attr('disabled','true');
         		}
         	</script>
         	
         	<!-- 맨끝으로 -->
         	<button onclick="location.href='<%=request.getContextPath() %>/list.bo?currentPage=<%=maxPage %>'">&gt;&gt;</button>
         </div>
         
         <div class="buttonArea" align="right">
         
         	<!-- insert-->
         	<%if(loginUser !=null){ %>
         		<button onclick="location.href='<%=request.getContextPath()%>/writeBoardForm.bo'">작성하기</button>
         	<%} %>
         	
         </div>
      </div>
      <script>
      	$(function(){
      		$('#listArea td').mouseenter(function(){
      			$(this).parent().css({'background':'darkgray', 'cursor':'pointer'});
      		}).mouseout(function(){
      			$(this).parent().css('background','none');
      			
      		}).click(function(){
      			let bId= $(this).parent().children().children('input').val();
      			<% if(loginUser!=null){%>
      				location.href='<%= request.getContextPath()%>/detail.bo?bId='+bId;
      			<%}else{%>
      				alert('회원만 이용할 수 있는 서비스입니다.');
      			<%}%>
      		});
      	});
     
      </script>
   </div>
</body>
</html>