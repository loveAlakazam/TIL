# 닉네임 중복 확인하기

> # 풀이방법

- 아이디 중복체크 과정과 똑같음.

- ## 1. signUpForm.jsp
  - `중복확인` 버튼을 누르면 `checkNick()` javascript함수를 호출.

  - window.open() : 일종의 modal창이라고 보면된다.
    - window.open(`checkNickNameForm.me`와 연결된 서블릿 ,
      앞의 서블릿과 연결페이지인 `checkNickNameForm.jsp`에서 <form>태그 id,
      modal창 크기 지정);

<BR>

  ```html
  <!-- 페이지의 일부만 발췌했습니다. -->
  <form action="<%=request.getContextPath()%>/insert.me" method="post"
  	id="joinForm" name="joinForm">
          <!-- ...(중략)... -->
  			<td width="200px">
  				<input type="button" id="nickCheck" value="중복확인" onclick="checkNickName();" >
  			</td>

        <!-- (하략) -->

  ```

<br>

  ```javascript
  function checkNickName(){
  		//팝업창을 띄운다.
  		//checkNickNameForm.me url에 매핑된 서블릿을 호출한다 => CheckNickNameFormServlet.java
  		window.open("checkNickNameForm.me", "nickNameCheckForm", "width=300, height=200");
  }
  ```

<br>

- ## 2. CheckNickNameFormServlet.java
  - url `checkNickNameForm.me`와 연결된 서블릿

```java
package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/checkNickNameForm.me")
public class CheckNickNameFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public CheckNickNameFormServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    // 다음페이지로 요청할때 입력값이 필요없이 연결페이지만 랜더링할때도 사용할 수 있다.

    //sendRedirect()의 경우에는 새로운 request객체를 생성하고,
    //생성할때마다 url주소가 바뀌기 때문에 연결된페이지에서는 적합하지 않다.

    // 브라우저로부터 입력받은 데이터를 연결된 페이지로 전달할 때는 getRequestDispatcher()를 반드시 사용해야한다.
		request.getRequestDispatcher("WEB-INF/views/member/checkNickNameForm.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```

<br>

- ## 3. checkNickNameForm.jsp
  - 중복확인 버튼을 누르면 `checkNickName.me` url을 요청하여, url에 매핑된 servlet에게 넘어간다.

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>닉네임 중복 검사</title>
</head>
<body>
	<h2>닉네임 중복 검사</h2>

	<%--
		submit버튼을 누르면 => checkNickName.me url을 요청하고
		checkNickName.me url과 매핑된 서블릿을 호출한다.
		checkNickNameServlet.java
	 --%>
	<form action="<%=request.getContextPath() %>/checkNickName.me" id="nickNameCheckForm" >
		<input type="text" id="inputNickName" name="inputNickName">
		<input type="submit" value="중복확인">
	</form>


	<%
		// getAttribute("result") : CheckNickNameServlet에서 입력한 닉네임이 중복인지 쿼리실행결과(result)를 불러온다.
		if(request.getAttribute("result")!=null){
			//쿼리 실행결과문 result가 존재한다면(0이거나 1)
			int result=(int)request.getAttribute("result");

			if(result>0){ //중복된 아이디라면
	%>
				<span style="color: red">이미 사용하고 있는 닉네임 입니다</span>
	<%
			}else{// 중복된 아이디가 아니라면
	%>
				<span style="color: blue">사용가능한 닉네임 입니다</span>
	<%
			}

		}
	%>

	<br>
	<br>

	<input type="button" id="usedNickName" value="확인" >
	<input type="button" id="cancel" value="취소" onclick="window.close();">
	<script>
	$(function(){
		//CheckedNickNameServlet.java페이지에서
		//세팅한 result와 checkedNickName을 얻는다.

		//요구한 checkNickName이 null이라면
		if('<%=request.getAttribute("checkedNickName")%>'=='null')
		{
			//id가 joinForm(signUpForm.jsp)인 부모창에서 닉네임(name이 nickName)입력값을 불러온다.
			let inputNickNameValue= $('#inputNickName');
			inputNickNameValue.val(opener.document.joinForm.nickName.value);
		}else{
			$('#inputNickName').val("<%=request.getAttribute("checkedNickName")%>");
		}

		//확인버튼을 클릭하면 함수를 실행한다.
		$('#usedNickName').click(function(){
			let inputNickNameValue= $('#inputNickName').val();
			console.log(inputNickNameValue);
			opener.document.joinForm.nickName.value=inputNickNameValue;
			self.close();
		});

	});

	</script>

</body>
</html>
```

<br>

- ## 4. CheckNickNameServlet.java
  - `checkNickName.me` url에 매핑된 서블릿이다.
  - 닉네임 중복확인을 하려면 데이터베이스와 연결한다.
  - 서블릿들은 MVC패턴중 `Controller`에 속해있다.

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
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//checkNickNameForm.jsp에서 입력한 닉네임 데이터를 받는다.
		String nickName= request.getParameter("inputNickName");

		//닉네임이 중복되는지 확인하기위한 int로 반환 => select문 => (중복) 1개 / (중복x) 0개
		int result=new MemberService().checkNickName(nickName);

		request.setAttribute("result", result); //nickName이 중복됐는지 쿼리결과를 세팅
		request.setAttribute("checkedNickName", nickName); //입력한 nickName 값을 세팅
		request.getRequestDispatcher("WEB-INF/views/member/checkNickNameForm.jsp").forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```

<br>

- ## 5. MemberServie.java
  - MVC패턴에서 Service 패키지
    - 데이터베이스와 쉽게 연결하도록 커넥션을 만들어준다 (직접 드라이버 만들필요없다는 뜻이다.)

    - 또한, 트랜젝션(rollback, commit) 처리를 담당한다.

```java
// 닉네임 중복체크와 관련된 함수만 발췌
public int checkNickName(String nickName) {
		Connection conn= getConnection();
		int result= new MemberDAO().checkNickName(conn, nickName);
		close(conn);
		return result;
	}
```

<br>

- ## 6. MemberDAO.java
  - DAO영역은 물리적 데이터베이스와 연결하는 영역이다.
  - 쿼리문에 넣어야할 조건값이과 데이터베이스 커넥션을 보내서 실제 물리적데이터베이스와 연결한다.
  - 쿼리문을 실행하여, 쿼리문에 해당하는 데이터를 받는다.

  - `PreparedStatement` 객체는 `Statement`객체와 다르게 완전하지 않은 쿼리문실행 객체이다.
    - 왜냐하면, `?`(위치 홀더)에 해당하는 조건값을 넣은 뒤에 쿼리문을 수행하기때문이다.

  - 데이터베이스 프로퍼티를 불러와야한다.
    - 프로퍼티는 key와 value가 string 타입인 HashMap이다.
    - 프로퍼티 key에 해당하는 value가 sql문이다.

  - `select`문 일경우에는 `executeQuery()`함수를 사용한다.
    - 반환값은 `ResultSet` 객체이다.

  - 반면, `update`, `insert`, `delete`문은 `executeUpdate()`함수를 사용한다.
    - 반환값은 `int(정수)`이다.

```java
// 닉네임 중복확인과 관련된 함수만 발췌했습니다.
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

```

- sql문 (checkNickName 프로퍼티 키값에 대응되는 value값)
```sql
checkNickName=SELECT COUNT(*) FROM MEMBER WHERE NICKNAME=? AND STATUS='Y'
```
