<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<style>
		#tb{margin: auto; width:700px;}
	</style>
</head>
<body>
	<c:import url="common/menubar.jsp"/>

	<h1 align="center">게시글 TOP5목록</h1>
	<table id="tb" border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
				<th>첨부파일</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	
	<script>
		function topList(){
			$.ajax({
				url: 'topList.bo',
				success: function(data){
					$tableBody=$('#tb tbody');
					$tableBody.html(''); //이미들어온것들을 더 추가못하게함.
					
					for(var i in data){
						var $tr =$('<tr>');
						var $bId= $('<td>').text(data[i].bId);//글번호
						var $bTitle=$('<td>').text(data[i].bTitle);//제목
						var $bWriter=$('<td>').text(data[i].bWriter);//작성자
						var $bCreateDate=$('<td>').text(data[i].bCreateDate);//날짜
						var $bCount=$('<td>').text(data[i].bCount);//조회수
						var $bFile=$('<td>').text(" ");//첨부파일
						if(data[i].originalFileName !=null){
							$bFile=$('<td>').text("O");
						}
						$tr.append($bId);
						$tr.append($bTitle);
						$tr.append($bWriter);
						$tr.append($bCreateDate);
						$tr.append($bCount);
						$tr.append($bFile);
						$tableBody.append($tr);
					}
				}
			});
		}
		
		$(function(){
			topList();
			setInterval(function(){
				topList();
			},5000);
		});
	</script>
</body>
</html>
