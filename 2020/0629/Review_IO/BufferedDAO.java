package com.kh.example.chap03_assist.part01_buffer.model.dao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

//보조 스트림 클래스는 단독으로 객체 생성 (불가능) 하다.
// 반드시 (기반 스트림)에 대한 객체 래퍼런스가 필요하다
public class BufferDAO {
	
	public void output(String fileName) {
		//파일 저장하기 - 기본적이고 정석적인 방법
		BufferedWriter bw = null;

		try {
			// 저장 : OutputStream, Writer
			// 바이트단위 저장: OutputStream
			// 문자단위 저장 : Writer
			// 파일단위 저장 : FileWriter
			FileWriter fw = new FileWriter(fileName); // 저장.

			// (보조스트림) BufferedXXXX: 성능향상
			// BufferedInputStream
			// BufferedOutputStream
			// BufferedReader
			// BufferedWriter -문자단위로 텍스트를 저장한다.

			// 보조스트림 안에 기반스트림을 넣을 수있다 (보조스트림 안에 보조스트림을 넣어도된다)
			// The constructor BufferedWriter(기반스트림 FileWriter fw를 넣는다.)
			bw = new BufferedWriter(fw);
			
			//파일 쓰기
			bw.write("안녕하세요.\n");
			bw.write("반갑습니다.\n");
			bw.write("우리 힘내요!\n");
			
			
		} catch (IOException e) {

			e.printStackTrace();
		} finally {
			// BufferedWriter을 닫는다.
			try {
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void output2(String fileName) {
		//파일 저장하기 - (더 편한 방법)
		// try-with resource를 이용하여 - bw를 바로 닫을 수 있도록한다.
		try(FileWriter fw= new FileWriter(fileName);
				BufferedWriter bw= new BufferedWriter(fw);){
			bw.write("<strong>java io</strong>");
			bw.close();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	
	
	public void output3(String fileName) {
		//한번에 쓰기
		try(BufferedWriter bw= new BufferedWriter(new FileWriter(fileName));){
			
			bw.write("hello world!");
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	//읽어오기
	// 기반스트림=> InputStream/ Reader
	// 문자기반  => Reader
	// 파일을 읽어온다. => FileReader
	public void input(String fileName) {
		// 정석방법
		//		try {
		//			//기반스트림 - 파일을 읽어온다.
		//			FileReader fr= new FileReader(fileName);
		//			
		//			//보조스트림 생성
		//			BufferedReader br= new BufferedReader(fr);
		//		} catch (FileNotFoundException e) {
		//			e.printStackTrace();
		//		}
		
		//try-with resources 사용
		try (FileReader fr= new FileReader(fileName);
				BufferedReader br= new BufferedReader(fr);){
			
			// 한줄씩 읽어온다.
			// 파일의 끝에 도달하면 null을 반환
			String now; //현재파일에서 한줄씩 읽어온 문자열.
			while((now=br.readLine())!=null) {
				System.out.println(now);
			}
			
			
			/*
			 * A String containing the contents of the line, 
			 * not includingany line-termination characters, 
			 * or null if the end of the stream has been reached
			 * */
			
			
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
