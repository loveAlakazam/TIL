package guestBook.model.vo;

import java.sql.Date;


public class GuestBook {
	private int gid;
	private String name;
	private String content;
	private Date date;
	private java.util.Date uDate;
	
	public GuestBook() {}
	
	public GuestBook(int gid, String name, String content, Date date) {
		super();
		this.gid = gid;
		this.name = name;
		this.content = content;
		this.date = date;
	}

	public int getGid() {
		return gid;
	}

	public void setGid(int gid) {
		this.gid = gid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public java.util.Date getuDate() {
		return uDate;
	}

	public void setuDate(java.util.Date uDate) {
		this.uDate = uDate;
	}


	@Override
	public String toString() {
		return "GuestBook [gid=" + gid + ", name=" + name + ", content=" + content + ", date=" + date + "]";
	}
	
}
