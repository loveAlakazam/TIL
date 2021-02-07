package com.exam.boostcourse.practice.mvcexam.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

//설정파일.
@Configuration
@EnableWebMvc
@ComponentScan(basePackages= {"com.exam.boostcourse.practice.mvcexam.controller" })
public class WebMvcContextConfiguration extends WebMvcConfigurerAdapter {
	
	// 모든 요청이 들어왔을 때 서블릿을 실행.
	// 컨트롤러에서 URL 매핑된 요청뿐만아니라, 정적파일들도 요청할 수 있다.
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/assets/**").addResourceLocations("classpath:/META-INF/resources/webjars/").setCachePeriod(31556926);
        registry.addResourceHandler("/css/**").addResourceLocations("/css/").setCachePeriod(31556926);
        registry.addResourceHandler("/img/**").addResourceLocations("/img/").setCachePeriod(31556926);
        registry.addResourceHandler("/js/**").addResourceLocations("/js/").setCachePeriod(31556926);
	
        //예:  /js/** (js파일) 을 요청할 경우에는 /js/ 에서 찾아요.
        //예: /css/** (css파일) 을 요청할 경우에는 /css/ 에서 찾아요.
	}
	
	//default servlet 핸들러를 사용하도록 한다.
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable(); //DefaultServletHandler를 사용하도록함. 
		// 매핑정보가 없는 url DefaultServletHttpRequestHandler가 처리한다. 
		// DefaultServletHttpRequestHandler는 WAS의 DefaultServlet에게 요청을 넘긴다.
		// WAS는 DefaulServlet이 static한 자원을 읽어서 보여주게한다.
	}
	
	
	// 특정 url에 대한 처리를 controller클래스를 작성하지 않고 매핑할 수 있도록함.
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		System.out.println("addViewControllers가 호출된다.");
		registry.addViewController("/").setViewName("main"); 
		// url /을 요청했을 때 main 이름의 뷰를 불러온다.
		//뷰이름을 알고있는 상태. ViewResolver을 통해서 해당이름의 뷰화면을 리턴하여 응답페이지로 랜더링.
	
	}
	
	@Bean
	public InternalResourceViewResolver getInternalResourceViewResolver() {
		InternalResourceViewResolver resolver= new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/"); //리턴할 뷰의 저장경로
		resolver.setSuffix(".jsp");	//리턴할 뷰의 확장자
		return resolver; // 뷰이름에 해당하는 뷰를 불러옴으로써 응답뷰로 클라이언트한테 보냄.
	}
}
