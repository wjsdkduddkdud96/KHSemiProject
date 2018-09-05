package com.semi.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.semi.dao.QaDAO;
import com.semi.dao.ReviewDAO;
import com.semi.dto.DTO;

public class ReviewService {

	// 이용 후기 리스트 요청
	public void list(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
	
		ReviewDAO dao = new ReviewDAO();
		ArrayList<DTO> list = dao.list(place_no);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		HashMap<String, ArrayList<DTO>> map = new HashMap<>();
		map.put("list", list);
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}

	// 이용 후기 작성 요청
	public void write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		String info_id = request.getParameter("info_id");
		String review_content = request.getParameter("review_content");
		double review_score = Double.parseDouble(request.getParameter("review_score"));
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		HashMap<String, Object> map = new HashMap<>();
		
		// 글자수 제한 - 이용 후기 내용이 300자 이상일 경우,
		if(review_content.length() > 300) {
			map.put("msg", "후기 내용이 300자가 넘습니다.");
		} else {
			DTO dto = new DTO();
			dto.setPlace_no(place_no);
			dto.setInfo_id(info_id);
			dto.setReview_content(review_content);
			dto.setReview_score(review_score);
			
			ReviewDAO dao = new ReviewDAO();
			int success = dao.write(dto);
			
			if(success > 0) {
				map.put("msg", "후기 등록이 성공했습니다.");
			} else {
				map.put("msg", "후기 등록이 실패했습니다.");
			}
		}
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}

	// 이용 후기 삭제 요청
	public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int review_no = Integer.parseInt(request.getParameter("review_no"));
		
		ReviewDAO dao = new ReviewDAO();
		int place_no = dao.delete(review_no);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		HashMap<String, Object> map = new HashMap<>();
		map.put("place_no", place_no);
		
		if(place_no > 0) {
			map.put("msg", "후기 삭제에 성공했습니다.");
		} else {
			map.put("msg", "후기 삭제에 성공했습니다.");
		}
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}

	// 이용 후기 수정 요청
	public void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		int review_no = Integer.parseInt(request.getParameter("review_no"));
		String review_content = request.getParameter("review_content");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		HashMap<String, String> map = new HashMap<>();
		
		// 글자수 제한 - 후기 내용이 300자 이상일 경우,
		if(review_content.length() > 300) {
			map.put("msg", "후기 내용이 300자가 넘습니다.");
			map.put("review_content", review_content);
		} else {
			ReviewDAO dao = new ReviewDAO();
			int success = dao.update(review_no, review_content);
			
			if(success > 0) {
				map.put("msg", "후기 수정에 성공했습니다.");
			} else {
				map.put("msg", "후기 수정에 실패했습니다.");
			}
		}
		
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(obj);
	}
}
