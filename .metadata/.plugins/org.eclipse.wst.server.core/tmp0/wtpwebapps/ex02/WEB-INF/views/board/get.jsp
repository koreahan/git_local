<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Board</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link rel="stylesheet" href="/resources/assets/css/main.css" />
		<style>
			.reply{
				border-bottom: 1px solid #ff8b77;
			}
		</style>
	</head>
	<body class="is-preload">
		<!-- Main -->
			<div id="main">
				<div class="wrapper">
					<div class="inner">

						<!-- Elements -->
							<header class="major">
								<h1>Board</h1>
								<p>게시글 상세보기</p>
							</header>
									<!-- Table -->
										<h3><a href="/board/list${cri.getListLink()}" class="button small">목록 보기</a></h3>
						<div class="content">
							<div class="form">
								<form method="post" action="/board/remove">
									<input type="hidden" name="pageNum" value="${cri.pageNum}">
									<input type="hidden" name="amount" value="${cri.amount}">
									<input type="hidden" name="type" value="${cri.type}">
									<input type="hidden" name="keyword" value="${cri.keyword}">
									<div class="fields">
										<div class="field">
											<h4>번호</h4>
											<input name="bno" type="text" value="${board.bno}" readonly/>
										</div>
										<div class="field">
											<h4>제목</h4>
											<input name="title" type="text" value="${board.title}" readonly/>
										</div>
										<div class="field">
											<h4>내용</h4>
											<textarea name="content" rows="6" style="resize:none" readonly>${board.content}</textarea>
										</div>
										<div class="field">
											<h4>작성자</h4>
											<input name="writer" type="text" value="${board.writer}" readonly/>
										</div>
									</div>
									<ul class="actions special">
										<li>
											<input type="button" class="button" value="수정" onclick="location.href='/board/modify${cri.getListLink()}&bno=${board.bno}'"/>
											<input type="submit" class="button" value="삭제"/>
										</li>
									</ul>
									<ul class="icons">
										<li style="display:block">
											<span class="icon solid fa-envelope"></span>
											<strong>댓글</strong>
										</li>
									</ul>
									<a href="#" style="width:100%" class="button primary small register">댓글 등록</a>
									<div class="fields register-form" style="display:none">
										<div class="field">
											<h4>작성자</h4>
											<input name="replyer" placeholder="Replyer" type="text" />
										</div>
										<div class="field">
											<h4>댓글</h4>
											<textarea name="reply" rows="6" placeholder="Reply"
												style="resize: none"></textarea>
										</div>
										<div style="text-align:center" class="field regBtn">
											<a href="#" class="button primary small finish">등록</a>
											<a href="#" class="button primary small cancel">취소</a>
										</div>
									</div>
									<ul class="replies">
									</ul>
									<div class="big-width" style="text-align:center">
									</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div> 
		<!-- Scripts -->
			<script src="/resources/assets/js/jquery.min.js"></script>
			<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
			<script src="/resources/assets/js/browser.min.js"></script>
			<script src="/resources/assets/js/breakpoints.min.js"></script>
			<script src="/resources/assets/js/util.js"></script>
			<script src="/resources/assets/js/main.js"></script>
			<script src="/resources/assets/js/reply.js"></script>
			
			<script>
