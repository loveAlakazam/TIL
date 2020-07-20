package com.kh.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.kh.model.vo.Employee;

// 데이터베이스와 연결.
public class EmployeeDAO {
	public ArrayList<Employee> selectAll() {
		Connection conn=null;
		Statement stmt=null;
		ResultSet rset=null;
		ArrayList<Employee> empList=null;
		//DriverManager 만들기
		try {
			// 해당 DB에 대한 라이브러리 (JDBC드라이버) 등록 작업
			Class.forName("oracle.jdbc.driver.OracleDriver");
		
			// 데이터베이스와 연결 작업
			// 연결 정보를 담을 Connection 인터페이스와 연결처리를 하기위한 DriverManager 클래스가 필요하다.
			
			//getConnection(
			//	"jdbc계정정보 => 오라클에 설정된 서버 ip =DB접속 컴퓨터 IP,
			// 	db사용자 이름: "SCOTT",
			//  패스워드 "SCOTT")
			
			// getConnection() arguments 설명.
			// 0번째인자: jdbc:oracle:thin:@127.0.0.1:1521:xe => DB접속 컴퓨터 IP 주소
			// 1번째인자: 접속할 계정명
			// 2번째인자: 계정비밀번호
			
			// ojdbc 파일이 필요하다. => 등록을 하지 않으면 exception이 발생
			// *.jar 파일 등록 방법
			// 프로젝트 오른쪽마우스 클릭 => properties => add jar => ojdbc6.jar파일을 넣는다.
			conn=DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:xe", "SCOTT", "SCOTT");
			
			System.out.println(conn);
			// oracle.jdbc.driver.T4CConnection@7ba18f1b
			
			String query="SELECT * FROM EMP";
			
			// Connection객체에서 Statement를 갖고온다.
			stmt= conn.createStatement();
			
			//SELECT 쿼리문 실행.
			rset= stmt.executeQuery(query);
		
			// 전체 쿼리 결과를 담는 리스트
			empList= new ArrayList<Employee>();
			
			//단일 데이터 로우는 Employee객체 하나를 의미한다.
			Employee emp =null;
			while(rset.next()) { //rset에 다음값이 존재하면
				//ResultSet.next(): boolean
				// 반환 받은 조회 결과를 한행씩 접근하면 true/ 존재하지 않으면 false
				
				// 각 컬럼별 데이터를 구한다.
				int empNo =rset.getInt("EMPNO"); //EMP테이블의 EMPNO 컬럼
				String empName= rset.getString("ENAME");//EMP테이블의 ENAME컬럼
				String job =rset.getString("JOB");
				int mgr= rset.getInt("MGR");
				
				// java.sql.Date
				Date hireDate= rset.getDate("HIREDATE");
				
				int sal = rset.getInt("SAL");
				int comm= rset.getInt("COMM");
				int deptNo= rset.getInt("deptNO");// DB컬럼이 대소문자 가리지 않은것처럼, 마찬가지로  소문자로 써도 된다.
				
				//Employee 객체 생성
				emp=new Employee(empNo, empName, job, mgr, hireDate, sal, comm, deptNo);
				
				//만든 객체를 리스트에 넣는다.
				empList.add(emp);
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		// 모두 닫아줘야한다.
		finally {
			//가장 늦게 연것부터 닫는다.
			try {			
				rset.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return empList;
	}

	
	
	public Employee selectEmployee(int empNo) {
		Connection conn=null;
//		Statement stmt=null;
		PreparedStatement pstmt=null;
		ResultSet rset=null;
		Employee emp=null;
		
		try {
			
			//DriverManager객체 생성
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//Connection객체 생성 - 현재 내컴퓨터랑 연결.
			conn= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "SCOTT"); //localhost=127.0.0.1
			
// Statement => 완성된 쿼리문을 실행
//			String query= "SELECT * FROM EMP WHERE EMPNO="+empNo; 
			//Statement객체 생성
//			stmt = conn.createStatement();
// select문 => executeQuery() => 쿼리를 보낸다. (DB에 보낸다)

			
			//PreparedStatement를 이용해보자 
			// 미완성된 쿼리문
			String query= "SELECT * FROM EMP WHERE EMPNO= ?";
			pstmt= conn.prepareStatement(query);
			pstmt.setInt(1, empNo); //1번째 플레이스홀더에 empNo를 넣는다.
			
//			 select문은 ResultSet객체로 쿼리응답을 받는다.
			//rset=stmt.executeQuery(query);
			rset= pstmt.executeQuery(); //(결과) 1개 ~ 0개
			if(rset.next()) {
				String empName= rset.getString("ename");
				String job= rset.getString("job");
				int mgr= rset.getInt("mgr");
				Date hireDate= rset.getDate("hiredate");
				int sal = rset.getInt("sal");
				int comm= rset.getInt("comm");
				int deptNo= rset.getInt("deptNo");
				
				emp=new Employee(empNo, empName, job, mgr, hireDate, sal, comm, deptNo);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rset.close();
				//stmt.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return emp;
	}



	public int insertEmployee(Employee emp) {
		Connection conn =null;
		//Statement도 할 수 있지만, 쿼리문이 길어질 수 있다.
		PreparedStatement pstmt= null;
		
		int result=0; // update, insert, delete 쿼리문은 int형으로.
		
		try {
			// DriverManager 객체를 만든다.
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//Connection객체를 만든다.
			conn= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "SCOTT");
			
			String query= "INSERT INTO EMP VALUES(?,?,?,?,SYSDATE, ?,?,?)";
			
			// ERROR
			//String query= "INSERT INTO EMP VALUES(?,?,?,?,SYSDATE, ?,?,?);";
			//java.sql.SQLSyntaxErrorException: ORA-00911: invalid character
			
			//PreparedStatement 생성 => conn.prepareStatement(query)
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, emp.getEmpNo());
			pstmt.setString(2,  emp.getEmpName());
			pstmt.setString(3,  emp.getJob());
			pstmt.setInt(4,  emp.getMgr());
			pstmt.setInt(5, emp.getSal());
			pstmt.setInt(6,  emp.getComm());
			pstmt.setInt(7,  emp.getDeptNo());
			
			result= pstmt.executeUpdate();
			
			// transaction 을 이용하여 result값에 따라 rollback과 commit을 수행한다.
			if(result>0)
				conn.commit();
			else
				conn.rollback();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}



	public int updateEmployee(Employee emp) {
		Connection conn=null;
		PreparedStatement  pstmt= null;
		int result=0;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			conn= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "SCOTT");
			String query="UPDATE EMP SET JOB=?, SAL=?, COMM=? WHERE EMPNO=?";
		
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, emp.getJob());
			pstmt.setInt(2,  emp.getSal());
			pstmt.setInt(3,  emp.getComm());
			pstmt.setInt(4,  emp.getEmpNo());
			
			result=pstmt.executeUpdate();
			if(result>0)
				conn.commit();
			else
				conn.rollback();
			
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
		
			e.printStackTrace();
		}finally {
			//닫는다.
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}



	public int deleteEmployee(int empNo) {
		int result=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		//DriverManager 객체를 부른다.
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//Connection객체를 생성한다.
			conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "SCOTT");
			
			//쿼리문(미완성된 쿼리문)
			String query="DELETE FROM EMP WHERE EMPNO=?";
			
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, empNo);
			result= pstmt.executeUpdate();
			if(result>0)
				conn.commit();
			else
				conn.rollback();
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			//닫는다.
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
}
