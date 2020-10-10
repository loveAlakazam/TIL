package common;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class Template {

	
	public static SqlSession getSqlSession() {
		// SqlSession  <--------- SqlSessionFactory <---------- SqlSessionFactoryBuilder
		// 				openSession()				build(InputStream)
		
		//리턴 대상 session
		SqlSession session =null;
		
		// 1. SqlSessionFactoryBuilder 객체 생성
		SqlSessionFactoryBuilder ssfb= new SqlSessionFactoryBuilder();
		
		
		try {
			// 2. SqlSessionFactory 객체생성
			// mybatis-config.xml: mybatis전체설정 정보를 갖고있다.
			InputStream inputStream = Resources.getResourceAsStream("/mybatis-config.xml");
			SqlSessionFactory ssf= ssfb.build(inputStream);
			
			// 3. SqlSession 객체 생성.
			session=ssf.openSession();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return session;
	}
}
