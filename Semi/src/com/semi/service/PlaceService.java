package com.semi.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import java.util.HashMap;

import com.google.gson.Gson;

import com.semi.dao.PlaceDAO;
import com.semi.dto.DTO;

public class PlaceService {



	public void Write(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String savePath = null;
		String root = request.getSession().getServletContext().getRealPath("/");
		savePath = root + "upload/";
		System.out.println("사진 저장 경로 : " + savePath);

		File dir = new File(savePath);
		// upload 폴더 없으면 만들어 준다.
		if (!dir.exists()) {
			dir.mkdir();
		}

		MultipartRequest multi = new MultipartRequest(request, savePath, 1024 * 1024 * 10, "UTF-8");
		DTO dto = new DTO();

		request.setCharacterEncoding("UTF-8");

		PlaceDAO dao = new PlaceDAO();

		HttpSession session = request.getSession();
		String loginid = (String) session.getAttribute("loginId");

		String placename = multi.getParameter("place_name");
		String categoly = multi.getParameter("categoly");
		String placephone = multi.getParameter("phone1")+"-"+ multi.getParameter("phone2")+"-"+ multi.getParameter("phone3");
		String start = multi.getParameter("start");
		String end = multi.getParameter("end");
		// System.out.println(multi.getParameter("cash"));
		long cash = Integer.parseInt(multi.getParameter("cash"));
		String address =multi.getParameter("postnumber")+"/"+multi.getParameter("addr")+"/"+multi.getParameter("detailAddr");
		String detailinfo = multi.getParameter("fac_info");
		String info = multi.getParameter("info");

		String homepage= multi.getParameter("homepage");
		String subcontent= multi.getParameter("sub_content");

		System.out.println(placename+"/"+loginid+"/"+categoly+"/"+placephone+"/"+start+"/"
		+end+"/"+cash+"/"+address+"/"+detailinfo+"/"+info+"/"+homepage+"/"+subcontent);

		dto.setInfo_id(loginid);
		dto.setPlace_name(placename);
		dto.setPlace_category(categoly);
		dto.setPlace_phone(placephone);
		dto.setPlace_start(start);
		dto.setPlace_end(end);
		dto.setPlace_price(cash);
		dto.setPlace_loc(address);
		dto.setPlace_guide(detailinfo);
		dto.setPlace_info(info);
		dto.setPlace_home(homepage);
		dto.setPlace_attention(subcontent);
		long success = dao.write(dto);

		ArrayList<DTO> list = new ArrayList<>();
		for (int i = 1; i <= 5; i++) {
			DTO dto2 = new DTO();
		    String oriFileName = multi.getFilesystemName("photo"+i);
		    if (oriFileName != null) {
		       // 확장자 추출
		       String ext = oriFileName.substring(oriFileName.indexOf("."));
		       // 새파일명 만들기(새파일명+확장자)
		       String newFileName = success+"_"+i+ ext;
		       // 파일명 변경
		       File oldFile = new File(savePath + "/" + oriFileName);
		       File newFile = new File(savePath + "/" + newFileName);
		       oldFile.renameTo(newFile);
		       // 변경된 파일명 DTO에 추가
		       dto2.setPlace_photo(newFileName);
		       list.add(dto2);
		    }
		    
		 }
		 dao.photowrite(list,success);

	         String page = "placeWrite.jsp";
	 		if(success>0) {
	 			request.setAttribute("place_no", success);
	 			request.setAttribute("page", "placeDetail.jsp");
	 			page = "placeDetailUp.jsp";
	 		}
	 		RequestDispatcher dis = request.getRequestDispatcher(page);
	 		dis.forward(request, response);
	 	}

