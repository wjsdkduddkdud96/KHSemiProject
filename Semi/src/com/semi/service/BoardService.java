package com.semi.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.semi.dao.BoardDAO;
import com.semi.dto.DTO;

public class BoardService {

	//문의사항 상세보기
	public void detail(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		String board_no = (String) request.getSession().getAttribute("board_no");
		System.out.println("detail : "+board_no);
		DTO dto = dao.detail(Integer.parseInt(board_no));
		ArrayList<DTO> list = dao.reDetail(Integer.parseInt(board_no));
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("dto",dto);
		map.put("list",list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
	}

	//문의사항 글쓰기
	public void write(HttpServletRequest request, 
			HttpServletResponse response) 
					throws IOException, ServletException {
		
		request.setCharacterEncoding("UTF-8");
		String board_no = request.getParameter("board_no");
		String title = request.getParameter("board_title");
		String content = request.getParameter("board_content");
		String category = request.getParameter("board_category");
		
		String loginId = (String) request.getSession().getAttribute("loginId");
		System.out.println(loginId);
		String loginDiv = (String) request.getSession().getAttribute("loginDiv");
		System.out.println(title+", "+content+", "+category);
		BoardDAO dao = new BoardDAO();
		DTO dto = new DTO();
		dto.setInfo_id(loginId);
		
		Gson json = new Gson();
		HashMap<String , Integer> map = new HashMap<>();
		int result=dao.write(dto, title, content, category);
		System.out.println(result);
		request.getSession().setAttribute("result", Integer.toString(result));
		map.put("result", result);
		
		String obj = json.toJson(map);
		
		//4.response로 반환
		response.getWriter().println(obj);
	}
	
	//문의사항 수정
	public void update(HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		
		request.setCharacterEncoding("UTF-8");
		String board_no = request.getParameter("board_no");
		String board_title = request.getParameter("board_title");
		String board_content = request.getParameter("board_content");
		BoardDAO dao = new BoardDAO();
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("success", dao.update(board_no, board_title, board_content));
		String obj = json.toJson(map);
		response.getWriter().println(obj);		
	}
	
	//문의사항 삭제
	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String board_no = request.getParameter("board_no");
		BoardDAO dao = new BoardDAO();
		String msg ="삭제 실패";
		if(dao.delete(board_no)>0) {			
			msg="삭제 완료";
			request.setAttribute("msg", msg);
		}
		RequestDispatcher dis = request.getRequestDispatcher("questDetail.jsp");
		dis.forward(request, response);
		
	}
	//문의사항 제목 검색, 문의사항 리스트
	public void search(HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		String search = request.getParameter("search");
		String board_category=request.getParameter("cate");
		String sNum = request.getParameter("sNum");
		String eNum = request.getParameter("eNum");
		System.out.println(search);
		BoardDAO dao = new BoardDAO();
		ArrayList<DTO> list = dao.search(search,board_category,Integer.parseInt(sNum),Integer.parseInt(eNum));
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);	
	}
	
	//답글 쓰기
	public void replyWrite(HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		String board_no = request.getParameter("board_no");
		String answerTxt = request.getParameter("answerTxt");
		System.out.println(board_no+"/"+answerTxt);
		
		String loginId = (String) request.getSession().getAttribute("loginId");
		System.out.println(loginId);
		String loginDiv = (String) request.getSession().getAttribute("loginDiv");
		
		BoardDAO dao = new BoardDAO();
		DTO dto = new DTO();
		dto.setInfo_id(loginId);
		
		Gson json = new Gson();
		HashMap<String , Integer> map = new HashMap<>();
		int result=dao.replyWrite(dto, board_no, answerTxt);
		System.out.println(result);
		request.getSession().setAttribute("result", Integer.toString(result));
		map.put("result", result);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	//답글 수정
	public void replyUpdate(HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		String reply_no = request.getParameter("reply_no");
		String reply = request.getParameter("reply");
		BoardDAO dao = new BoardDAO();
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("success", dao.replyUpdate(reply_no, reply));
		String obj = json.toJson(map);
		response.getWriter().println(obj);
		
	}

	public void replyDelete(HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		String reply_no = request.getParameter("reply_no");
		BoardDAO dao = new BoardDAO();
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("success", dao.replyDelete(reply_no));
		String obj = json.toJson(map);
		response.getWriter().println(obj);
		
	}

	//공지사항 삭제
	public void noticeDel(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String board_no = request.getParameter("board_no");
		BoardDAO dao = new BoardDAO();
		String msg ="삭제 실패";
		if(dao.delete(board_no)>0) {			
			msg="삭제 완료";
			request.setAttribute("msg", msg);
		}
		RequestDispatcher dis = request.getRequestDispatcher("noticeDetail.jsp");
		dis.forward(request, response);
		
	}

}
