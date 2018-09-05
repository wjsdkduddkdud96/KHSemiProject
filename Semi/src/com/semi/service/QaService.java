package com.semi.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.semi.dao.QaDAO;
import com.semi.dto.DTO;

public class QaService {

	// Q&A 쓰기(완)
	public void write(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			request.setCharacterEncoding("UTF-8");
			int success = 0;
			
			int place_no = Integer.parseInt(request.getParameter("place_no"));
			String qa_title = request.getParameter("qa_title");
			String qa_content = request.getParameter("qa_content");
			String info_id = (String) request.getSession().getAttribute("loginId");
			 
			// 글자수 제한 - Q&A 내용이 300자 이상일 경우
			if(qa_content.length() > 300) {
				request.setAttribute("msg", "Q&A 내용이 300자가 넘습니다.");
				request.setAttribute("qa_title", qa_title);
				request.setAttribute("qa_content", qa_content);
				RequestDispatcher dis = request.getRequestDispatcher("qaWriteForm?place_no="+place_no);
				dis.forward(request, response);
			} else if(qa_title.length() > 20) {	// 글자수 제한 - Q&A 제목이 20자 이상일 경우,
				request.setAttribute("msg", "Q&A 제목이 20자가 넘습니다.");
				request.setAttribute("qa_title", qa_title);
				request.setAttribute("qa_content", qa_content);
				RequestDispatcher dis = request.getRequestDispatcher("qaWriteForm?place_no="+place_no);
				dis.forward(request, response);
			} else {
				QaDAO dao = new QaDAO();
				DTO dto = new DTO();
				
				dto.setPlace_no(place_no);
				dto.setQa_title(qa_title);
				dto.setQa_content((qa_content).replaceAll("\r\n", "<br/>"));
				dto.setInfo_id(info_id);
				
				success = dao.write(dto);
				String msg = "Q&A 작성에 성공했습니다.";
				if(success == 0) {
					msg = "Q&A 작성에 실패했습니다.";
				}
				
				request.setAttribute("qa_no", dto.getQa_no());
				request.setAttribute("msg", msg);
				RequestDispatcher dis = request.getRequestDispatcher("qaWrite.jsp");
				dis.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Q&A 리스트(완)
	public void list(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		int start = Integer.parseInt(request.getParameter("start"));
		int end = Integer.parseInt(request.getParameter("end"));
		
		QaDAO dao = new QaDAO();
		ArrayList<DTO> list = dao.list(place_no, start, end);

		Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
		// Gson gson = new Gson();
		HashMap<String, ArrayList<DTO>> map = new HashMap<>();
		map.put("list", list);
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}
	
	// Q&A 상세보기(완)
	public void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qa_no = Integer.parseInt(request.getParameter("qa_no"));
		
		DTO dto = new DTO();
		QaDAO dao = new QaDAO();
		dto = dao.detail(qa_no);
		
		request.setAttribute("dto", dto);
		RequestDispatcher dis = request.getRequestDispatcher("qaDetail.jsp");
		dis.forward(request, response);
	}

	// Q&A 수정 폼(완)
	public void updateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qa_no = Integer.parseInt(request.getParameter("qa_no"));
		
		QaDAO dao = new QaDAO();
		DTO dto = new DTO();
		dto = dao.detail(qa_no);
		
		request.setAttribute("dto", dto);
		RequestDispatcher dis = request.getRequestDispatcher("./qaUpdateForm.jsp?qa_no="+qa_no);
		dis.forward(request, response);
	}
	
	// Q&A 수정(완)
	public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int qa_no = Integer.parseInt(request.getParameter("qa_no"));
		String qa_title = request.getParameter("qa_title");
		String qa_content = request.getParameter("qa_content");
		
