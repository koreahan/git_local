package com.koreait.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.koreait.domain.BoardVO;
import com.koreait.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Setter(onMethod_ = @Autowired)
	private BoardService service;

	@Test
	public void testGetTotal() {
		log.info("TOTAL COUNT : " + service.getTotal(new Criteria(1, 10)));
	}
	
//	@Test
//	public void testRemove() {
//		Long bno = 1L;
//		BoardVO board = service.get(bno);
//		
//		if(board == null) {
//			return;
//		}
//		
//		log.info("REMOVE RESULT : " + service.remove(bno));
//	}
	
//	@Test
//	public void testModify() {
//		BoardVO board = service.get(1L);
////		assertNotNull(board);
//		if(board == null) {
//			return;
//		}
//		board.setTitle("제목 수정합니다.");
//		log.info("MODIFY RESULT : " + service.modify(board));
//	}
	
//	@Test
//	public void testGet() {
//		log.info(service.get(1L));
//	}
	
//	@Test
//	public void testGetList() {
////		Collection.forEach(선언부 -> 사용부);
//		service.getList().forEach(board -> log.info(board));
//	}
//	@Test
//	public void testGetList() {
////		Collection.forEach(선언부 -> 사용부);
//		service.getList(new Criteria(2, 10)).forEach(board -> log.info(board));
//	}
	
//	@Test
//	public void testRegister() {
//		BoardVO board= new BoardVO();
//		board.setTitle("새로 작성하는 글5");
//		board.setContent("새로 작성하는 내용5");
//		board.setWriter("hds1204");
//		
//		service.register(board);
//		
//		log.info("생성된 게시물의 번호 : " + board.getBno());
//	}
	
//	@Test
//	public void testExist() {
//		assertNotNull(service);
//		log.info("SERVICE : " + service);
//	}
}
















