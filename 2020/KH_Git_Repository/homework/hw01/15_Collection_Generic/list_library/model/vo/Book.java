package com.kh.practice.list.library.model.vo;

public class Book implements Comparable<Book>{
	private String title;
	private String author;
	private String category;
	private int price;
	
	// String객체배열
	
	
	public Book() {}
	public Book(String title, String author) {
		this.title=title;
		this.author=author;
	}
	
	public Book(String title, String author, String category, int price) {
		this(title, author);
		this.category=category;
		this.price=price;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title=title;
	}
	
	public String getAuthor() {
		return author;
	}
	
	public void setAuthor(String author) {
		this.author=author;
	}
	

	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category=category;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price=price;
	}
	
	@Override
	public String toString() {
		return "("+title+"/"+author+"/"+category+"/"+price+")";
	}
	
	@Override
	public int hashCode() {
		final int prime= 31;
		int result=1;
		result= prime*result+(title==null?0:title.hashCode());
		result= prime*result+(author==null?0:author.hashCode());
		return result;
	}

	
	@Override
	public boolean equals(Object obj) {
		if(this==obj)
			return true;
		
		if(obj==null) 
			return false;
		
		if(getClass()!=obj.getClass())
			return false;
		
		Book otherBook=(Book)obj;
		if(!title.equals(otherBook.title))
			return false;
		
		if(!author.equals(otherBook.author))
			return false;
		return true;
	}
	
	@Override
	public int compareTo(Book o) {
		//정렬기준이 title 필드 하나이므로, Comparable<Book>으로 했다.
		//String타입은 이미 정렬기준이 존재한다. implements Comparable<String>
		String otherBookName= o.getTitle();
		return title.compareTo(otherBookName);
	}
}
