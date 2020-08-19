> # 회원정보 페이지에서 닉네임 중복 확인하기

## 1. memberUpdateForm.jsp

- `수정하기`버튼을 누르면 modal창을 오픈한다.
  - 즉, `수정하기` 버튼을 누르면 `/update.me` url을 요청한다.

- `중복확인`버튼을 누르면 `checkNick()` 자바스크립트 함수를 호출한다.
  - `checkNick()`함수 내부 수행문에서 modal창을 띄우는 함수를 호출한다.

  - 연결된 url은 `checkNickNameFormMyPage.me` 이며, mapping된 서블릿은 `CheckNickNmaeFormMyPageServlet.java` 파일이다.

  - 연결된 url과 연결된 화면, 즉 modal창의 내용물은 `<form>`태그의 `id`속성을 이용하여 가져온다.
    - `nickNameCheckForm`은 `CheckNickNameFormMyPage.me` url요청으로 인해서 연결해주는 페이지 `checkNickNameFormMyPage.jsp`의 `<form>`태그의 id이다.


```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// MemberUpdateFormServlet.java에서 셋팅시킨 이름이 myInfo인 Member객체를 불러온다.
	// myInfo 이름으로 setting한 객체값을 불러온다.
	Member myInfo= (Member) request.getAttribute("myInfo");
	String id=myInfo.getUserId();
	String name= myInfo.getUserName();
	String  nickName= myInfo.getNickName();
	String phone= myInfo.getPhone().equals("null")?"-":myInfo.getPhone();
	String email= myInfo.getEmail().equals("null")?"-":myInfo.getEmail();
	String address= myInfo.getAddress().equals("null")?"-":myInfo.getAddress();
	String interestStr= myInfo.getInterest().equals("null")?"-":myInfo.getInterest();
	String [] interest= new String[6];
	if(!interestStr.equals("-")){
		String[] splitStr= interestStr.split(",");

		for(int i=0; i<splitStr.length; i++){
			switch(splitStr[i]){
			case "운동": interest[0]= "checked"; break;
			case "등산": interest[1]= "checked"; break;
			case "낚시": interest[2]= "checked"; break;
			case "요리": interest[3]= "checked"; break;
			case "게임": interest[4]= "checked"; break;
			case "기타": interest[5]= "checked"; break;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script src="https://code.jqeury.com/jquery-3.5.1.min.js"></script>
<style>
   .outer{
      width: 48%; height: 450px; background-color: rgba(255, 255, 255, 0.4); border: 5px solid white;
      margin-left: auto; margin-right: auto; margin-top: 5%;
   }
   #updateForm td {text-align: right;}
   #updateForm>table{margin: auto;}
   #updateForm tr:nth-child(3) > td:nth-child(3){text-align: left;}
   td>.must{color: red; font-weight: bold;}
   #nickCheck{background: #FFD8D8;}
   #updateBtn {background: #D1B2FF;}
   #cancelBtn {background: #B2CCFF;}
</style>
</head>

<body>
<%@ include file="../common/menubar.jsp" %>

   <div class="outer">
      <br>
      <h2 align="center">내 정보 수정하기</h2>

      <form action="<%= request.getContextPath() %>/update.me" method="post" id="updateForm" name="updateForm">
         <table>
            <tr>
               <td width="200px"><label class="must">*</label> 아이디</td>
               <td width="200px"><input type="text" name="myId" style="background:lightgray;" readonly></td>
            </tr>
            <tr>
               <td><label class="must">*</label> 이름</td>
               <td><input type="text" name="myName" required></td>
            </tr>
            <tr>
               <td><label class="must">*</label> 닉네임</td>
               <td><input type="text" maxlength="15" name="nickName" id="nickName" required></td>

               <td><input type="button" id="nickCheck" onclick="checkNick();" value="중복확인"></td>
               <!--(중복확인) 버튼을 누르면 checkNick() javascript함수를 호출한다.  -->
            </tr>
            <tr>
               <td>연락처</td>
               <td>
                  <input type="tel" maxlength="11" name="myPhone" placeholder="(-없이)01012345678">
               </td>
            </tr>
            <tr>
               <td>이메일</td>
               <td><input type="email" name="myEmail"></td>
            </tr>
            <tr>
               <td>주소</td>
               <td><input type="text" name="myAddress"></td>
            </tr>
            <tr>
               <td>관심분야</td>
               <td>
                  <input type="checkbox" id="sports" name="myInterest" value="운동" <%=interest[0] %>>
                  <label for="sports">운동</label>
                  <input type="checkbox" id="climbing" name="myInterest" value="등산" <%=interest[1] %> >
                  <label for="climbing">등산</label>
                  <input type="checkbox" id="fishing" name="myInterest" value="낚시" <%=interest[2] %>>
                  <label for="fishing">낚시</label>
                  <input type="checkbox" id="cooking" name="myInterest" value="요리" <%=interest[3] %>>
                  <label for="cooking">요리</label>
                  <input type="checkbox" id="game" name="myInterest" value="게임" <%=interest[4] %>>
                  <label for="game">게임</label>
                  <input type="checkbox" id="etc" name="myInterest" value="기타" <%=interest[5] %>>
                  <label for="etc">기타</label>
               </td>
            </tr>
         </table>

         <br>

         <div class="btns" align="center">
         	<%--
         		(수정하기) 버튼을 누르면  /update.me url에게 요청을 보낸다.
         		/update.me url에 매핑되는 서블릿을 불러온다.
         	 --%>
            <input id="updateBtn" type="submit" value="수정하기">
            <input type="button" id="cancelBtn" onclick="location.href='javascript:history.go(-1)'" value="취소하기">
         </div>
      </form>
   </div>

   <script>
   	//(중복확인)버튼 클릭 => 겹치는 닉네임이 있는지 확인
   	function checkNick(){
   		//팝업창을 띄운다.
   		//1번째 항: 연결url(checkNickNameFormMyPage.me)와 연결된 서블릿인 CheckNickNameFormMyPageServlet을 호출한다.
   		//2번째 항: 1번째항과 연결된 페이지의 폼태그(모달창의 내용)
   		window.open("checkNickNameFormMyPage.me", "nickNameCheckForm", "width=300, height=200");
   	}
   </script>

</body>
</html>
```

