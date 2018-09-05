package com.semi.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.MidiDevice.Info;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.semi.dao.InfoDAO;
import com.semi.dto.DTO;

public class InfoService {

		//로그인
		public void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
			InfoDAO dao = new InfoDAO();
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			System.out.println(id+", "+pw);
		
			String div = dao.login(id, pw);
			boolean result = false;
			if(div != null) {
				request.getSession().setAttribute("loginId", id);
				request.getSession().setAttribute("loginDiv", div);
				result = true;
				System.out.println(request.getSession().getAttribute("loginId")+"/"+request.getSession().getAttribute("loginDiv")+"/"+result);
			}
			
			Gson json = new Gson();
			HashMap<String, Boolean> map = new HashMap<>();
			map.put("result", result);
			String obj = json.toJson(map);
			System.out.println("로그인 체크 : "+obj);
			response.getWriter().println(obj);
		}

	//사용자 회원가입
	public void userJoin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		InfoDAO dao = new InfoDAO();
		DTO dto = new DTO();
		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String email = request.getParameter("email");
		
		String birth = year+"-"+month+"-"+day;
		
		Date date = Date.valueOf(birth);
		System.out.println(id+", "+pw+", "+name+", "+gender+", "+email+", "+date);

		dto.setInfo_id(id);
		dto.setInfo_pw(pw);
		dto.setInfo_name(name);
		dto.setInfo_gender(gender);
		dto.setInfo_birth(date);   
		dto.setInfo_email(email);
		dto.setInfo_div("사용자");
			
		int success = dao.userJoin(dto);

		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", success);
		
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	//등록자 회원가입
	public void regJoin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		InfoDAO dao = new InfoDAO();
		InfoDAO dao3 = new InfoDAO();
		DTO dto = new DTO();
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String email = request.getParameter("email");
		String num1 = request.getParameter("num1");
		String num2 = request.getParameter("num2");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		
		String phone = phone1+phone2+phone3;
		
		String birth = year+"-"+month+"-"+day;
		String num = num1+num2;

		Date date = Date.valueOf(birth);
		System.out.println(id+", "+pw+", "+name+", "+gender+", "+email+", "+date+", "+num+", "+phone);
		boolean resultNum = dao3.numOverlay(num);
		int success = 0;
		
		if(resultNum ==false) {
			dto.setInfo_id(id);
			dto.setInfo_pw(pw);
			dto.setInfo_name(name);
			dto.setInfo_gender(gender);
			dto.setInfo_birth(date);
			dto.setInfo_email(email);
			dto.setInfo_div("등록자");
			dto.setInfo_num(num);
			dto.setInfo_phone(phone);
			
			success = dao.regJoin(dto);
		}
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", success);
		map.put("result2", resultNum);
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	//로그아웃
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession();
		session.removeAttribute("loginId");
		System.out.println(request.getSession().getAttribute("loginId"));
		response.sendRedirect("index.jsp");
		
	}

	//아이디 중복 체크
	public void overlay(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");
		
		InfoDAO dao = new InfoDAO();
		boolean result = dao.overlay(id);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("result", result);
		String obj = json.toJson(map);
		System.out.println(obj);
		response.getWriter().println(obj);
	}
	
	//주민등록번호 중복체크
	public void numOverlay(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String num1 = request.getParameter("num1");
		String num2 = request.getParameter("num2");
		String num = num1+num2;
		System.out.println(num);
		
		InfoDAO dao = new InfoDAO();
		boolean result = dao.numOverlay(num);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("result", result);
		String obj = json.toJson(map);
		System.out.println(obj);
		response.getWriter().println(obj);
	}
	


	//회원 리스트, 검색 출력
	public void userList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String loginId = (String) request.getSession().getAttribute("loginId");
		//String loginDiv = (String) request.getSession().getAttribute("loginDiv");
		
		String start = request.getParameter("sNum");
		String end = request.getParameter("eNum");
		String idSearch = request.getParameter("idSearch");
		System.out.println("service : "+idSearch);
		
		InfoDAO dao = new InfoDAO();
		ArrayList<DTO> userList = dao.userList(idSearch, Integer.parseInt(start), Integer.parseInt(end));
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		
		if(loginId != null) {
			map.put("login", true);
		}else{
			map.put("login", false);
		}
		
		map.put("userList", userList);
		
		String obj = json.toJson(map);
		System.out.println(obj);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
		
	}
	
	//사용자 회원정보 수정
	public void userUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException   {
		request.setCharacterEncoding("UTF-8");

		String loginId = (String) request.getSession().getAttribute("loginId");
		String loginDiv = (String) request.getSession().getAttribute("loginDiv");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String newPw = request.getParameter("newPw");
		String newPwChk = request.getParameter("newPwChk");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String email = request.getParameter("email");
		
		String birth = year+"-"+month+"-"+day;
		Date date = Date.valueOf(birth);
		
		System.out.println(id+", "+pw+", "+newPw+", "+newPwChk+", "+name+", "+
				gender+", "+date+", "+email);

		InfoDAO dao = new InfoDAO();
		DTO dto = new DTO();
		
		String chk = dao.pwChk(id);

		int success = 0;
		if(pw.equals(chk)) {
			//System.out.println("현재 비밀번호 맞음");
			dto.setInfo_id(id);
			dto.setInfo_pw(newPw);
			dto.setInfo_name(name);
			dto.setInfo_gender(gender);
			dto.setInfo_birth(date);
			dto.setInfo_email(email);

			success = dao.userUpdate(dto);
		}else {
			dao.resClose();
			//System.out.println("현재 비밀번호 틀림");
		}
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
			
		if(loginId != null && loginDiv.equals("사용자") || loginDiv.equals("등록자")) {
			map.put("login",true);
			System.out.println(loginId+", "+loginDiv);
		}else {
			map.put("login",false);
		}
		
		
		map.put("success", success);
		
		String obj = json.toJson(map);
		System.out.println(obj);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
		
	}
	
		//예약내역확인
		public void bookList(HttpServletRequest request, HttpServletResponse response) 
				throws IOException {
			String id = (String) request.getSession().getAttribute("loginId"); //세션의 loginId라는 속성 추출
			System.out.println(id);
			if(id == null) {//loginId의 값이 null 이라면(비로그인 상태라면)
				Gson json = new Gson(); //json을 준비
				HashMap<String, String> map = new HashMap<String, String>(); //key와 value 둘다 String 타입의 HashMap 준비
				map.put("msg", "권한이 없는 서비스입니다."); // map에 보낼 값 넣기
				
				String obj = json.toJson(map); // map 변환
				
				response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
				response.getWriter().println(obj); //response로 보냄
			}else { //로그인 상태라면
				int start = Integer.parseInt(request.getParameter("sNum")); //paging할 시작 번호 추출
				int end = Integer.parseInt(request.getParameter("eNum")); // paging할 마지막 번호 추출
				System.out.println(start+"/"+end); // 들어온 값 맞는 지 확인
				InfoDAO dao = new InfoDAO();  //InfoDAO 호출
				
				ArrayList<DTO> list = dao.bookList(id, start, end); //bookList 실행
				Gson json = new GsonBuilder().setDateFormat("yyyy-MM-dd").create(); //json객체 생성과 Date 타입 형태 정의
				HashMap<String, Object> map = new HashMap<String, Object>(); //담을 맵 객체화
				map.put("list", list); // map에 값 넣기
				String obj = json.toJson(map); // map의 값을 json으로 변환
				response.setContentType("text/html; charset=UTF-8");  //한글깨짐방지
				response.getWriter().println(obj); //response로 값 보냄
			}
		}

		//회원탈퇴
		public void del(HttpServletRequest request, HttpServletResponse response) throws IOException {
			InfoDAO dao = new InfoDAO();
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			String chk = dao.pwChk(id);
			int success = 0;
			
			if(chk.equals(pw)) {
				success = dao.del(id);
				request.getSession().removeAttribute("loginId");
				System.out.println(request.getSession().getAttribute("loginId"));
			}
			
			Gson json = new Gson();
			HashMap<String, Object> map = new HashMap<>();
			map.put("success", success);
			String obj = json.toJson(map);
			System.out.println(obj);
			response.getWriter().println(obj);
		}

		//등록자 회원정보 수정
		public void regUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
			request.setCharacterEncoding("UTF-8");
			
			String loginId = (String) request.getSession().getAttribute("loginId");
			String loginDiv = (String) request.getSession().getAttribute("loginDiv");
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String newPw = request.getParameter("newPw");
			String newPwChk = request.getParameter("newPwChk");
			String name = request.getParameter("name");
			String gender = request.getParameter("gender");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String email = request.getParameter("email");
			String num1 = request.getParameter("num1");
			String num2 = request.getParameter("num2");
			String phone1 = request.getParameter("phone1");
			String phone2 = request.getParameter("phone2");
			String phone3 = request.getParameter("phone3");
			
			String num = num1+num2;
			String phone = phone1+phone2+phone3;
			
			String birth = year+"-"+month+"-"+day;
			Date date = Date.valueOf(birth);
			
			System.out.println(id+", "+pw+", "+newPw+", "+newPwChk+", "+name+", "+
					gender+", "+date+", "+email+", "+num+", "+phone);

			InfoDAO dao = new InfoDAO();
			DTO dto = new DTO();
			
			String chk = dao.pwChk(loginId);
			
			int success = 0;
			if(pw.equals(chk)) {
				System.out.println("현재 비밀번호 맞음");
				dto.setInfo_id(id);
				dto.setInfo_pw(newPw);
				dto.setInfo_name(name);
				dto.setInfo_gender(gender);
				dto.setInfo_birth(date);
				dto.setInfo_email(email);
				dto.setInfo_num(num);
				dto.setInfo_phone(phone);
				success = dao.regUpdate(dto);
			}else {
				dao.resClose();
				System.out.println("현재 비밀번호 틀림");
			}
			
			
			Gson json = new Gson();
			HashMap<String, Object> map = new HashMap<>();
				
			if(loginId != null && loginDiv.equals("사용자") || loginDiv.equals("등록자")) {
				map.put("login",true);
				System.out.println(loginId+", "+loginDiv);
			}else {
				map.put("login",false);
			}

			map.put("success", success);
			map.put("pwChk", chk);
			String obj = json.toJson(map);
			System.out.println(obj);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
			
		}

		//등록자로 전환
		public void regChange(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String loginId = (String) request.getSession().getAttribute("loginId");
			
			InfoDAO dao = new InfoDAO();
			InfoDAO dao2 = new InfoDAO();
			DTO dto = new DTO();

			String num1 = request.getParameter("num1");
			String num2 = request.getParameter("num2");
			String phone1 = request.getParameter("phone1");
			String phone2 = request.getParameter("phone2");
			String phone3 = request.getParameter("phone3");
			
			String num = num1+num2;
			String phone = phone1+phone2+phone3;
			
			System.out.println(num+phone);
			boolean result = dao2.numOverlay(num);
			int success = 0;
			if(result == false) {
				dto.setInfo_div("등록자");
				dto.setInfo_num(num);
				dto.setInfo_phone(phone);
				success = dao.regChange(dto, loginId);
			}
			Gson json = new Gson();
			HashMap<String, Object> map = new HashMap<>();
					
			if(success > 0) {
				request.getSession().setAttribute("loginDiv", dto.getInfo_div());
				System.out.println(request.getSession().getAttribute("loginDiv"));
				map.put("loginId", loginId);
				map.put("loginDiv", dto.getInfo_div());
				map.put("success", success);
				map.put("result", result);
			}
			
			String obj = json.toJson(map);
			System.out.println(obj+dto.getInfo_div());
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
		}
		
		//찜내역 확인
		public void likeList(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String id = (String) request.getSession().getAttribute("loginId"); //세션의 loginId라는 속성 추출
			System.out.println(id);
			if(id == null) {//loginId의 값이 null 이라면(비로그인 상태라면)
				Gson json = new Gson(); //json을 준비
				HashMap<String, String> map = new HashMap<String, String>(); //key와 value 둘다 String 타입의 HashMap 준비
				map.put("msg", "권한이 없는 서비스입니다."); // map에 보낼 값 넣기
				
				String obj = json.toJson(map); // map 변환
				
				response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
				response.getWriter().println(obj); //response로 보냄
			}else {
				int start = Integer.parseInt(request.getParameter("sNum")); //paging할 시작 번호 추출
				int end = Integer.parseInt(request.getParameter("eNum")); // paging할 마지막 번호 추출
				//System.out.println(start+"/"+end); // 들어온 값 맞는 지 확인
				InfoDAO dao = new InfoDAO(); 
				
				ArrayList<DTO> list = dao.likeList(id, start, end);
				Gson json = new Gson();
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				String obj = json.toJson(map);
				response.setContentType("text/html; charset=UTF-8"); 
				response.getWriter().println(obj);
			}
		}

		public void placeList(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String id = (String) request.getSession().getAttribute("loginId"); //세션의 loginId라는 속성 추출
			String loginDiv = (String) request.getSession().getAttribute("loginDiv");
			System.out.println(id);
			System.out.println(loginDiv);
			if(id == null || !(loginDiv.equals("등록자"))) {//loginId의 값이 null 이라면(비로그인 상태라면) 혹은 등록자가 아니라면
				Gson json = new Gson(); //json을 준비
				HashMap<String, String> map = new HashMap<String, String>(); //key와 value 둘다 String 타입의 HashMap 준비
				map.put("msg", "권한이 없는 서비스입니다."); // map에 보낼 값 넣기
				
				String obj = json.toJson(map); // map 변환
				
				response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
				response.getWriter().println(obj); //response로 보냄
			}else {
				int start = Integer.parseInt(request.getParameter("sNum")); //paging할 시작 번호 추출
				int end = Integer.parseInt(request.getParameter("eNum")); // paging할 마지막 번호 추출
				//System.out.println(start+"/"+end); // 들어온 값 맞는 지 확인
				InfoDAO dao = new InfoDAO(); 
				ArrayList<DTO> list = dao.placeList(id, start, end);
				// 별점 값을 제외한 리스트 추출
				ArrayList<Double> review_score = new ArrayList<>();
				
				//별점 값 
				for(int i=0; i<list.size(); i++) {
					//System.out.println(list.get(i).getPlace_no());
					double score = dao.scoreAvg(list.get(i).getPlace_no());
					//System.out.println(score);
					review_score.add(score);
				}
				Gson json = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				map.put("review_score", review_score);
				String obj = json.toJson(map);
				response.setContentType("text/html; charset=UTF-8"); 
				response.getWriter().println(obj);
			}
		}

		//회원 삭제
		public void userDel(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String loginId = (String) request.getSession().getAttribute("loginId");
			String loginDiv = (String) request.getSession().getAttribute("loginDiv");
			System.out.println(loginId+loginDiv);
			
			String userDel[] = request.getParameterValues("userDel[]");
			System.out.println(userDel.length);
			
			InfoDAO dao = new InfoDAO();
			int success = dao.userDel(userDel);
			
			boolean result = false;
			if(success == userDel.length) {
				result = true;
			}
			
			Gson json = new Gson();
			HashMap<String, Boolean> map = new HashMap<>();
			map.put("result", result);
			String obj = json.toJson(map);
			System.out.println(obj);
			response.getWriter().println(obj);
		}

		//회원정보
		public void userInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String loginId = (String) request.getSession().getAttribute("loginId");
			String loginDiv = (String) request.getSession().getAttribute("loginDiv");
			System.out.println(loginId+loginDiv);
			
			Gson json = new GsonBuilder().setDateFormat("yy-MM-dd").create();
			HashMap<String, Object> map = new HashMap<>();
			
			if(loginId != null) {
				map.put("login", true);
			}else {
				map.put("login", false);
			}
			
			InfoDAO dao = new InfoDAO();
			DTO dto = dao.userInfo(loginId);
			map.put("userInfo", dto);
			
			String obj = json.toJson(map);
			System.out.println(obj);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
		}

		//통계
		public void total(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String id = (String) request.getSession().getAttribute("loginId"); //세션의 loginId라는 속성 추출
			String loginDiv = (String) request.getSession().getAttribute("loginDiv");
			System.out.println(id);
			System.out.println(loginDiv);
			if(id == null || !(loginDiv.equals("등록자"))) {//loginId의 값이 null 이라면(비로그인 상태라면) 혹은 등록자가 아니라면
				Gson json = new Gson(); //json을 준비
				HashMap<String, String> map = new HashMap<String, String>(); //key와 value 둘다 String 타입의 HashMap 준비
				map.put("msg", "권한이 없는 서비스입니다."); // map에 보낼 값 넣기
				
				String obj = json.toJson(map); // map 변환
				
				response.setContentType("test/html; charset=UTF-8"); //한글도 같이 보내니까 한글 깨짐 방지
				response.getWriter().println(obj); //response로 보냄
			}else {
				InfoDAO dao = new InfoDAO();
				//위에 테이블에 들어갈 리스트
				ArrayList<DTO> list = dao.total(id);
				ArrayList<Integer> bookCnt = new ArrayList<Integer>();//각 장소 예약자 수
				ArrayList<Date> dates = new ArrayList<>();//셀렉트 박스에 들어갈 날짜
				//예약자 수 
				for(int i=0; i<list.size(); i++) {
					bookCnt.add(dao.bookCnt(list.get(i).getPlace_no()));
				}
				Gson json = new Gson();
				HashMap<String, Object> map = new HashMap<>();
				map.put("list", list);
				map.put("bookCnt", bookCnt);
				String obj = json.toJson(map);
				response.setContentType("text/html; charset=UTF-8"); 
				response.getWriter().println(obj);
			}
		}

		//통계 자세히보기
		public void totalDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {
			//장소번호, 시작일, 끝일, 페이징 시작번호, 페이징 끝번호 추출
			int p_id = Integer.parseInt(request.getParameter("plcae_no"));
			String startDate = request.getParameter("date1");
			String endDate = request.getParameter("date2");
			int start = Integer.parseInt(request.getParameter("sNum"));
			int end = Integer.parseInt(request.getParameter("eNum"));
			//System.out.println(p_id+"/"+startDate+"/"+endDate+"/"+start+"/"+end);
			//dao에 DB요청(ArrayList<DTO>로 반환) --> totalDetail
			InfoDAO dao = new InfoDAO();
			ArrayList<DTO> list = dao.totalDetail(p_id, startDate, endDate, start, end);
			//아작스로 전송
			Gson json = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			String obj = json.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
		}

		//아이디 찾기
		public void id(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			System.out.println(name+", "+email);
			
			InfoDAO dao = new InfoDAO();
			String result =  dao.id(name, email);
			
			Gson json = new Gson();
			HashMap<String, String> map = new HashMap<>();
			map.put("result", result);
			String obj = json.toJson(map);
			System.out.println(obj);
			response.getWriter().println(obj);
		}

		//비밀번호 찾기
		public void pw(HttpServletRequest request, HttpServletResponse response) throws IOException {
			request.setCharacterEncoding("UTF-8");
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			System.out.println(id+", "+name+", "+email);
			
			InfoDAO dao = new InfoDAO();
			String result =  dao.pw(id, name, email);
			
			//메일 전송 API
			String host = "smtp.naver.com";
			final String user = "jaewook-";//보내는사람 메일
			final String password = "jaewook2@";//보내는사람 메일비밀번호
			String to = email;//받는사람 메일
			
			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.auth", "true");
			
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, password);
				}
			});
			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(user, "WAKE UP PLACE"));//보내는 사람 ID 변경(ID, 변경 ID)
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
				
				if(result != null) {
					//메일제목
					message.setSubject("WAKE UP PLACE");
					//메일내용
					message.setText(id+" 님의 비밀번호 입니다.\n"+"비밀번호 : "+result);
					Transport.send(message);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

			//json
			Gson json = new Gson();
			HashMap<String, String> map = new HashMap<>();
			map.put("result", result);
			String obj = json.toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println(obj);
		}

		//현재 비밀번호 체크
		public void pwChk(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String loginId = (String) request.getSession().getAttribute("loginId");
			System.out.println(loginId);
			
			InfoDAO dao = new InfoDAO();
			String result = dao.updatePwChk(loginId);
			
			Gson json = new Gson();
			HashMap<String, String> map = new HashMap<>();
			map.put("result", result);
			
			String obj = json.toJson(map);
			System.out.println(obj);
			response.getWriter().println(obj);
			
		}

	

		


		
}
