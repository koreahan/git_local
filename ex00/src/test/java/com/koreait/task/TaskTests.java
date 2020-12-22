package com.koreait.task;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TaskTests {

	@Setter(onMethod_ = @Autowired)
	private Shop shop;
	
	@Test
	public void task() {
		assertNotNull(shop);
		
		log.info(shop);
		log.info("============");
		log.info(shop.getEmployee());
	}
}



















