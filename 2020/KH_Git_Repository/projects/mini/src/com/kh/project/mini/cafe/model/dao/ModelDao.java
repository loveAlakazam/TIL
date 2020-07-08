package com.kh.project.mini.cafe.model.dao;

import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.Map.Entry;

import com.kh.project.mini.cafe.model.vo.Member;


// 객체 직렬화를 이용한다.
public class ModelDao {
	//등록된 멤버객체를 저장 하는 파일
	private String enrolledMembersFile="members.txt";
	
	// 파일에서 불러온 객체를 저장하는 리스트.
//	private List<Member> memberList = new ArrayList<Member>();
	private HashMap<String, Member> map;
	
	
	// 파일을 읽어온다. //
	// 파일에 저장한 객체를 불러와서 해시맵형태로 저장하고
	public HashMap<String, Member> fileOpen() {
		map = new HashMap<String, Member>();
		
		//객체 직렬화
		try(	//보조스트림을 만든다.
				ObjectInputStream ois= new ObjectInputStream(
				new FileInputStream(enrolledMembersFile));) 
		{
			
			Member nowMember;
			
			//파일에서 읽어온 멤버객체가 존재한다면 리스트에 추가.
			while((nowMember=(Member)ois.readObject())!=null) {
				System.out.println(nowMember);
				map.put( nowMember.getId(), nowMember );
				// key: nowMember의 id필드
				// value: Member객체
			}
			
			ois.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}catch(EOFException e) {
			//파일을 다읽었다~
		}catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	// 파일을 저장한다. //
	// Member 단위로 저장한다.
	public void fileSave(HashMap<String, Member> updatedMap) {
		try(	
				//기반스트림을 먼저 만든다.
				FileOutputStream fos =new FileOutputStream(enrolledMembersFile);
				
				//보조스트림을 만든다.
				ObjectOutputStream oos =new ObjectOutputStream(fos);)
		{
			//맵을 불러와서 전체 저장.
			for(Entry<String, Member> e : updatedMap.entrySet()) {
				// 엔트리의 value만 저장.
				// 어차피 value는 Member객체인데 , Member객체안에는 아이디필드가 있음.
				oos.writeObject(e.getValue());
			}
			
			oos.close();
			fos.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
