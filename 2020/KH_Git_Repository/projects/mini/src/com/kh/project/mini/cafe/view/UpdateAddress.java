// 참고 url: https://stackoverrun.com/ko/q/2881288
package com.kh.project.mini.cafe.view;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Hashtable;

import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

import com.kh.project.mini.cafe.controller.MemberController;
import com.kh.project.mini.cafe.model.vo.Member;

//주소변경 GUI
public class UpdateAddress extends JPanel {
	// 필드//
	private MainFrame mf;
	private Member me;
	private String id;
	
	private String inputMcity; //입력  정보
	private String inputCity;  //입력 구/군 
	private String inputDetailAddr; //입력 상세주소
	private MemberController mc= new MemberController();

	// 메인 콤보 박스//
	private JComboBox mcityOption; // 메인콤보박스 - 아무것도 없음.
	private final String mcities[] = { "서울특별시", // 0
			"부산광역시", // 1
			"대구광역시", // 2
			"인천광역시", // 3
			"광주광역시", // 4
			"대전광역시", // 5
			"울산광역시", // 6
			"세종특별자치시", // 7
			"경기도", // 8
			"강원도", // 9
			"충청북도", // 10
			"충청남도", // 11
			"전라북도", // 12
			"전라남도", // 13
			"경상북도", // 14
			"경상남도", // 15
			"제주특별자치도", // 16
			"시 선택" // 17
	};

	// 서브 콤보 박스//
	// 해시테이블을 이용.
	private JComboBox cityOption; // 서브콤보박스 - 아무것도 없음.
	private Hashtable<Object, Object> cityOptionTable = new Hashtable<Object, Object>();

