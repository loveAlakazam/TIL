package kr.com.ek.practice.course.boost.projectA.card.model.vo;

public class Card {
	private int cardNo;
	private String name;
	private String tel;
	private String compayName;
	
	public Card() {}

	public Card(String name, String tel, String compayName) {
		super();
		this.name = name;
		this.tel = tel;
		this.compayName = compayName;
	}
	
	public Card(int cardNo, String name, String tel, String compayName) {
		super();
		this.cardNo=cardNo;
		this.name = name;
		this.tel = tel;
		this.compayName = compayName;
	}

	public int getCardNo() {
		return cardNo;
	}

	public void setCardNo(int cardNo) {
		this.cardNo = cardNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCompayName() {
		return compayName;
	}

	public void setCompayName(String compayName) {
		this.compayName = compayName;
	}

	@Override
	public String toString() {
		return "Card [cardNo=" + cardNo + ", name=" + name + ", tel=" + tel + ", compayName=" + compayName + "]";
	}
	

}
