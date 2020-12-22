package com.koreait.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.koreait.domain.Criteria;
import com.koreait.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//SpringRunner는 SpringJUnit4ClassRunner의 자식이며 4.3버전 이상부터 사용 가능한 확장판이다.
@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
//	@Test
//	public void testMapper() {
//		log.info(mapper);
//	}
	private Long[] arBno = {499750L, 499749L, 499748L, 499747L, 499746L,};
	
//	@Test
//	public void testInsert() {
//		//5개의 최신 게시글에 2개씩 댓글 달기
//		//IntStream
//		IntStream.rangeClosed(1, 10).forEach(i ->{
//			ReplyVO reply = new ReplyVO();
//			
//			//12340 12340
//			reply.setBno(arBno[i % 5]);
//			reply.setReply("댓글 테스트" + i);
//			reply.setReplyer("replyer" + i);
//			
//			mapper.insert(reply);
//		});
//	}
	
//	@Test
//	public void testRead() {
//		log.info(mapper.read(10L));
//	}
	
//	@Test
//	public void testDelete() {
//		Long targetRno = 1L;
//		log.info(mapper.delete(targetRno));
//	}
	
//	@Test
//	public void testUpdate() {
//		Long targetRno = 10L;
//		
//		ReplyVO reply = mapper.read(targetRno);
//		
//		reply.setReply("Update Reply");
//
//		int count = mapper.update(reply);
//		log.info("UPDATE COUNT : " + count);
//	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, arBno[1]);
		replies.forEach(reply -> log.info(reply));
	}
}












