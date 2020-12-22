package com.koreait.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.domain.BoardVO;
import com.koreait.domain.Criteria;
import com.koreait.domain.PageDTO;
import com.koreait.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {
	
	//DI 의존성 주입
	//div_a가 수정함
	private BoardService service;
	//div_a가 작업함
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list");
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
	}
	
	//register GET방식 컨트롤러 작성
	@GetMapping("/register")
	public void register(@ModelAttribute("cri") Criteria cri, Model model) {}
	
	//1. 어떻게 redirect로 전송할 것인가(default는 forward)
	//2. 어떻게 redirect로 데이터를 응답페이지로 전달할 것인가?
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register : " + board);
		//등록하기 수정
		log.info("commit test");
		service.register(board);
		
		//Redirect로 전송할 때에는 데이터가 유실되기 때문에
		//Session의 flash부분에 값을 저장해 놓은 후
		//새로운 페이지가 시작될 때 Model 전달자에게 저장시켜준다.
		//저장된 후 이전의 데이터는 소멸된다.
		rttr.addFlashAttribute("result", board.getBno());
		
//		model.addAttribute("result", board.getBno());
		
		//'redirect' 접두어를 사용하면 스프링 MVC가 내부적으로
		//response.sendRedirect()를 처리해준다.
		return "redirect:/board/list";
	}
	
	//조회 처리와 테스트
	//데이터 전달자에는 전달받은 bno에 대한 게시글 정보를 담아준다.
	@GetMapping({"/get", "/modify"})
	//@RequestParam을 사용하지 않아도 되지만 명시적으로 지정하여 발생할 수 있는 예외를 막아준다.
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, @RequestParam("replyPageNum") Long replyPageNum, Model model) {
		log.info("/get");
		model.addAttribute("replyPageNum", replyPageNum);
		model.addAttribute("board", service.get(bno));
	}
	
	//수정 성공시 result라는 KEY에 success를 넣어 결과 페이지로 전달
	//Post방식
	//redirect 전송
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		log.info("modify: " + board);
		
		if(service.modify(board)) {
			//리다이렉트 이후에도 Model 객체에 담겨 있다(Session, Flash 사용)
			rttr.addFlashAttribute("result", "success");
		}
		//리다이렉트 이후에도 URL에 남아있다(GET방식 이용)
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list" + cri.getListLink();
	}
	
	//삭제 처리
	//Post방식
	//게시판 번호 받기
	//서비스에 있는 적절한 메소드 호출
	//FlashAttribute 사용
	//성공 시 result에 success담아서 view로 전달
	//redirect:
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {
		log.info("remove : " + bno);
		
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list" + cri.getListLink();
	}
}