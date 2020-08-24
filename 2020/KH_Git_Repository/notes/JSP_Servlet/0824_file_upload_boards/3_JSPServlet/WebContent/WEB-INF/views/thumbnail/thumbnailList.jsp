<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>

<%@ page import="java.util.ArrayList, board.model.vo.*" %>
    
<%
	ArrayList<Board> bList= (ArrayList<Board>)request.getAttribute("bList");
	ArrayList<Attachment> fList= (ArrayList<Attachment>)request.getAttribute("fList");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진게시판</title>
<style>
	.outer{width:1000px; height:700px; background: rgba(255, 255, 255, 0.4); border: 5px solid white;
		margin-left:auto; margin-right:auto; margin-top:50px;
	}
	.thumbnailArea {width:760px; height:550px; margin-left:auto; margin-right:auto;}
	.buttonArea {width:80px; margin-left:auto; margin-right:auto;}
	.thumb-list {width:220px; border:1px solid white; display:inline-block; margin:10px; align:center;}
	.thumb-list:hover {opacity:0.8; cursor:pointer;}
	#insertBtn{background: #B2CCFF;}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<div class="outer">
		<br>
		<h2 align="center">사진 게시판</h2>
		<div class="thumbnailArea">
			<%if(bList.isEmpty() || fList.isEmpty()){%>
				등록된 사진이 없습니다.
			<%} else{ %>
				<%for(int i=0; i<bList.size(); i++){ %>
					<%Board b= bList.get(i); %>
					<div class="thumb-list" align="center">
						<div>
							<input type="hidden" value="<%=b.getBoardId() %>">
							<%-- 한게시물 안에 여러개의 사진이 들어있으므로 안에 for문 한번더 --%>
							<% for(int j=0; j<fList.size(); j++){ %>
								<%
									Attachment a= fList.get(j); 
									if(b.getBoardId()==a.getBoardId()){
								%>
										<img src="<%=request.getContextPath()%>/thumbnail_uploadFiles/<%=a.getChangeName()%>" width="200px" height="150px">
								<%}%>
							<%} %>
						</div>
						<p>
							No.<%=b.getBoardId() %> <%=b.getBoardTitle() %><br>
							조회수: <%= b.getBoardCount() %>
						</p>
					</div>
				<%} %>
			<%} %>
		</div>
		
		<div class="buttonArea">
			<% if(loginUser != null) { %>
				<input type="button" onclick="location.href='writeThumbForm.th'" id="insertBtn" value="작성하기">
			<%} %>
		</div>
		<script>
			$(function(){
				$('.thumb-list').click(function(){
					let bId= $(this).children().children().eq(0).val();
					location.href='<%=request.getContextPath()%>/detail.th?bId='+bId;
				});
			});
		</script>
	</div>
</body>
</html>