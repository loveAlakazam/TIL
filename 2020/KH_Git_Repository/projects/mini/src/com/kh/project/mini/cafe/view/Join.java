package com.kh.project.mini.cafe.view;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Calendar;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import com.kh.project.mini.cafe.controller.MemberController;
import com.kh.project.mini.cafe.model.vo.Member;

public class Join extends JPanel {
	// 필드 //
	private MemberController mc = new MemberController();
	private MainFrame mf;
	private JTextField idText;
	private JPasswordField pwdText;
	private JTextField nameText;
	private JTextField addressText;

	JComboBox<Integer> birthYearBox;
	JComboBox<Integer> birthMonthBox;
	JComboBox<Integer> birthDayBox;

	// 생성자 //
	public Join(MainFrame mf) {
		System.out.println("회원가입 \n");
		this.mf = mf;
		mf.setTitle("커피깡 - 회원가입");
		setLayout(new GridLayout(0, 1));

		JLabel label1 = new JLabel("커피깡의 가족이 되어주세요!");
		label1.setHorizontalAlignment(JLabel.CENTER);
		add(label1);

		JLabel idLabel = new JLabel("ID");
		add(idLabel);
		idText = new JTextField(10);
		idText.setBounds(100, 10, 160, 25);
		add(idText);

		// 비밀번호 입력
		JLabel pwdLabel = new JLabel("PW");
		add(pwdLabel);
		pwdText = new JPasswordField(20);
		add(pwdText);

		// 이름입력
		JLabel nameLabel = new JLabel("이름");
		add(nameLabel);
		nameText = new JTextField(10);
		nameText.setBounds(100, 10, 160, 25);
		add(nameText);

		// 생일입력
		JPanel birthdayPanel = new JPanel();
		birthdayPanel.setLayout(new GridLayout(1, 6));

		birthdayPanel.add(new JLabel("년도", JLabel.RIGHT));


		// 년도 콤보박스-년도
		Calendar calendar = Calendar.getInstance(); // 캘린더
		int latestYear = calendar.get(Calendar.YEAR);
		int todayMonth = 1 + calendar.get(Calendar.MONTH);
		int todayDay = 1 + calendar.get(Calendar.DAY_OF_MONTH);
		int oldestYear = latestYear - 90;

		Integer[] birthYear = new Integer[91];
		for (int year = oldestYear; year <= latestYear; year++)
			birthYear[year - oldestYear] = year;

		birthYearBox = new JComboBox<Integer>(birthYear);
		birthYearBox.setSelectedItem(latestYear);
		birthdayPanel.add(birthYearBox);
		
	
		birthdayPanel.add(new JLabel("월", JLabel.RIGHT));
		// 년도콤보박스-월
		Integer[] birthMonth = new Integer[12];
		for (int month = 1; month <= 12; month++)
			birthMonth[month - 1] = month;
		birthMonthBox = new JComboBox<Integer>(birthMonth);
		birthMonthBox.setSelectedItem(todayMonth); // 현재 달로 미리선택 되는걸로..
		birthdayPanel.add(birthMonthBox);
		

		birthdayPanel.add(new JLabel("일", JLabel.RIGHT));
		// 년도콤보박스-일
		Integer[] birthDay = new Integer[31];
		for (int day = 1; day <= 31; day++) {
			birthDay[day - 1] = day;
		}
		birthDayBox = new JComboBox<Integer>(birthDay);
		birthDayBox.setSelectedItem(todayDay);
		birthdayPanel.add(birthDayBox);
		add(birthdayPanel);

//		JLabel birthdayLabel = new JLabel("생년월일(8자리)");
//		add(birthdayLabel);
//		birthdayText = new JTextField(10);
//		birthdayText.setBounds(100, 10, 160, 25);
//		add(birthdayText);

		// 주소입력
		JLabel addressLabel = new JLabel("주소");
		add(addressLabel);
		addressText = new JTextField(10);
		addressText.setBounds(100, 10, 160, 25);
		add(addressText);

		// 회원가입 버튼
		JButton joinButton = new JButton("회원가입");
		joinButton.setPreferredSize(new Dimension(45, 28));
		add(joinButton, "Center");
		add(joinButton);
		
		//돌아가기버튼생성 => MainView 창띄우기
		JButton button = new JButton("이전페이지로 돌아가기");
		add(button, "Center");
		button.addActionListener(new GoMainViewListener());

		// 버튼을 누르면 이벤트 리스너를 작동
		joinButton.addActionListener(new GoLoginAfterPageListener());
	}