//				$(document).ready(function(){
//					console.log(replyService.name);
//				});

				$(".register").on("click", function(e){
					e.preventDefault();
					
					$(".register-form").show();
					$(this).hide();
				})
				
				$(".cancel").on("click", function(e){
					e.preventDefault();
					
					$(".register-form").hide();
					$(".register").show();
				})
				
				$(".finish").on("click", function(e){
					e.preventDefault();
					
					var bnoValue = "${board.bno}";
					var replyValue = $("textarea[name='reply']").val();
					var replyerValue = $("input[name='replyer']").val();
					
					replyService.add(
						{reply:replyValue, replyer:replyerValue, bno:bnoValue}, 
						function(result){ alert(result + " 등록 완료"); location.reload();});
				});
				
				$(document).ready(function(){
					var bnoValue = "${board.bno}";
					var replyUL = $(".replies");
					
					var pageNum = "${replyPageNum}" || 1;
					var replyPageFooter = $(".big-width");
					
					var str = "";
					
					showList(pageNum);
					
					function showReplyPage(replyCnt){
						var str = "";
						var endNum = Math.ceil(pageNum / 10.0) * 10;
						var startNum = endNum - 9;
						
						var realEnd = Math.ceil(replyCnt / 10.0);
						
						var prev = startNum != 1;
						var next = false;
						
						if(endNum * 10 >= replyCnt){
							endNum = realEnd;
						}
						
						if(endNum * 10 < replyCnt){
							next = true;
						}
						
						//JS 미디어 쿼리
						//페이지 이동 시 a태그의 class이름은 'changePage'로 설정한다.
						//각 a태그의 href에는 이동할 페이지번호만 작성해준다.
						if(matchMedia("screen and (max-width:918px)").matches){
							//918px보다 작거나 같을 때 들어온다.
							//현재 페이지만 나타내고, 이전과 다음으로 -1, +1씩 이동하도록 구현
							
							//이전
							if(pageNum > 1){
								str += "<a class='changePage' href='"+ (pageNum - 1) +"'><code>&lt;</code></a>";
							}
							//현재 페이지
							str += "<code>"+ pageNum +"</code>";
							//다음
							if(pageNum != realEnd){
								str += "<a class='changePage' href='"+ (pageNum + 1) +"'><code>&gt;</code></a>";
							}
							
						}else{
							//919px 이상일 때 들어온다.
							//현재 페이지를 제외한 다른 페이지는 a태그로 클릭 가능
							//10개씩 페이지를 구성한다(1~10, 11~21,...)
							
							//이전
							if(prev){
								str += "<a class='changePage' href='"+ (startNum - 1) +"'><code>&lt;</code></a>"
							}
							//현재 페이지(시작 페이지부터 끝 페이지까지)
							for(var i=startNum; i<= endNum; i++){
								if(pageNum == i){
									str += "<code>" + i + "</code>"
									continue;
								}
								str += "<a class='changePage' href='" + i + "'><code>" + i + "</code></a>"
							}
							//다음
							if(next){
								str += "<a class='changePage' href='"+ (endNum + 1) +"'><code>&gt;</code></a>"
							}
						}
						
						replyPageFooter.html(str);
						
						$(".changePage").on("click", function(e){
							e.preventDefault();
							
							var targetNum = $(this).attr("href");
							//pageNum에 사용자가 요청한 페이지로 최신화
							pageNum = parseInt(targetNum);
							
							showList(pageNum);
						});
					}
					
					function showList(page){
						var str = "";
						replyService.getList({bno : bnoValue, page : page || 1}, function(replyCnt, list){
							//댓글이 없으면 없다고 출력
							if(list == null || list.length == 0){
								//댓글이 없음
								replyUL.html("댓글이 없습니다");
								return;
							}
							
							//있으면 그 만큼 반복해서 html()로 뿌리기
							for(var i=0, len = list.length || 0; i < len; i++){
								str += "<li>";
								str += "<strong>" + list[i].replyer + "</strong>";
								str += "<p class='reply" + list[i].rno + "'>" + list[i].reply +"</p>";
								str += "<div style='text-align:right'>";
								str += "<strong>" + replyService.displayTime(list[i].replyDate) + "</strong>"
								str += "<br><a href='" + list[i].rno + "' class='modify'>수정</a>";
								str += "<a href='" + list[i].rno + "' class='finish' style='display:none'>수정 완료</a>";
								str += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
								str += "<a href='" + list[i].rno + "' class='remove'>삭제</a>";
								str += "</div>";
								str += "<div class='reply'></div>"
								str += "</li>";
							}
							
							replyUL.html(str);
							showReplyPage(replyCnt);
							
							$(".modify").on("click", function(e){
								e.preventDefault();
								
								var rnoValue = $(this).attr("href");
								var replyTag = $(".reply" + rnoValue);
								
								replyTag.html("<textarea class='" + rnoValue + "'>" + replyTag.text() + "</textarea>");
								$(this).hide();
								
								var finishs = $(".finish");
								for(var i=0; i<finishs.length; i++){
									if(finishs[i].getAttribute("href") == rnoValue){
										finishs[i].style.display = "inline";
										break;
									}
								}
							});
							
							$(".finish").on("click", function(e){
								e.preventDefault();
								
								//수정 후 새로고침
								var rnoValue = $(this).attr("href");
								
								replyService.update({rno : rnoValue, reply : $("." + rnoValue).val()}, function(result){
									if(result == "success"){
										alert("수정 완료");
										//showList(pageNum);
										location.replace("/board/get${cri.getListLink()}&replyPageNum=" + pageNum + "&bno=" + bnoValue);
									}
								});
								
							});
							
							$(".remove").on("click", function(e){
								e.preventDefault();
								
								replyService.remove($(this).attr("href"), function(result){
									if(result == "success"){
										alert("삭제 완료");
										location.reload();
									}
								})
							});
						});
					}
				});
				
				//댓글 목록 테스트
//				var bnoValue = "${board.bno}";
				
//				replyService.getList({bno : bnoValue, page : 1}, function(total, list){
//					console.log(total);
//					console.log(list);
//				})
//				var bnoValue = "${board.bno}";
//				replyService.update({rno:42, bno:bnoValue, reply:"수정된 댓글"}, function(result){alert(result + " MODIFIED")})
			</script>
	</body>
</html>