		// 글자수 제한 - 수정 시 Q&A 제목, 내용이 없거나, 제목, 내용이 300자 이상일 경우
		if(qa_title.length() == 0) {
			request.setAttribute("qa_no", qa_no);
			request.setAttribute("msg", "Q&A 제목을 입력해주세요.");
			request.setAttribute("qa_title", qa_title);
			request.setAttribute("qa_content", qa_content);
			RequestDispatcher dis = request.getRequestDispatcher("qaUpdateForm?qa_no="+qa_no);
			dis.forward(request, response);
		} else if(qa_content.length() == 0) {
			request.setAttribute("qa_no", qa_no);
			request.setAttribute("msg", "Q&A 내용을 입력해주세요.");
			request.setAttribute("qa_title", qa_title);
			request.setAttribute("qa_content", qa_content);
			RequestDispatcher dis = request.getRequestDispatcher("qaUpdateForm?qa_no="+qa_no);
			dis.forward(request, response);
		} else if(qa_content.length() > 300) {
			request.setAttribute("qa_no", qa_no);
			request.setAttribute("msg", "Q&A 내용이 300자가 넘습니다.");
			request.setAttribute("qa_title", qa_title);
			request.setAttribute("qa_content", qa_content);
			RequestDispatcher dis = request.getRequestDispatcher("qaUpdateForm?qa_no="+qa_no);
			dis.forward(request, response);
		} else if(qa_title.length() > 20) {	// 글자수 제한 - 수정 시 Q&A 제목이 20자 이상일 경우,
			request.setAttribute("qa_no", qa_no);
			request.setAttribute("msg", "Q&A 제목이 20자가 넘습니다.");
			request.setAttribute("qa_title", qa_title);
			request.setAttribute("qa_content", qa_content);
			RequestDispatcher dis = request.getRequestDispatcher("qaUpdateForm?qa_no="+qa_no);
			dis.forward(request, response);
		} else {
			DTO dto = new DTO();
			dto.setQa_no(qa_no);
			dto.setQa_title(qa_title);
			dto.setQa_content(qa_content.replaceAll("\r\n", "<br/>"));
			
			QaDAO dao = new QaDAO();
			int success = dao.update(dto);
			
			String msg = "Q&A 수정에 성공했습니다.";
			if(success == 0) {
				msg = "Q&A 수정에 실패했습니다.";
			}
			
			request.setAttribute("qa_no", qa_no);
			request.setAttribute("msg", msg);
			RequestDispatcher dis = request.getRequestDispatcher("qaUpdateForm.jsp");
			dis.forward(request, response);
		}
	}
	
	// Q&A 삭제(완)
	public void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qa_no = Integer.parseInt(request.getParameter("qa_no"));
	
		QaDAO dao = new QaDAO();
		int place_no = dao.delete(qa_no);
		response.sendRedirect("placeDetailUp?place_no="+place_no+"&page=qa.jsp");
	}

	// Q&A 답변 쓰기(완) -수정 완
	public void qaReplyWrite(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	
		String qa_reply_content = request.getParameter("qa_reply_content");
		String info_id = request.getParameter("info_id");
		int qa_no = Integer.parseInt(request.getParameter("qa_no"));

		Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
		// Gson gson = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		
		// 글자수 제한
		if(qa_reply_content.length() > 300) {
			map.put("msg", "Q&A 답변이 300자가 넘습니다.");
		} else {
			System.out.println("300자 안넘어!");
			DTO dto = new DTO();
			dto.setQareply_content(qa_reply_content);
			dto.setInfo_id(info_id);
			dto.setQa_no(qa_no);
			
			QaDAO dao = new QaDAO();
			int success = dao.qaReplyWrite(dto);
			
			if(success > 0) {
				map.put("dto", dto);
				map.put("msg", "Q&A 답변 작성에 성공했습니다.");
			} else {
				map.put("msg", "Q&A 답변 작성에 실패했습니다.");
			}
		}
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}

	// Q&A 답변 수정(완) 
	public void qaReplyUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
		// Gson gson = new Gson();
		HashMap<String, String> map = new HashMap<>();
		
		int qareply_no = Integer.parseInt(request.getParameter("qareply_no"));
		String qareply_content = request.getParameter("qareply_content");
		
		if(qareply_content.length() > 300) {
			map.put("msg", "Q&A 답변이 300자가 넘습니다.");
		} else {
			QaDAO dao = new QaDAO();
			int qa_no = dao.qaReplyUpdate(qareply_no, qareply_content);
			
			if(qa_no > 0) {
				map.put("msg", "답변이 수정되었습니다.");
			} else {
				map.put("msg", "답변 수정에 실패했습니다.");
			}
		}
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}

	// Q&A 답변 리스트(완)
	public void qaReplyList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int qa_no = Integer.parseInt(request.getParameter("qa_no"));
		
		QaDAO dao = new QaDAO();
		ArrayList<DTO> list = dao.qaReplyList(qa_no);
	
		if(list != null) {
			Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
			// Gson gson = new Gson();
			HashMap<String, ArrayList<DTO>> map = new HashMap<>();
			map.put("list", list);
		
			String obj = gson.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(obj);
		} else {
			System.out.println("Q&A 답글 리스트가 없습니다.");
		}
	}

	// Q&A 답변 삭제(완)
	public void qaReplyDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qareply_no = Integer.parseInt(request.getParameter("qareply_no"));
		
		QaDAO dao = new QaDAO();
		int qa_no = dao.qaReplyDelete(qareply_no);
		
		String msg = "Q&A 삭제에 실패했습니다.";
		if(qa_no > 0) {
			msg = "Q&A 삭제에 성공했습니다.";
		}

		Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
		// Gson gson = new Gson();
		HashMap<String, String> map = new HashMap<>();
		map.put("qa_no", String.valueOf(qa_no));
		map.put("msg", msg);
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}

	// Q&A 검색 요청
	public void search(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		String search_keyword = request.getParameter("search_keyword");
		
		QaDAO dao = new QaDAO();
		ArrayList<DTO> list = dao.search(place_no, search_keyword);

		Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
		// Gson gson = new Gson();
		HashMap<String, ArrayList<DTO>> map = new HashMap<>();
		map.put("list", list);
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}

	// Q&A 수정 폼 요청(완)
	public void writeForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		
		request.setAttribute("place_no", place_no);
		RequestDispatcher dis = request.getRequestDispatcher("qaWrite.jsp");
		dis.forward(request, response);
	}

	// Q&A 리스트 사이즈 요청
	public void listSize(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		
		QaDAO dao = new QaDAO();
		int max_size = dao.listSize(place_no);

		Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
		// Gson gson = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("max_size", max_size);
		
		String obj = gson.toJson(map);
		response.getWriter().write(obj);
	}
}