	// 내부 클래스
	class GoLoginAfterPageListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {

			// 현재 가입되어있는 회원인지 확인한다.
			// MemberController를 이용.
			// 입력한 아이디값을 가져온다.
			String id = idText.getText();

			// 입력한 아이디가 최소 세글자 이상인가?
			boolean isAvailableID = (id.length() >= 3) ? true : false;
			if (!isAvailableID) {
				JOptionPane.showMessageDialog(null, "입력한 아이디가 너무짧습니다! 최소 3글자 이상으로 입력해주세요!", "회원가입 실패",
						JOptionPane.ERROR_MESSAGE);
			}
			//그렇다면 중복된 아이디인가?
			else if(mc.isDuplicatedMember(id)) {
				isAvailableID= false;
				JOptionPane.showMessageDialog(null, "입력한 아이디는 이미 존재하는 아이디입니다! 다시입력해주세요!", "회원가입 실패",
						JOptionPane.ERROR_MESSAGE);
			}
			

			// 비밀번호 pwdText.getPassword() => char형 배열
			// char형 배열 => String으로 변환
			String pwd = mc.getPassWordToText(pwdText.getPassword());
			// 입력한 비밀번호가 최소 3글자이상
			boolean isAvailablePWD = (pwd.length() >= 3) ? true : false;
			if (!isAvailablePWD) {
				JOptionPane.showMessageDialog(null, "입력한 비밀번호가 너무짧습니다! 최소 3글자 이상으로 입력해주세요!", "회원가입 실패",
						JOptionPane.ERROR_MESSAGE);
			}

			String name = nameText.getText();
			boolean isAvailableName = (name.length() >= 1) ? true : false;
			if (!isAvailableName) {
				JOptionPane.showMessageDialog(null, "입력한 이름이 너무짧습니다! 최소 1글자 이상으로 입력해주세요!", "회원가입 실패",
						JOptionPane.ERROR_MESSAGE);
			}

			// 입력한 생일
			int year = (Integer) birthYearBox.getSelectedItem();
			int month = (Integer) birthMonthBox.getSelectedItem();
			int day = (Integer) birthDayBox.getSelectedItem();
			String birthday = year + "/" + month + "/" + day;
			

			String address = addressText.getText();

			// 일단 새로운 객체 생성.
			Member newMember = new Member(pwd, name, birthday, address,id);
			if (isAvailableID && isAvailablePWD && isAvailableName) {
				// 회원가입하기.
				mc.joinMember(id, newMember);
				
				//맵을 업데이트 해야될듯..ㅋ
				
	
				JOptionPane.showMessageDialog(null, "커피깡에 오신걸 환영합니다! " + name + "님!", "회원가입 성공",
						JOptionPane.PLAIN_MESSAGE);
				
				// 회원가입이 다 되면 -> 로그인 이후의 화면으로 이동.
				changePanel(new LoginAfter(mf, id));
			}
		}
	}
	
	//돌아가기버튼을 누르면 MainView 창을 띄우는 내부클래스
	class GoMainViewListener implements ActionListener{
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new MainView(mf));
		}
	}

	// 메소드
	public void changePanel(JPanel panel) {
		mf.remove(this);
		mf.add(panel);
		mf.revalidate();
		mf.repaint();
	}

}