	//상세주소//
	private JTextField detailedAddress;
	
	
	// 생성자 //
	// id: LoginAgain에서 입력한 사용자의 아이디
	// me: id에 일치한 해시맵의 value(멤버 정보)
	// mf: 메인프레임
	public UpdateAddress(MainFrame mf, String id, Member me) {
		System.out.println("주소 변경 창");
		
		this.mf = mf;
		mf.setTitle("커피깡 - 주소변경");
		this.id = id;
		
		this.me = me;

		System.out.println("[주소변경] id: "+ id+ " me:"+ this.me);
		
		// BorderLayout으로 한다.
		// 타이틀 라벨 (북)
		JLabel title = new JLabel("주소 변경");
		title.setHorizontalAlignment(JLabel.CENTER); // 가운데정렬
		add(title, "North");

		//안내문구
		JPanel resultPanel = new JPanel();
		JLabel cityList = new JLabel("시를 선택하면 자동으로 구/군이 나옵니다.");
		resultPanel.add(cityList);
		add(resultPanel, "Center");
		
		// 주소 변경 입력란(중앙)
		JPanel changeAddressPanel = new JPanel();
		changeAddressPanel.setLayout(new GridLayout(4, 1));

		// 1. 시 입력
		JPanel inputMcityPanel = new JPanel();
		JLabel mcityLabel = new JLabel("도시");
		inputMcityPanel.add(mcityLabel);

		// 메인콤보 박스를 만든다.
		mcityOption = new JComboBox(mcities);
		inputMcityPanel.add(mcityOption); // inputMcityPanel에 mcityOption 컴포넌트를 넣는다..
		mcityOption.setSelectedIndex(17);
		changeAddressPanel.add(inputMcityPanel);

		// 2. 구/군 - SubComboBox
		JPanel inputCityPanel = new JPanel();
		JLabel cityLabel = new JLabel("구/군");
		inputCityPanel.add(cityLabel);
		
		// 0. 서울특별시
		String [] subItem0={ "구/군 선택", "종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구",
						"양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구", "강동구" };

		// 1. 부산광역시
		String[]subItem1={ "구/군 선택", "중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "해운대구", "사하구", "금정구", "강서구", "연제구", "수영구", "사상구",
				"기장군" };

		// 2. 대구 광역시
		String[] subItem2={ "구/군 선택", "중구", "동구", "서구", "남구", "북구", "수성구", "달서구", "달성군" };
		
		//3.인천광역시
		String[] subItem3={ "구/군 선택", "중구", "동구", "남구", "연수구", "남동구", "부평구", "계양구", "서구", "강화군", "옹진군", "미추홀구" };
		
		//4. 광주광역시
		String[] subItem4={ "구/군 선택", "동구", "서구", "남구", "북구", "광산구" };
		
		//5. 대전광역시
		String[] subItem5={ "구/군 선택", "동구", "중구", "서구", "유성구", "대덕구" };
		
		//6. 울산광역시
		String[] subItem6={ "구/군 선택", "중구", "남구", "동구", "북구", "울주군" };

		//7. 세종특별자치시 - 없음 ㅠㅠ
		String[] subItem7={ "구/군 선택" };

		//8. 경기도
		String[] subItem8={ "시/구/군 선택", "수원시", "성남시", "의정부시", "안양시", "부천시", "광명시", "평택시", "동두천시", "안산시", "고양시", "과천시", "구리시", "남양주시", "오산시",
				"시흥시", "군포시", "의왕시", "하남시", "용인시", "파주시", "이천시", "안성시", "김포시", "화성시", "광주시", "양주시", "포천시",
				"여주시", "여주군", "연천군", "가평군", "양평군" };

		//9. 강원도
		String[] subItem9={ "시/구/군 선택", "춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군", "평창군", "정선군", "철원군", "화천군",
				"양구군", "인제군", "고성군", "양양군" };

		//10. 충청북도
		String[] subItem10={"시/구/군 선택", "청주시", "충주시", "제천시", "청원군", "보은군", "옥천군", "영동군",
					"진천군", "괴산군", "음성군", "단양군", "증평군" };

		//11. 충청남도
		String[] subItem11={ "시/구/군 선택", "천안시", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "연기군", "부여군", "서천군", "청양군", "홍성군",
				"예산군", "태안군", "당진군" };

		//12. 전라북도
		String[] subItem12={ "시/구/군 선택", "전주시", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", 
					"진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군" };

		//13. 전라남도
		String[] subItem13={ "시/구/군 선택", "목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군",
				"영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군" };

		//14. 경상북도
		String[] subItem14={ "시/구/군 선택", "포항시", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "군위군", "의성군", "청송군", "영양군",
				"영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군" };

		//15. 경상남도
		String[] subItem15={ "시/구/군 선택", "창원시", "마산시", "진주시", "진해시", "통영시", "사천시", "김해시", "밀양시", "거제시", "양산시", "의령군", "함안군", "창녕군", "고성군",
				"남해군", "하동군", "산청군", "함양군", "거창군", "합천군" };

		//16. 제주도
		String[] subItem16={ "시/구/군 선택", "제주시", "서귀포시" };
		


		// 서브콤보박스를 만든다.
		cityOption = new JComboBox();

		// 해시테이블에 넣는다.
		// 해시테이블 - key값: String / value값: String[] 배열
		cityOptionTable.put(mcities[0], subItem0);//0. 서울특별시
		cityOptionTable.put(mcities[1], subItem1);// 1. 부산광역시
		cityOptionTable.put(mcities[2], subItem2);// 2. 대구 광역시
		cityOptionTable.put(mcities[3], subItem3);//3.인천광역시
		cityOptionTable.put(mcities[4], subItem4);//4. 광주광역시
		cityOptionTable.put(mcities[5], subItem5);//5. 대전광역시
		cityOptionTable.put(mcities[6], subItem6);//6. 울산광역시
//		cityOptionTable.put(mcities[7], subItem7);//7. 세종특별자치시
		cityOptionTable.put(mcities[8], subItem8);//8. 경기도
		cityOptionTable.put(mcities[9], subItem9);//9. 강원도
		cityOptionTable.put(mcities[10], subItem10);//10. 충청북도
		cityOptionTable.put(mcities[11], subItem11);//11. 충청남도
		cityOptionTable.put(mcities[12], subItem12);//12. 전라북도
		cityOptionTable.put(mcities[13], subItem13);//13. 전라남도
		cityOptionTable.put(mcities[14], subItem14);//14. 경상북도
		cityOptionTable.put(mcities[15], subItem15);//15. 경상남도
		cityOptionTable.put(mcities[16], subItem16);//16. 제주도
		


		inputCityPanel.add(cityOption, "South"); // cityOption컴포넌트를 inputCityPanel에 넣는다.
		changeAddressPanel.add(inputCityPanel);

		// 3. 상세주소 입력
		JLabel detailedAddressLabel = new JLabel("상세 주소");
		detailedAddressLabel.setHorizontalAlignment(JLabel.CENTER);
		changeAddressPanel.add(detailedAddressLabel);

		// JTextField 컴포넌트
		detailedAddress = new JTextField(25);
		changeAddressPanel.add(detailedAddress);
		add(changeAddressPanel, "Center"); // 현재패널에 콤보박스 컴포넌트패널을 넣는다.

		// (남)
		JButton submitButton = new JButton("주소 변경하기");
		submitButton.addActionListener(new GoUpdateAddressListener());
		add(submitButton, "Center");
		mf.add(this); // 프레임에 현재패널을 적용

		//MyPage로 돌아가는 버튼
		JButton BackButton = new JButton("이전페이지로 돌아가기");
		BackButton.addActionListener(new GoMyPageListener());
		add(BackButton,"Center");
		mf.add(this);
		
		
		// 행정자치 (시) 선택할때 -> 구/군 콤보박스 내용이 달라짐.
		mcityOption.addActionListener(new ActionListener() {
			// 시를 선택하면, 행정자치시에 속하는 구를 cityOption에 나타낸다.

			@Override
			public void actionPerformed(ActionEvent e) {
				// 시 선택(키값)
				String mcity = (String) mcityOption.getSelectedItem();
				
				//해시테이블cityOptionTable 에서 키값을 뽑는다.
				Object o = cityOptionTable.get(mcity);
				
				if(o==null) {
					cityOption.setModel(new DefaultComboBoxModel());
				}else {
					cityOption.setModel(new DefaultComboBoxModel((String[])o));
				}
			}
		});
	}

