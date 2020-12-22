package classificationOS;

public class SampleClassifyOS {
	private static String OS= System.getProperty("os.name").toLowerCase();
	public static boolean isWindows() {
		return (OS.indexOf("win")>=0);
	}
	
	public static boolean isMac() {
		return (OS.indexOf("mac")>=0);
	}
	
	public static void main(String[] args) {
		System.out.println(isWindows());
		System.out.println(isMac());
	}

}
