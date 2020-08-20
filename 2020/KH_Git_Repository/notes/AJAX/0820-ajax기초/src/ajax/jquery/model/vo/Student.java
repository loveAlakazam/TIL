package ajax.jquery.model.vo;

public class Student {
	private String name;
	public Student() {}
	public Student(String name) {
		this();
		this.name=name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "학생이름: "+name;
	}
}
