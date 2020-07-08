package com.kh.project.mini.cafe.view;



import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

import com.kh.project.mini.cafe.model.vo.Member;

//커피깡 마이페이지 GUI - 로그인 이전 화면 
public class MyPage extends JPanel {
	//메인프레임 안에 있는 패널을 바꿀 때사용.
	private MainFrame mf;
	private Member me;
	private String id;
	
	// 생성자
	public MyPage(MainFrame mf, Member me) {
		// 프레임이름 : 커피깡 - 마이페이지
		mf.setTitle("마이페이지");
		this.mf = mf;
		this.me = me;
		this.id=me.getId();
		
		System.out.println("[마이페이지] me:"+ this.me);
		
		// 현재 패널의 레이아웃을 GridLayout으로 한다.
		setLayout(new GridLayout(5,5,20,20)); //5행 5열/ 간격 20씩
		
	
		//1. 라벨(타이틀) 컴포넌트
		String id= me.getId();
		String name= me.getName();
		JLabel titleLabel= new JLabel( name + " 님의 페이지 입니다.");
		titleLabel.setHorizontalAlignment(JLabel.CENTER); //라벨을 가운데 정렬한다.
		add(titleLabel); //현재 패널안에 컴포넌트(타이틀-라벨)을 넣는다.
		
		
		//2. 메뉴리스트 컴포넌트
		String[] menuStr= { 
				"주문내역 조회", 
				"비밀번호 변경", 
				"이름 변경",
				"주소 변경",
				"회원 탈퇴"
		};
		
		JList<String> menu = new JList<String>(menuStr);
		
		// 리스트 메뉴는 한개만 선택할 수 있도록 설정한다.
		JPanel resultPanel = new JPanel();
		JLabel choiceMenu = new JLabel("메뉴를 클릭하시면 바로 이동합니다.");
		
		resultPanel.add(choiceMenu);
		add(resultPanel, "Center");
		
		//스크롤바를 만들고
		//스크롤바 컴포넌트 안에 menu를 넣는다.
		JScrollPane scroller= new JScrollPane(menu);
		scroller.setPreferredSize(new Dimension(300,300));//스크롤러의 크기를 지정한다.
		add(scroller); //패널에 스크롤러를 넣는다.
		
		menu.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
		
		
		//리스트를 선택하면, 발생하는 이벤트 리스너를 만든다.
		menu.addListSelectionListener(new ListSelectionListener() {			
			@Override
			public void valueChanged(ListSelectionEvent e) {
				//리스트중 하나를 선택
				String selectedMenu= menu.getSelectedValue(); //선택한 리스트의 값을 추출.
				int selectIdx= menu.getSelectedIndex(); //선택한 리스트의 인덱스번호
				

				if(selectIdx == 0) {//주문 내역 조회
					changePanel(new ShowMyOrders(mf,me));
				}
				else if(selectIdx == 1){//비밀번호 변경
					changePanel(new UpdatePassword(mf,id, me)); 
				}
				else if(selectIdx == 2) {//이름변경
					changePanel(new UpdateName(mf,id, me));
				}
				else if(selectIdx == 3) {//주소변경
					changePanel(new UpdateAddress(mf,id, me));
				}
				else if(selectIdx == 4) { //회원탈퇴 
					//한번더 로그인을 하고 -> 탈퇴처리한다.
					changePanel(new LoginAgain(mf, id,selectIdx));
				}
			}
		});
		
		//돌아가기버튼생성 => LoginAfter메뉴 창띄우기
		JButton button = new JButton("이전페이지로 돌아가기");
		add(button, "Center");
		button.addActionListener(new GoLoginAfterListener());
		
		// 현재패널을 메인프레임에 적용한다.
		mf.add(this);
	}
	
	//돌아가기 버튼 누르면  LoginAfter로 넘어가기
	class GoLoginAfterListener implements ActionListener{
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new LoginAfter(mf, id));
		}
	}
	
	
	//메소드
	public void changePanel(JPanel panel) {
		mf.remove(this);
		mf.add(panel);
		mf.revalidate();
		mf.repaint();
	}

}
