package com.kh.project.mini.cafe.view;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import com.kh.project.mini.cafe.controller.MemberController;
import com.kh.project.mini.cafe.model.vo.Member;

public class LoginAfter extends JPanel {

	private MemberController mc = new MemberController();
	private MainFrame mf;
	private Member me;

	public LoginAfter(MainFrame mf, String id) {
		this.mf = mf;
		this.me = mc.getMemberFromID(id);
		
		System.out.println("me:"+ this.me);
		
		String name = me.getName();
		mf.setTitle(name + "님");
		setBounds(700, 300, 300, 400);

		setLayout(new GridLayout(5, 5, 20, 20));
		JLabel label = new JLabel(name + " 님 환영합니다");
		label.setHorizontalAlignment(JLabel.CENTER);
		add(label);

		JButton orderBtn = new JButton("주문하기");
		JButton userPageBtn = new JButton("마이페이지");
		JButton logoutbtn = new JButton("로그아웃");

		add(orderBtn, "Center");
		add(userPageBtn, "Center");
		add(logoutbtn, "Center");

		orderBtn.addActionListener(new GoOrderPageListener());
		userPageBtn.addActionListener(new GoUserPageListener());
		logoutbtn.addActionListener(new GoLogoutPageListener());

		mf.add(this);
	}

	// 주문하기 버튼 누르면 주문하기 페이지로 넘어가기
	class GoOrderPageListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new Order(mf, me));
		}
	}

	class GoUserPageListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new MyPage(mf, me));
		}
	}

	// 로그아웃 버튼 클릭시 이벤트 생성
	class GoLogoutPageListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			int result = JOptionPane.showConfirmDialog(null, "로그아웃 하시겠습니까?", "로그아웃", JOptionPane.YES_NO_OPTION);

			// 창 닫기, 예, 아니오 버튼 클릭시 이벤트 생성
			if (result == JOptionPane.CLOSED_OPTION) {
				System.exit(0);
			} else if (result == JOptionPane.YES_OPTION) {
				// Yes 버튼을 누르면 메인화면으로 돌아가기
				changePanel(new MainView(mf));
			}
		}
	}

	public void changePanel(JPanel panel) {
		mf.remove(this);
		mf.add(panel);
		mf.revalidate();
		mf.repaint();

	}

}
