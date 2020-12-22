package collectionPractice;

import java.util.ArrayList;

public class SplitString {
	public static void main(String[] args) {
		String sample="abra, kadabra, alakazam";
		String splitedStrs[]=sample.split(", ");
		
		ArrayList<String> pokemonNameLists= new ArrayList<String>();
		for(String str: splitedStrs) {
			pokemonNameLists.add(str);
			System.out.println("str=> "+str);
		}
		
		for(String name:pokemonNameLists) {
			System.out.println(name);
		}
	}
}
