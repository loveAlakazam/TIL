package com.kh.project.mini.cafe.view;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

import com.kh.project.mini.cafe.model.vo.Member;

public class ShowMyOrders extends JPanel{
	private MainFrame mf;
	private Member me;
	
	//생성자
	public ShowMyOrders(MainFrame mf, Member me) {
		System.out.println("[주문 내역 확인하기 ]");
		System.out.println("me: "+ me);
		
		
		this.mf = mf;
		this.me = me;
		String name = me.getName();
		
		mf.setTitle(name + "님의 주문내역 ");
		setLayout(new GridLayout(5,5,20,20));
		
		//타이틀 라벨
		JLabel label= new JLabel(name + "님의 주문내역 입니다. ");
		label.setHorizontalAlignment(JLabel.CENTER); //라벨을 가운데 정렬한다.
		add(label); //현재 패널안에 컴포넌트(타이틀-라벨)을 넣는다.
		
		
		JPanel resultPanel = new JPanel();
		add(resultPanel);
		
		//리스트 메뉴는 한개만 선택할 수 있게 한다.
		JLabel OrderList = new JLabel("최근 주문목록 (내림차순)");
		resultPanel.add(OrderList);
		add(resultPanel, "Center");
		
		
		System.out.println("myorder : " + me.getOrderHistory());
		
		
		//주문내역을 표시할 텍스트 애리아
		JTextArea textArea = new JTextArea(30, 30);
		String myHistory= me.getOrderHistory();
		System.out.println("나의 주문내역: me.getOrderHistory(): "+ myHistory);
		
		textArea.setText(myHistory);
//		textArea.setLineWrap(true); //자동줄바꿈.
//		textArea.setEditable(false);
//		add(textArea);
			
		JScrollPane scroller =new JScrollPane(textArea);
//		scroller.setPreferredSize(new Dimension(30,30));//스크롤러의 크기를 지정한다.
		add(scroller);
		
		

		
		//돌아가기 버튼 생성
		JButton backButton = new JButton("이전페이지로 돌아가기");
		add(backButton);//버튼 리스너
		
		backButton.addActionListener(new GoMyPageListener());
		
		mf.add(this);
		
	}
	

	//돌아가기 버튼을 누르면 MyPage로 돌아가는 추가
	class GoMyPageListener implements ActionListener{
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new MyPage(mf,me));
			
		}
	}
	
	public void changePanel(JPanel panel) {
		mf.remove(this); // 현재 패널을 지우고
		mf.add(panel); // 다른 패널로 현재화면을 변경
		mf.revalidate();
		mf.repaint();
	}

}