	public void search(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String keyword = request.getParameter("keyword");
		String category = request.getParameter("category");
		String loc = request.getParameter("area");
		int start = Integer.parseInt(request.getParameter("start"));
		int end = Integer.parseInt(request.getParameter("end"));

		PlaceDAO dao = new PlaceDAO();
		ArrayList<DTO> list;
		list = dao.search(start, end, keyword, category, loc);

		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void detailphoto(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String number = request.getParameter("place_no");
		System.out.println(number);
		PlaceDAO dao = new PlaceDAO();
		ArrayList<DTO> list = dao.detailphoto(number);
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void likeDel(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 받아온 값 받음
		String[] like_id = request.getParameterValues("delList[]");
		System.out.println(like_id.length);
		// doa로 넘겨줌
		PlaceDAO dao = new PlaceDAO();
		int delCnt = dao.likeDel(like_id);
		boolean success = false;

		// 지운갯수와 넘어온 갯수가 같으면
		if (delCnt == like_id.length) {
			success = true;
		}

		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("success", success);
		String obj = json.toJson(map);

		response.getWriter().println(obj);	

	}

	public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String savePath = null;
		String root = request.getSession().getServletContext().getRealPath("/");
		savePath = root + "upload/";
		System.out.println("사진 저장 경로 : " + savePath);
		
		String id = (String) request.getSession().getAttribute("loginId"); //세션의 loginId라는 속성 추출
		String loginDiv = (String) request.getSession().getAttribute("loginDiv");
		System.out.println(id);
		System.out.println(loginDiv);
		File dir = new File(savePath);

		//MultipartRequest multi = new MultipartRequest(request, savePath, 1024 * 1024 * 10, "UTF-8");		
		
		if(id == null || !(loginDiv.equals("등록자"))) {//loginId의 값이 null 이라면(비로그인 상태라면) 혹은 등록자가 아니라면
			Gson json = new Gson(); //json을 준비
			HashMap<String, String> map = new HashMap<String, String>(); //key와 value 둘다 String 타입의 HashMap 준비
			map.put("msg", "권한이 없는 서비스입니다."); // map에 보낼 값 넣기
			
			String obj = json.toJson(map); // map 변환
			
			response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
			response.getWriter().println(obj); //response로 보냄
		}else {
			int p_id = Integer.parseInt(request.getParameter("del_no"));
			System.out.println(p_id);
			boolean success = false;
			PlaceDAO dao = new PlaceDAO();
			ArrayList<DTO> list = dao.writeupdatephoto(p_id);
			if(list!=null) {
				if(dao.delete(p_id)>0) {
				for(int i=0;i<list.size();i++) {			
					File file = new File(savePath+"/"+list.get(i).getPlace_photo());
						if(file.exists()) {//파일이 있을 경우에만 삭제
							System.out.println("파일을 삭제 성공 ?"+file.delete());
						}
					}
				success = true;
				}
			}
			Gson json = new Gson();
			HashMap<String, Boolean> map = new HashMap<String, Boolean>();
			map.put("success", success);
			String obj = json.toJson(map);
			response.getWriter().println(obj);
		}
	}

	public void detail(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		System.out.println("detail :"+place_no);
		PlaceDAO dao = new PlaceDAO();
		DTO dto = dao.detail(place_no);
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("dto", dto);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
	}

	public void like(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		String id = request.getParameter("id");
		PlaceDAO dao = new PlaceDAO();
		System.out.println(place_no);
		System.out.println(id);
		Gson json = new Gson();//json을 준비
		boolean success = false;
		if(id=="") {
			HashMap<String, Boolean> map = new HashMap<String, Boolean>();
			map.put("success", success); // map에 보낼 값 넣기			
			String obj = json.toJson(map); // map 변환			
			response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
			response.getWriter().println(obj);
		}else {			
			if(dao.like(place_no,id)==1) {
				success = true;				
			}
			HashMap<String, Boolean> map = new HashMap<String, Boolean>();
			map.put("success", success); // map에 보낼 값 넣기			
			String obj = json.toJson(map); // map 변환			
			response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
			response.getWriter().println(obj);
		}
		
	}

	public void detaillikedel(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		String id = request.getParameter("id");
		PlaceDAO dao = new PlaceDAO();
		System.out.println(place_no);
		System.out.println(id);
		Gson json = new Gson();
		boolean success = false;
		if(id==null) {
			HashMap<String, Boolean> map = new HashMap<String, Boolean>();
			map.put("success", success); // map에 보낼 값 넣기			
			String obj = json.toJson(map); // map 변환			
			response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
			response.getWriter().println(obj);
		}else {
			if(dao.detaillikedel(place_no,id)==1) {
				success = true;				
			}
			HashMap<String, Boolean> map = new HashMap<String, Boolean>();
			map.put("success", success); // map에 보낼 값 넣기			
			String obj = json.toJson(map); // map 변환			
			response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
			response.getWriter().println(obj);
		}
	}

	public void detaillike(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		String id = request.getParameter("id");
		PlaceDAO dao = new PlaceDAO();
		boolean success = dao.detaillike(place_no,id);
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void updateDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int place_no = Integer.parseInt(request.getParameter("place_no"));
		System.out.println("updatedetail :"+place_no);
		PlaceDAO dao = new PlaceDAO();
		DTO dto = dao.updatedetail(place_no);
		ArrayList<DTO> list = dao.updatephoto(place_no);
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("dto", dto);
		map.put("list", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void updateWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String savePath = null;
		String root = request.getSession().getServletContext().getRealPath("/");
		savePath = root + "upload/";
		System.out.println("사진 저장 경로 : " + savePath);

		File dir = new File(savePath);

		MultipartRequest multi = new MultipartRequest(request, savePath, 1024 * 1024 * 10, "UTF-8");
		DTO dto = new DTO();

		request.setCharacterEncoding("UTF-8");

		PlaceDAO dao = new PlaceDAO();

		HttpSession session = request.getSession();
		String loginid = (String) session.getAttribute("loginId");
		
		int place_no=Integer.parseInt(multi.getParameter("place_no"));
		String placename = multi.getParameter("place_name");
		String categoly = multi.getParameter("categoly");
		String placephone = multi.getParameter("phone1")+"-"+ multi.getParameter("phone2")+"-"+ multi.getParameter("phone3");
		String start = multi.getParameter("start");
		String end = multi.getParameter("end");
		// System.out.println(multi.getParameter("cash"));
		long cash = Integer.parseInt(multi.getParameter("cash"));
		String address =multi.getParameter("postnumber")+"/"+multi.getParameter("addr")+"/"+multi.getParameter("detailAddr");
		String detailinfo = multi.getParameter("fac_info");
		String info = multi.getParameter("info");

		String homepage= multi.getParameter("homepage");
		String subcontent= multi.getParameter("sub_content");

		System.out.println(place_no+"/"+placename+"/"+loginid+"/"+categoly+"/"+placephone+"/"+start+"/"
		+end+"/"+cash+"/"+address+"/"+detailinfo+"/"+info+"/"+homepage+"/"+subcontent);
		
		dto.setPlace_no(place_no);
		dto.setInfo_id(loginid);
		dto.setPlace_name(placename);
		dto.setPlace_category(categoly);
		dto.setPlace_phone(placephone);
		dto.setPlace_start(start);
		dto.setPlace_end(end);
		dto.setPlace_price(cash);
		dto.setPlace_loc(address);
		dto.setPlace_guide(detailinfo);
		dto.setPlace_info(info);
		dto.setPlace_home(homepage);
		dto.setPlace_attention(subcontent);
		long success = dao.update(dto);
		ArrayList<DTO> list = dao.writeupdatephoto(place_no);
		
		if(list!=null) {
			for(int i=0;i<list.size();i++) {			
			File file = new File(savePath+"/"+list.get(i).getPlace_photo());
				if(file.exists()) {//파일이 있을 경우에만 삭제
					System.out.println("파일을 삭제 성공 ?"+file.delete());
				}
			}
		}		
		list = new ArrayList<>();
		for (int i = 1; i <= 5; i++) {
			DTO dto2 = new DTO();
		    String oriFileName = multi.getFilesystemName("photo"+i);
		    if (oriFileName != null) {
		       // 확장자 추출
		       String ext = oriFileName.substring(oriFileName.indexOf("."));
		       // 새파일명 만들기(새파일명+확장자)
		       String newFileName = success+"_"+i+ ext;
		       // 파일명 변경
		       File oldFile = new File(savePath + "/" + oriFileName);
		       File newFile = new File(savePath + "/" + newFileName);
		       oldFile.renameTo(newFile);
		       // 변경된 파일명 DTO에 추가
		       dto2.setPlace_photo(newFileName);
		       list.add(dto2);
		    }
		    
		 }
		 dao.photowrite(list,success);

	         String page = "placeUpdate.jsp";
	         request.setAttribute("place_no", success);
	         request.setAttribute("page", "placeDetail.jsp");
	 		if(success>0) {	 			
	 			page = "placeDetailUp.jsp";
	 		}
	 		RequestDispatcher dis = request.getRequestDispatcher(page);
	 		dis.forward(request, response);
	}
}
