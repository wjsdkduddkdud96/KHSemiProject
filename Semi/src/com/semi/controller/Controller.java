package com.semi.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.service.BoardService;
import com.semi.service.BookService;
import com.semi.service.InfoService;
import com.semi.service.PlaceService;
import com.semi.service.QaService;
import com.semi.service.ReviewService;


//

@WebServlet({"/pwChk", "/emailOverlay", "/numOverlay", "/id", "/pw", "/bookInfo", "/userInfo", "/del","/overlay", "/login", "/logout", "/userJoin", "/regJoin", "/userUpdate", "/regUpdate", "/regChange", "/userDel",
	"/userList", "/likeList", "/infoPlaceList", "/bookList", "/total", "/totalDetail", "/userSearch",
	"/placeWrite", "/placeList", "/placeUpdate", "/placeDel","/placephotoDetail", "/placeDetail", "/placeDetailUp", "/like", "/likeDel","/detaillikedel","/detaillike",
	"/placeSearch", "/boardWrite", "/boardUpdate", "/boardDel", "/boardDetail", "/boardDetailView","/boardList", "/boardSearch","/noticeDetailView","/noticeDel",
	"/boardReplyWrite", "/boardReplyUdate", "/boardReplyDel", "/boardReplyList", "/bookWrite", "/bookDel",
	"/qaWrite", "/qaDel", "/qaUpdate", "/qaList", "/qaReplyWrite", "/qaReplyUpdate", "/qaReplyList", "/qaReplyDel", "/qaSearch", "/qaDetail", "/qaUpdateForm", "/qaWriteForm", "/qaListSize",
	"/reviewWrite", "/reviewDel", "/reviewUpdate", "/reviewList","/placeUpdatedetail","/placeUpdateWrite"
})
//
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dual(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dual(request, response);
	}
	private void dual(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		String uri = request.getRequestURI();
		String context = request.getContextPath();
		String subAddr = uri.substring(context.length());
		System.out.println(subAddr);
		
		InfoService infoService = null;
		PlaceService placeService = null;
		BoardService boardService = null;
		BookService bookService = null;
		QaService qaService = null;
		ReviewService reviewService = null;
		switch (subAddr) {
			case "/pwChk":
				System.out.println("현재 비밀번호 확인 요청");
				infoService = new InfoService();
				infoService.pwChk(request, response);
			break;
			case "/id":
				System.out.println("아이디 찾기 요청");
				infoService = new InfoService();
				infoService.id(request, response);
				break;
			case "/pw":
				System.out.println("비밀번호 찾기 요청");
				infoService = new InfoService();
				infoService.pw(request, response);
				break;
			case "/overlay":
				System.out.println("중복체크 요청");
				infoService = new InfoService();
				infoService.overlay(request, response);
				break;
			case "/numOverlay":
				System.out.println("주민등록번호 중복체크 요청");
				infoService = new InfoService();
				infoService.numOverlay(request, response);
				break;
			case "/login":
				System.out.println("로그인 요청");
				infoService = new InfoService();
				infoService.login(request, response);
				break;
			case "/logout":
				System.out.println("로그아웃 요청");
				infoService = new InfoService();
				infoService.logout(request, response);
				break;	
			case "/userJoin":
				System.out.println("사용자 회원가입 요청");
				infoService = new InfoService();
				infoService.userJoin(request, response);
				break;
			case "/placeWrite":
				System.out.println("장소 등록 요청");
				placeService = new PlaceService();
				placeService.Write(request,response);
				break;
			case "/regJoin":
				System.out.println("등록자 회원가입 요청");
				infoService = new InfoService();
				infoService.regJoin(request, response);
				break;	
			case "/userUpdate":
				System.out.println("사용자 정보수정 요청");
				infoService = new InfoService();
				infoService.userUpdate(request, response);
				break;
			case "/regUpdate":
				System.out.println("등록자 정보수정 요청");
				infoService = new InfoService();
				infoService.regUpdate(request, response);
				break;
			case "/regChange":
				System.out.println("등록자 전환 요청");
				infoService = new InfoService();
				infoService.regChange(request, response);
				break;
			case "/userInfo":
				System.out.println("회원 정보 요청");
				infoService = new InfoService();
				infoService.userInfo(request, response);
				break;
			case "/userList":
				System.out.println("회원 리스트, 검색 요청");
				infoService = new InfoService();
				infoService.userList(request, response);
				break;
			case "/userDel":
				System.out.println("회원 삭제 요청");
				infoService = new InfoService();
				infoService.userDel(request, response);
				break;
			case "/del":
				System.out.println("회원탈퇴 요청");
				infoService = new InfoService();
				infoService.del(request, response);
				break;
			case "/placeSearch":
				System.out.println("장소 검색");
				placeService=new PlaceService();
				placeService.search(request, response);
				break;
			case "/bookList":
				System.out.println("예약 리스트 요청");
				infoService = new InfoService();
				infoService.bookList(request, response);
				break;
			case "/bookInfo":
				System.out.println("예약 정보 요청");
				bookService = new BookService();
				bookService.bookInfo(request, response);
				break;
			case "/bookWrite":
				System.out.println("예약하기 요청");
				bookService = new BookService();
				bookService.bookWrite(request, response);
				break;
			case "/bookDel":
				System.out.println("예약 삭제 요청");
				bookService = new BookService();
				bookService.delete(request, response);
				break;
			case "/placephotoDetail":
				System.out.println("포토상세보기 요청");
				System.out.println(request.getParameter("place_no"));
				placeService=new PlaceService();
				placeService.detailphoto(request,response);
				break;
			case "/boardWrite":
				System.out.println("boardWrite");
				boardService = new BoardService();
				boardService.write(request, response);
				break;
			case "/boardUpdate":
				System.out.println("boardUpdate");
				boardService = new BoardService();
				boardService.update(request,response);
				break;
			case "/boardDel":
				System.out.println("boardDel");
				boardService = new BoardService();
				boardService.delete(request,response);
				break;
			case "/noticeDel":
				System.out.println("noticeDel");
				boardService = new BoardService();
				boardService.noticeDel(request,response);
				break;
			case "/boardDetail":
				System.out.println("boardDetail");
				boardService = new BoardService();
				boardService.detail(request, response);
				break;
			case "/boardDetailView":
				System.out.println("boardDetailView");
				request.getSession().setAttribute("board_no", request.getParameter("board_no"));
				response.sendRedirect("questDetail.jsp");
				break;
			case "/boardList":
				System.out.println("boardList");
				boardService = new BoardService();
				boardService.search(request, response);
				break;
			case "/noticeDetailView":
				System.out.println("noticeDetailView");
				request.getSession().setAttribute("board_no", request.getParameter("board_no"));
				response.sendRedirect("noticeDetail.jsp");
				break;
			case "/boardReplyWrite":
				System.out.println("boardReplyWrite");
				boardService = new BoardService();
				boardService.replyWrite(request, response);
				break;
			case "/boardReplyUdate":
				System.out.println("boardReplyUdate");
				boardService = new BoardService();
				boardService.replyUpdate(request,response);
				break;
			case "/boardReplyDel":
				System.out.println("boardReplyDel");
				boardService = new BoardService();
				boardService.replyDelete(request,response);
				break;
			case "/likeList":
				System.out.println("찜 목록 요청");
				infoService = new InfoService();
				infoService.likeList(request, response);
				break;
			case "/likeDel":
				System.out.println("찜 삭제 요청");
				placeService = new PlaceService();
				placeService.likeDel(request, response);
				break;	
			case "/placeDetailUp":
				System.out.println("검색 후 상세보기 요청");
	 			String page = request.getParameter("page");
	 			int place_no = Integer.parseInt(request.getParameter("place_no"));
	 			request.setAttribute("place_no", place_no);
	 			request.setAttribute("page", page);
	 			RequestDispatcher dis = request.getRequestDispatcher("placeDetailUp.jsp");
	 			dis.forward(request, response);
				break;	
			case "/placeList":
				System.out.println("등록내역확인 요청");
				infoService = new InfoService();
				infoService.placeList(request, response);
				break;
			case "/placeDel":
				System.out.println("등록 장소 삭제 요청");
				placeService = new PlaceService();
				placeService.delete(request, response);
				break;
			case "/placeDetail":
				System.out.println("장소 상세 보기");
				placeService = new PlaceService();
				placeService.detail(request, response);
				break;
			case "/qaWrite":
				System.out.println("Q&A 쓰기 요청");
				qaService = new QaService();
				qaService.write(request, response);
				break;
			case "/qaDel":
				System.out.println("Q&A 삭제 요청");
				qaService = new QaService();
				qaService.delete(request, response);
				break;
			case "/qaUpdate":
				System.out.println("Q&A 수정 요청");
				qaService = new QaService();
				qaService.update(request, response);
				break;
			case "/qaUpdateForm":
				System.out.println("Q&A 수정 폼 요청");
				qaService = new QaService();
				qaService.updateForm(request, response);
				break;
			case "/qaList":
				System.out.println("Q&A 리스트 요청");
				qaService = new QaService();
				qaService.list(request, response);
				break;
			case "/qaListSize":
				System.out.println("Q&A 리스트 사이즈 요청");
				qaService = new QaService();
				qaService.listSize(request, response);
				break;
			case "/qaReplyWrite":
				System.out.println("Q&A 답변 쓰기 요청");
				qaService = new QaService();
				qaService.qaReplyWrite(request, response);
				break;
			case "/qaReplyUpdate":
				System.out.println("Q&A 답변 수정 요청");
				qaService = new QaService();
				qaService.qaReplyUpdate(request, response);
				break;
			case "/qaReplyList":
				System.out.println("Q&A 답변 리스트 요청");
				qaService = new QaService();
				qaService.qaReplyList(request, response);
				break;
			case "/qaReplyDel":
				System.out.println("Q&A 답변 삭제 요청");
				qaService = new QaService();
				qaService.qaReplyDelete(request, response);
				break;
			case "/qaSearch":
				System.out.println("Q&A 검색 요청");
				qaService = new QaService();
				qaService.search(request, response);
				break;
			case "/qaDetail":
				System.out.println("Q&A 상세보기 요청");
				qaService = new QaService();
				qaService.detail(request, response);
				break;
			case "/qaWriteForm":
				System.out.println("Q&A 글쓰기 폼 요청");
				qaService = new QaService();
				qaService.writeForm(request, response);
				break;
			case "/total":
				System.out.println("통계 페이지 요청");
				infoService = new InfoService();
				infoService.total(request, response);
				break;
			case "/like":
				System.out.println("찜하기 요청");
				placeService = new PlaceService();
				placeService.like(request, response);
				break;
			case "/detaillikedel":
				System.out.println("상세보기 에서 찜취소 요청");
				placeService = new PlaceService();
				placeService.detaillikedel(request, response);
				break;
			case "/detaillike":
				System.out.println("찝상태 확인");
				placeService = new PlaceService();
				placeService.detaillike(request, response);
				break;
			case "/totalDetail":
				System.out.println("통계 내역 요청");
				infoService = new InfoService();
				infoService.totalDetail(request, response);
				break;
			case "/reviewList":
				System.out.println("이용 후기 리스트 요청");
				reviewService = new ReviewService();
				reviewService.list(request, response);
				break;
			case "/reviewWrite":
				System.out.println("이용 후기 작성 요청");
				reviewService = new ReviewService();
				reviewService.write(request, response);
				break;
			case "/reviewDel":
				System.out.println("이용 후기 삭제 요청");
				reviewService = new ReviewService();
				reviewService.delete(request, response);
				break;
			case "/reviewUpdate":
				System.out.println("이용 후기 수정 요청");
				reviewService = new ReviewService();
				reviewService.update(request, response);
				break;
			case "/placeUpdate":
				System.out.println("수정페이지 이동");
				System.out.println(request.getParameter("place_no"));
				request.setAttribute("place_no", request.getParameter("place_no"));
	 			page = "placeUpdate.jsp";
	 			dis = request.getRequestDispatcher(page);
	 			dis.forward(request, response);
				break;
			case "/placeUpdatedetail":
				System.out.println("수정페이지에 데이터 뿌리기");
				placeService = new PlaceService();
				placeService.updateDetail(request,response);
				break;
			case "/placeUpdateWrite":
				System.out.println("장소등록 수정 요청");
				placeService = new PlaceService();
				placeService.updateWrite(request, response);
				break;
		}
	}
}
