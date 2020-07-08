package com.kh.project.mini.cafe.view;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;

import com.kh.project.mini.cafe.controller.MemberController;
import com.kh.project.mini.cafe.model.vo.Member;
import com.kh.project.mini.cafe.view.MyPage.GoLoginAfterListener;

// 패스워드 변경 GUI
public class UpdatePassword extends JPanel {

	private MemberController mc = new MemberController();
	private MainFrame mf;
	private JPasswordField newPwd1;
	private JPasswordField newPwd2;
	private JLabel isEqualPwd;
	private String id;
	private Member me; // 현재 로그인한 멤버 객체를 의미.

	// 생성자.
	public UpdatePassword(MainFrame mf, String id, Member member) {
		System.out.println("패스워드 변경 창");
		// 로그인성공할때 아이디(HashMap- key)와
		// Member객체(HashMap- value)를
		// 매개변수로 한다.

		// 타이틀 변경
		mf.setTitle("비밀번호 변경");
		this.mf = mf;
		this.id = id;
		this.me = member;

		// 1. (북) 프레임에 타이틀 라벨을 넣는다.
		String name = member.getName();
		JLabel title = new JLabel(name + "님 비밀번호 변경 페이지입니다.");
		title.setHorizontalAlignment(JLabel.CENTER);
		this.add(title, "North");

		// 2. (중앙) 프레임에 그리드레이아웃인 패널을 넣는다.
		JPanel inputPwdPanel = new JPanel(new GridLayout(4, 0));// 4행1열 그리드 레이아웃
		this.add(inputPwdPanel,"Center");
		
		// inputPwdPanel(0행 0열): 새로운 비밀번호 입력
		JPanel pwdOnePanel = new JPanel();
		pwdOnePanel.add(new JLabel("새로운 암호 입력"));
		newPwd1 = new JPasswordField(10);
		pwdOnePanel.add(newPwd1);
		inputPwdPanel.add(pwdOnePanel);

		// inputPwdPanel(1행 0열): 새로운 비밀번호 한번더 입력
		JPanel pwdTwoPanel = new JPanel();
		pwdTwoPanel.add(new JLabel("한번 더 암호 입력"));
		newPwd2 = new JPasswordField(10);
		pwdTwoPanel.add(newPwd2);
		inputPwdPanel.add(pwdTwoPanel);

		// 새로운 비밀번호 입력/ 다시입력 이 서로 같은지 확인해주는 버튼
		JButton isEqualPwdButton = new JButton("비밀번호 확인");
		inputPwdPanel.add(isEqualPwdButton);

		// inputPwdPanel(3행 0열): newPwd1과 newPwd2가 서로 같은지확인 표시 라벨
		isEqualPwd = new JLabel();
		isEqualPwd.setHorizontalAlignment(JLabel.CENTER);
		inputPwdPanel.add(isEqualPwd);
		this.add(inputPwdPanel, "Center");

		// 버튼 리스너 - isEqualPwdButton의 버튼리스너
		// 입력한 비밀번호와 한번더 입력한 비밀번호가 같은지 확인해주는 버튼.
		isEqualPwdButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				// 비밀번호 텍스트 추출
				String newPwd = mc.getPassWordToText(newPwd1.getPassword());
				String newPwdAgain = mc.getPassWordToText(newPwd2.getPassword());

				if (newPwd.length() == 0 || newPwdAgain.length() == 0) {
					// 비밀번호가 하나라도 입력되지 않으면 -> isEqualPwd는 빈공백을 나타냄
					isEqualPwd.setText("모두 입력해주세요!");

				} else if (newPwd.equals(newPwdAgain)) {
					// 비밀번호가 일치하다면
					isEqualPwd.setText("모두일치합니다.");

				} else {
					// 비밀번호가 일치하지 않는다면
					isEqualPwd.setText("일치하지 않습니다! 다시 입력해주세요!");
				}
			}
		});

		JButton submitButton = new JButton("비밀번호 변경하기");
		add(submitButton, "Center");

		// submitButton - 버튼리스너 생성
		// 버튼리스너와 submitButton과 연결
		submitButton.addActionListener(new GoAfterLoginPanelListener());

		// 돌아가기버튼생성 => MyPage메뉴 창띄우기
		JButton backButton = new JButton("이전페이지로 돌아가기");
		add(backButton, "Center");
		backButton.addActionListener(new GoMyPageListener());

		// 메인프레임과 현재패널을 연결한다.
		mf.add(this);
	}

	// 돌아가기 버튼 누르면 MyPage로 넘어가기
	class GoMyPageListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new MyPage(mf, me));

		}
	}

	// submitButton을 누르면, 다이얼로그가 뜨는것과 동시에, 패널이 변경될 수 있기때문에
	// 익명클래스를 만들어서 이벤트 리스너를 만드는대신에
	// 내부클래스를 만들어서 submitButton의 버튼 액션 이벤트 리스너를 연결시킨다.
	class GoAfterLoginPanelListener implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent e) {
			// 비밀번호 텍스트 추출
			String newPwd = mc.getPassWordToText(newPwd1.getPassword());
			String newPwdAgain = mc.getPassWordToText(newPwd2.getPassword());

			if (newPwd.equals(newPwdAgain)) {// 비밀번호 모두 일치
				// 성공메시지
				JOptionPane.showMessageDialog(null, "비밀번호 변경 성공!", "커피깡 - 비밀번호 변경(성공)", JOptionPane.PLAIN_MESSAGE);

				// 비밀번호 수정
				mc.changePassword(id, newPwd);

				// 로그인 이후 페이지로 돌아간다.
				changePanel(new LoginAfter(mf, id));

			} else {
				// 비밀번호가 모두 일치 않는다 -> 에러메시지를 보낸다.
				JOptionPane.showMessageDialog(null, "비밀번호가 일치하지 않습니다!", "커피깡 - 비밀번호 변경(실패)", JOptionPane.ERROR_MESSAGE);
			}

		}

	}

	public void changePanel(JPanel panel) {
		mf.remove(this); // 현재 패널을 지우고
		mf.add(panel); // 다른 패널로 현재화면을 변경
		mf.revalidate();
		mf.repaint();
	}

}