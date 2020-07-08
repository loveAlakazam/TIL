package com.kh.project.mini.cafe.view;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import com.kh.project.mini.cafe.controller.MemberController;
import com.kh.project.mini.cafe.model.vo.Member;

public class Login extends JPanel {

	private MainFrame mf;
	private MemberController mc = new MemberController();

	private JTextField idText;
	private JPasswordField pwdText;

	public Login(MainFrame mf) {
		System.out.println("로그인 창");
		
		mf.setTitle("로그인");
		this.mf = mf; // 메인프레임 초기화
		mc.showEnrolledMember();

		// 로그인 화면의 레이아웃 지정.
//		setBounds(700,300,300,400);
		setLayout(new GridLayout(0, 1));

		JLabel label1 = new JLabel("아이디와 비밀번호를 입력해주세요.");
		add(label1);
		label1.setHorizontalAlignment(JLabel.CENTER);

		JLabel idLabel = new JLabel("ID");
		add(idLabel);

		idText = new JTextField(10);
		idText.setBounds(100, 10, 160, 25);
		add(idText);

		JLabel pwdLabel = new JLabel("PW");
		add(pwdLabel);

		pwdText = new JPasswordField(20);
		add(pwdText);

		JButton button1 = new JButton("로그인");
		button1.setPreferredSize(new Dimension(45, 28));
		add(button1, "Center");
		add(button1);

		button1.addActionListener(new GoLoginAfterListener());

		// 돌아가기버튼생성 => MainView 창띄우기
		JButton button = new JButton("이전페이지로 돌아가기");
		add(button, "Center");
		button.addActionListener(new MainViewListener());

		// 현재 패널을 메인프레임 적용(화면변경)
		mf.add(this);

	}

	// 로그인 버튼 누르면 LoginAfter로 넘어가기
	class GoLoginAfterListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			String inputID = idText.getText();
			String inputPW = mc.getPassWordToText(pwdText.getPassword());

			if (!mc.isDuplicatedMember(inputID)) {
				// 등록되어있지 않은 아이디입력
				JOptionPane.showMessageDialog(null, "잘못된 계정입니다.", "로그인 실패", JOptionPane.ERROR_MESSAGE);
			} else {
				// 아이디 비밀번호 에 대응하는 멤버를 구한다.
				// 여기부분 수정.
				Member me = mc.logIn(inputID, inputPW);

				if (me != null) {
					// 로그인 성공 다이얼로그 띄운다.
					String userName = me.getName();
					JOptionPane.showMessageDialog(null, userName + "님 반갑습니다!", "로그인 성공", JOptionPane.PLAIN_MESSAGE);

					// 로그인 이후의 페이지로 이동.
					changePanel(new LoginAfter(mf, inputID));
				} else {
					// 로그인 실패 다이얼로그 띄운다.
					JOptionPane.showMessageDialog(null, "아이디 또는 비밀번호가 일치하지 않습니다!\n다시입력해주세요!", "로그인 실패",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		}
	}

	// 돌아가기 버튼 누르면 MainView 로 넘어가기
	class MainViewListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new MainView(mf));
		}
	}

	public void changePanel(JPanel panel) {
		mf.remove(this);
		mf.add(panel);
		mf.revalidate();
		mf.repaint();

	}
}