<br>
<br>

## 2. ChekNickNameFormMyPageServlet.java

- url `/checkNickNameFormMyPage.me`와 매핑된 서블릿이다.

```java
package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/checkNickNameFormMyPage.me")
public class CheckNickNameFormMyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CheckNickNameFormMyPageServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.getRequestDispatcher("WEB-INF/views/member/checkNickNameFormMyPage.jsp").forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```

<br>
<br>

## 3. checkNickNameFormMyPage.jsp

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 닉네임 중복검사</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<h2>닉네임 중복 검사</h2>
	<form action="<%=request.getContextPath() %>/checkNickNameMyPage.me" id="nickNameCheckForm" >
		<input type="text" id="inputNickName" name="inputNickName">
		<input type="submit" value="중복확인">
	</form>

	<br>
	<br>
	<%
	/*
		중복확인 버튼을 누르면 -> url "/checkNickNameMyPage.me" 와 연결된 서블릿 CheckNickNameMyPageServlet.java에서
		처리한 결과데이터 result와 checkedNickName을  
		request.getAttribute()함수를 이용하여 가져온다.
	*/

	if(request.getAttribute("result")!=null){ //만일 닉네임 중복여부 결과값이 null이 아니라면
		int result=(int)request.getAttribute("result");
		if(result>0){ // 중복된 닉네임
	%>
			<span style="color:red;">이미 사용하고 있는 닉네임 입니다!</span>
	<%	}else{ %>
			<span style="color:blue;">사용가능한 닉네임 입니다!</span>
	<%	} %>
	<%} %>


	<input type="button" id="usedNickName" value="확인" >
	<input type="button" id="cancel" value="취소" onclick="window.close();">
	<script>
	$(function(){
		//CheckedNickNameServlet.java페이지에서
		//세팅한 result와 checkedNickName을 얻는다.

		//요구한 checkNickName이 null이라면
		if('<%=request.getAttribute("checkedNickName")%>'=='null')
		{
			//id가 updateForm(memberUpdateForm.jsp)인 부모창에서 닉네임(name이 nickName)입력값을 불러온다.
			let inputNickNameValue= $('#inputNickName');
			inputNickNameValue.val(opener.document.updateForm.nickName.value);

		}else{
			$('#inputNickName').val("<%=request.getAttribute("checkedNickName")%>");
		}

		//확인버튼을 클릭하면 함수를 실행한다.
		$('#usedNickName').click(function(){
			let inputNickNameValue= $('#inputNickName').val();

			// 아이디가 nickName에 해당하는 태그의 값에 입력한 닉네임의 값을 넣는다.
			opener.document.updateForm.nickName.value=inputNickNameValue;
			self.close();
		});

	});

	</script>