	// submitButton 버튼을 누르면 실행
	// 3개의 입력란이 모두 입력된 상태라면?
	class GoUpdateAddressListener implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			inputMcity=(String) mcityOption.getSelectedItem();
			int mcityIdx= mcityOption.getSelectedIndex(); //17번빼고 오케이~
			
			inputCity= (String) cityOption.getSelectedItem();
			int cityIdx= cityOption.getSelectedIndex(); //0번빼고 오케이~
			
			System.out.println("시: "+inputMcity);
			System.out.println("구/군: "+inputCity);
			System.out.println("cityIdx: "+ cityIdx);
			
			
			if(inputCity==null || cityIdx==0)
				inputCity="";
			
			inputDetailAddr  =detailedAddress.getText();
			System.out.println("상세주소: "+ inputDetailAddr);
			
			
			if(mcityIdx==17 || inputDetailAddr.length()==0) {
				JOptionPane.showMessageDialog(null, "주소를 선택하시고, 상세주소를 기입해주세요!", "주소 변경 실패", JOptionPane.ERROR_MESSAGE);
				
			}else {
				//주소 변경
				String newAddr=inputMcity+" "+inputCity+" "+ inputDetailAddr;
				System.out.println("변경주소: "+ newAddr);
				System.out.println("id: "+ id);
				mc.changeAddress(id, newAddr); //<= 여기서 Null Pointer Exception발생 
				JOptionPane.showMessageDialog(null, "주소변경을 성공했습니다.", "주소 변경 성공", JOptionPane.PLAIN_MESSAGE);
				changePanel(new LoginAfter(mf, id));
			}
		}
	}
	
	
	//MyPage로 돌아가는 버튼액션추가
	class  GoMyPageListener implements ActionListener{
		@Override
		public void actionPerformed(ActionEvent e) {
			changePanel(new MyPage(mf,me));
		}
	}	

	
	// 패널 변경 - 주소 변경이 성공적으로 이뤄지면 LoginAfter페이지로 이동
	public void changePanel(JPanel panel) {
		mf.remove(this); // 현재 패널을 지우고
		mf.add(panel);// 새로운 패널로 바꾼다.

		mf.revalidate();
		mf.repaint();
	}
}
