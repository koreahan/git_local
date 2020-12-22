package com.koreait.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
//@AllArgsConstructor
public class HotelTests {
//	테스트 서버에서는 setter로 의존성 주입을 해주는 것이 일반적이다.
	@Setter(onMethod_ = {@Autowired})
	private SampleHotel hotel;
	
//	테스트 서버에서는 기본 생성자 한 개만 존재해야 한다.
//	public HotelTests() {;}
	
	@Test
	public void testExist() {
		assertNotNull(hotel);
		
		log.info(hotel);
		log.info("================");
		log.info(hotel.getChef());
	}
}




