</body>
</html>
```

<br>

## 4. CheckNickNameMyPageServlet.java

- `/checkNickNameMyPage.me` url과 매핑된 서블릿이다.
- 이때까지는 컨트롤러에 해당한다.

```java
package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

@WebServlet("/checkNickName.me")
public class CheckNickNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CheckNickNameServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//checkNickNameForm.jsp에서 입력한 닉네임 데이터를 받는다.
		String nickName= request.getParameter("inputNickName");

		//닉네임이 중복되는지 확인하기위한 int로 반환 => select문 => (중복) 1개 / (중복x) 0개
		int result=new MemberService().checkNickName(nickName);

		request.setAttribute("result", result); //nickName이 중복됐는지 쿼리결과를 세팅
		request.setAttribute("checkedNickName", nickName); //입력한 nickName 값을 세팅
		request.getRequestDispatcher("WEB-INF/views/member/checkNickNameFormMyPage.jsp").forward(request, response); //세팅한값을 dispatcher가 가리키는 페이지에게로 보냄.

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
```

<br>

## 5. MemberService.java

- MVC패턴 중 Service 패키지에 해당한다.
- checkNickName() 메소드를 정의.

```java
package member.model.service;

//JDBCTemplate의 공용메소드인 getConnection()을 임포트
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;

import member.model.dao.MemberDAO;
import member.model.vo.Member;

public class MemberService {
	//service패키지: connection을 받아와서 db와 연결하여 트랜젝션 처리.

  //checkNickName 이외의 함수들은 생략//

	public int checkNickName(String nickName) {
		Connection conn= getConnection();
		int result= new MemberDAO().checkNickName(conn, nickName);
		close(conn);
		return result;
	}

}

```


## 6. MemberDAO.java

- MVC패턴 중 model의 dao패키지에 해당한다.
- 데이터베이스로부터 쿼리문에 맞는 데이터를 받는다.

```java
package member.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import member.model.vo.Member;

public class MemberDAO {
	private Properties prop =new Properties();
	public MemberDAO() {
    //회원관련 데이터조작 sql 쿼리문이 담긴 프로퍼티 파일을 오픈한다.
		String fileName= MemberDAO.class.getResource("/sql/member/member-query.properties").getPath();

		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

  //checkNickName과 생성자를 제외한 메소드들은 생략//

	public int checkNickName(Connection conn, String nickName) {
		PreparedStatement pstmt= null;
		ResultSet rset= null;
		int result=0;

		// 불러올 프로퍼티의 키값이 존재하지 않으면 => java.sql.SQLException이 발생.
		String query=prop.getProperty("checkNickName");

		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, nickName);
			rset=pstmt.executeQuery();
			if(rset.next()) {
				//이미 닉네임이 있다.
				result=rset.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

}

```

<br>
<hr>
<br>

> # 회원정보 수정하기
