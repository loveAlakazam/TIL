<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="board.model.vo.*, java.util.ArrayList"%>
    
<%
	Board b= (Board)request.getAttribute("board");
	ArrayList<Reply> list= (ArrayList<Reply>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   .outer{
      width:800px; min-height:500px; background: rgba(255, 255, 255, 0.4); border: 5px solid white;
      margin-left:auto; margin-right:auto; margin-top:50px;
   }
   .tableArea {width: 450px; height:350px; margin-left:auto; margin-right:auto; align: center;}
   table{align: center;}
   #updateBtn{background: #B2CCFF;}
   #menuBtn{background: #D1B2FF;}
   #deleteBtn{background: #D5D5D5;}
   #addReply{background: #FFD8D8;}
</style>
</head>
<body>
   <%@ include file="../common/menubar.jsp" %>
      
   <div class="outer">
      <br>
      <h2 align="center">게시판 상세보기</h2>
      <div class="tableArea">
         <form action="<%= request.getContextPath() %>/boardUpdateForm.bo" id="detailForm" method="post">
         	<!--(수정)버튼을 클릭하면 url '/boardUpdateForm.bo'에 해당하는 서블릿이 처리한다.  -->
            <table>
               <tr>
                  <th>분야</th>
                  <td><%=b.getBoardType() %></td>
                  <th>제목</th>
                  <td colspan="3"><%=b.getBoardTitle() %></td>
               </tr>
               <tr>
                  <th>작성자</th>
                  <td><%=b.getNickName() %></td>
                  
                  <th>조회수</th>
                  <td><%=b.getBoardCount() %></td>
                  
                  <th>작성일</th>
                  <td><%=b.getCreateDate() %></td>
               </tr>
               
               <tr>
                  <th>내용</th> 
               </tr>
               <tr>
                  <td colspan="6">
                     <textarea cols="60" rows="15" style="resize:none;" readonly><%=b.getBoardContent() %></textarea>
                  </td>
               </tr>
            </table>
            
            <div align="center">
               <input type="submit" id="updateBtn" value="수정">
               <input type="button" onclick="deleteBoard();" id="deleteBtn" value="삭제"> <%-- 삭제버튼을 클릭하면 script함수를 호출한다. --%>
               <input type="button" onclick="location.href='<%= request.getContextPath() %>/list.bo'" id="menuBtn" value="메뉴로">
            </div>
           	<script>
           		function deleteBoard(){
           			//삭제버튼을 클릭하면 삭제를 담당하는 url을 요청하고
           			//그 url에 매핑된 서블릿을 호출하여 삭제연산을 처리한다.
           			location.href='<%=request.getContextPath()%>/deleteBoard.bo'; //url을 호출
           		}
           	</script>
         </form>
      </div>
      
      <div class="replyArea">
      	<div class="replyWriteArea">
      		<table>
      			<tr>
      				<td>댓글작성</td>
      				<td><textarea rows="3" cols="80" id="replyContent" style="resize: none;"></textarea></td>
      				<td><input type="button" id="addReply" value="댓글 등록"></td>
      			</tr>
      		</table>
      	</div>
      </div>
      
      <div id="replySelectArea">
      	<table id="replySelectTable">
      		<% if(list.isEmpty()){ %>
      			<tr><td colspan=3>댓글이 없습니다.</td><tr>
      		<%} else{
      				for(int i=0; i<list.size(); i++){
      		%>	
      					<tr>
      						<td width="100px"><%= list.get(i).getReplyWriter() %></td>
      						<td width="400px"><%= list.get(i).getReplyContent() %></td>
      						<td width="200px"><%= list.get(i).getCreateDate() %></td>
      					<tr>
      		<%		}
      		 }
      		%>
      	</table>
      </div>
      
   </div>
   <script>
   	$(function(){
   		$('#addReply').click(function(){
   			let writer= '<%=loginUser.getUserId() %>';
   			let bId=<%=b.getBoardId()%>;
   			let content=$('#replyContent').val();
   			
   			$.ajax({
   	   			url: 'insertReply.bo',
   	   			data: {writer:writer, content: content, bId:bId},
   	   			type: 'post', 
   	   			// get방식일때는 type을 생략가능하고(get방식은 길이제한이 있다.)
   	   			// post방식일때는 명시한다.
   	   			success: function(response){
   	   				console.log(response);
   	   				
   	   				$replyTable= $('#replySelectTable');
   	   				$replyTable.html('');
   	   				
   	   				for(let key in response){
   	   					let $tr= $('<tr>');
   	   					let $writerTd= $('<td>').text(response[key].replyWriter).css('width', '100px');
   	   					let $contentTd= $('<td>').text(response[key].replyContent).css('width', '400px');
   	   					let $dateTd= $('<td>').text(response[key].createDate).css('width', '200px');
   	   				
   	   					$tr.append($writerTd);
   	   					$tr.append($contentTd);
   	   					$tr.append($dateTd);
   	   					$replyTable.append($tr);
   	   					//$('#replyContent').val('');
   	   				}
   	   				
   	   				$("#replyContent").val("");
   	   			}
   	   		});
   		});
   		
   		
   	});
   </script>
</body>
</html>