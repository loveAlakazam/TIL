package com.kh.project.mini.cafe.view;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import com.kh.project.mini.cafe.controller.MemberController;
import com.kh.project.mini.cafe.model.vo.Member;

public class LoginAgain extends JPanel {
	// 먼저 CafeView를 초기화 - 루트계정이라도 봐야함.
	private MemberController mc = new MemberController();
	private MainFrame mf;
	private JTextField idText;
	private JPasswordField pwdText;
	private String menuName;
	private int menuIdx;
	private String id;
	// 생성자
	// 로그인을 입력해야한다.
	public LoginAgain(MainFrame mf, String id, int menuIdx) {

//		//맵에 root가 존재하는지 확인
//		//해시맵
//		HashMap<String, Member> map=mc.enrolledMembers();
//		System.out.print("result: "+map.containsKey("root")  );
		mf.setTitle("커피깡 - 로그인");
		this.mf = mf; // 메인프레임 초기화

		this.id=id;
		this.menuIdx = menuIdx;


		// 로그인 화면의 레이아웃 지정.
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

		JButton submitButton = new JButton("로그인");
		submitButton.setPreferredSize(new Dimension(45, 28));
		add(submitButton, "Center");
		add(submitButton);

		// 로그인 버튼을 누를때 실행되는 이벤트 리스너
		// 입력한 아이디와 패스워드가, 등록된 아이디인지 확인한다.
		// 그다음에 MemberController의 해시맵에 등록된 아이디와 패스워드와 일치한지 확인.
		submitButton.addActionListener(new GoEditPage());

		// 현재 패널을 메인프레임 적용(화면변경)
		mf.add(this);
	}

	// 내부클래스 - 접근제한자 public안됨
	// submitButton과 연결할 버튼클릭 이벤트 리스너.
	class GoEditPage implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent e) {
			// yourID, yourPW에서 입력한 id와 비밀번호 텍스트를 불러오고
			String inputID = idText.getText();
			String inputPW = mc.getPassWordToText(pwdText.getPassword());

			// 입력한 아이디가 등록되어있지 않은 아이디라면
			if (!mc.isDuplicatedMember(inputID)) {
				// 에러메시지 Dialog를 보낸다.
				JOptionPane.showMessageDialog(null, "등록되어 있지 않은 아이디입니다!", "로그인 실패", JOptionPane.ERROR_MESSAGE);
			} else {

				// 입력한 아이디가 등록되어있는 아이디라면
				// 해시맵에 저장된 아이디와 패스워드와
				// 입력한 아이디와 패스워드가 일치한지 확인한다.
				Member me = mc.logIn(inputID, inputPW);
				if (me != null) {
					// 로그인 성공
					String userName = me.getName();

					// Dialog를 생성- 로그인 성공메시지
					JOptionPane.showMessageDialog(null, userName + "님 인증 성공 했습니다!", "로그인 성공",
							JOptionPane.PLAIN_MESSAGE);

					// menuIdx: 리스트에서 클릭한 메뉴의 인덱스번호
					// menuName: 마이페이지에서 선택한 메뉴이름
					System.out.println(menuIdx);
					System.out.println(menuName);
					
					//회원탈퇴일때만 동작.
					if (menuIdx == 4) {
						// 회원탈퇴
						// JDialog 를 불러와서 회원탈퇴를 할것인지를 확인.
						// 거기서 얻은 값에 따라서 탈퇴처리를 한다.
						int isQuit = JOptionPane.showConfirmDialog(null, "회원 탈퇴하시겠습니까?", "커피깡 - 회원탈퇴",
								JOptionPane.YES_NO_OPTION);
						if (isQuit == 0) {
							// 예
							Member dropOuted = mc.dropOutMember(inputID); // inputID를 갖는 회원을 탈퇴처리한다.
							// 탈퇴처리 완료
							String dropOutedName = dropOuted.getName();
							JOptionPane.showMessageDialog(null, dropOutedName + "님 회원탈퇴가 처리되었습니다.", "커피깡 - 회원탈퇴 (성공)",
									JOptionPane.PLAIN_MESSAGE);

							changePanel(new MainView(mf)); // 로그인 이전화면으로 돌아간다.
						} else {
							// 아니오.
							changePanel(new LoginAfter(mf, id));// 로그인 이후화면으로 돌아간다.
						}
					}

				} else {
					// 로그인 실패
					JOptionPane.showMessageDialog(null, "아이디 또는 비밀번호가 일치하지 않습니다!\n다시입력해주세요!", "로그인 실패",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		}
	}

	// 메소드 - 패널 변경
	public void changePanel(JPanel panel) {
		// 프레임의 현재패널을 제거
		mf.remove(this);
		mf.add(panel);

		mf.revalidate();
		mf.repaint();
	}
}
