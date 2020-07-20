package com.kh.controller;

import java.util.ArrayList;

import com.kh.model.dao.EmployeeDAO;
import com.kh.model.vo.Employee;
import com.kh.view.Menu;

public class EmployeeController {

	private EmployeeDAO empDAO = new EmployeeDAO();
	private Menu menu = new Menu();
	
	public void selectAll() {
		ArrayList<Employee> empList= empDAO.selectAll();
		if(!empList.isEmpty()) {//리스트가 비어있지 않다면
			menu.selectAll(empList);
			
		}else {
			menu.displayError("조회결과가 없습니다!");
		}
	}

	public void selectEmployee() {
		int empNo= menu.selectEmpNo(); // 사원번호 선택하기
		Employee emp=empDAO.selectEmployee(empNo);

		if(emp!=null) {
			System.out.println("사번: " + emp.getEmpNo());
			System.out.println("이름: " + emp.getEmpName());
			System.out.println("직책: " + emp.getJob());
			System.out.println("고용일: "+ emp.getHireDate());
			System.out.println("급여: "+ emp.getSal());
			System.out.println("커미션: "+ emp.getComm());
			System.out.println("부서번호: "+ emp.getDeptNo());
		}else {
			System.out.println("해당 사번"+ empNo+"에 대한 검색결과가 존재하지 않습니다!");
		}
	}

	public void insertEmployee() {
		Employee emp=menu.insertEmployee();
		int result= empDAO.insertEmployee(emp); //데이터 추가 반환값: int
		if(result>0) {
			menu.displaySuccess(result+ "개의 행이 추가되었습니다.");
		}else {
			menu.displayError("데이터 삽입 과정 중 오류 발생");
		}
	}

	public void updateEmployee() {
		int empNo= menu.selectEmpNo();
		Employee emp=menu.updateEmployee();
		emp.setEmpNo(empNo);
		int result=empDAO.updateEmployee(emp); // 데이터 업데이트 반환값 int
		if(result>0) {
			menu.displaySuccess(result+"개의 행이 수정이 완료되었습니다.");
		}else {
			menu.displayError("데이터 수정 과정중 오류가 발생했습니다.");
		}
	}

	public void deleteEmployee() {
		//사번으로 사원정보 삭제.
		//사번을 선택한다.
		int empNo=menu.selectEmpNo();
		
		//사원을 삭제할지 말지를 확인
		char isDeleted=menu.deleteEmployee();
		if(isDeleted=='y') {
		
			//삭제하려는 사원을 구한다.
			int result= empDAO.deleteEmployee(empNo);
			if (result>0)
				menu.displaySuccess(result+"개의 행이 삭제되었습니다");
			else
				menu.displayError("데이터 삭제과정중 오류가 발생했습니다.");
			
		}else if(isDeleted=='n'){
			menu.displayError("사원정보 삭제를 취소하였습니다.");
		}else {
			menu.displayError("잘못입력하였습니다.");
		}	
	}
}
