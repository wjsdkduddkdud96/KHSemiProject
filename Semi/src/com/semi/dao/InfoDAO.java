package com.semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.semi.dto.DTO;

public class InfoDAO {
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	//DB 접속
	public InfoDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//자원반납
	public void resClose() {
		try {
			if(rs != null) {rs.close();}
			if(ps != null) {ps.close();}
			if(conn != null) {conn.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//사용자 회원가입
	public int userJoin(DTO dto) {
		int success = 0;
		String sql = "INSERT INTO info(info_id, info_pw, info_birth, info_email, info_gender, info_name, info_div)"+ 
						"VALUES(?, ?, TO_DATE(?,'YYYY-MM-DD'), ?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getInfo_id());
			ps.setString(2, dto.getInfo_pw());
			ps.setDate(3, dto.getInfo_birth());
			ps.setString(4, dto.getInfo_email());
			ps.setString(5, dto.getInfo_gender());
			ps.setString(6, dto.getInfo_name());
			ps.setString(7,dto.getInfo_div());
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			resClose();
		}
		return success;
	}

		//로그인
		public String login(String id, String pw) {
			String result = null;
			String sql = "SELECT info_id, info_div FROM info WHERE info_id=? AND info_pw=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				ps.setString(2, pw);
				rs = ps.executeQuery();
				if(rs.next()) {
					result = rs.getString("info_div");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}finally {
				resClose();
			}
			return result;
		}

	//등록자 회원가입
	public int regJoin(DTO dto) {
		int success = 0;
		String sql = "INSERT INTO info(info_id, info_pw, info_birth, info_email, info_gender, info_name, info_div, info_num, info_phone)"+ 
							"VALUES(?, ?, TO_DATE(?,'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getInfo_id());
			ps.setString(2, dto.getInfo_pw());
			ps.setDate(3, dto.getInfo_birth());
			ps.setString(4, dto.getInfo_email());
			ps.setString(5, dto.getInfo_gender());
			ps.setString(6, dto.getInfo_name());
			ps.setString(7,dto.getInfo_div());
			ps.setString(8, dto.getInfo_num());
			ps.setString(9, dto.getInfo_phone());
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			resClose();
		}
		return success;
	}

	//아이디 중복체크
	public boolean overlay(String id) {
		boolean result = false;
		String sql = "SELECT info_id FROM info WHERE info_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally {
			resClose();
		}
		return result;
	}
	
	//주민번호 중복체크
	public boolean numOverlay(String num) {
		boolean result = false;
		String sql = "SELECT info_num FROM info WHERE info_num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally {
			resClose();
		}
		return result;
	}
	


	//회원리스트, 검색
	public ArrayList<DTO> userList(String idSearch, int start, int end) {
		ArrayList<DTO> userList = new ArrayList<>();
		/*String sql = "SELECT info_id, info_name, info_gender, info_email, info_div, info_num, info_phone FROM info ORDER BY info_id ASC";*/
		String sql = "SELECT ROW_NUMBER() OVER(ORDER BY info_id ASC) AS rNum, info_id, info_name, info_gender, info_email, info_div, info_num, info_phone FROM " + 
				"(SELECT ROW_NUMBER() OVER(ORDER BY info_id ASC) AS rNum, info_id, info_name, info_gender, info_email, info_div, info_num, info_phone FROM info WHERE info_id LIKE ?) WHERE rNum BETWEEN ? AND ?";
		System.out.println("DAO : "+idSearch);
		if(idSearch==null) {
			idSearch="";
		}
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+idSearch+"%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			
			rs = ps.executeQuery();
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setInfo_id(rs.getString("info_id"));
				dto.setInfo_name(rs.getString("info_name"));
				dto.setInfo_gender(rs.getString("info_gender"));
				dto.setInfo_email(rs.getString("info_email"));
				dto.setInfo_div(rs.getString("info_div"));
				dto.setInfo_num(rs.getString("info_num"));
				dto.setInfo_phone(rs.getString("info_phone"));
				userList.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			resClose();
		}
		return userList;
	}

	//사용자 회원정보 수정
	public int userUpdate(DTO dto) {
		int success = 0;
		String sql = "UPDATE info SET info_pw=?, info_birth=TO_DATE(?,'YYYY-MM-DD'), info_email=?, info_gender=?, info_name=?"+
				 " WHERE info_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getInfo_pw());
			ps.setDate(2, dto.getInfo_birth());
			ps.setString(3, dto.getInfo_email());
			ps.setString(4, dto.getInfo_gender());
			ps.setString(5, dto.getInfo_name());
			ps.setString(6, dto.getInfo_id());
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			resClose();
		}
		return success;
	}

	//회원수정 현재비밀번호 체크
	public String pwChk(String loginId) {//resClose 없음
		String result = null;
		String sql = "SELECT info_pw FROM info WHERE info_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = rs.getString("info_pw");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return result;
	}

	//예약내역 확인 리스트
	public ArrayList<DTO> bookList(String id, int start, int end) {
		//반환할 값을 담을 ArrayList 준비
		ArrayList<DTO> list = new ArrayList<DTO>(); 
		//쿼리문 준비
		String sql = "SELECT rnum, book_no, place_name, info_id, book_date, book_start, book_end, book_custom, book_price "+
				"FROM (SELECT ROW_NUMBER() OVER(ORDER BY book_date DESC) AS rnum, book_no, place_name, place.info_id, "+
				"to_char(book_date, 'YYYY-MM-DD') as book_date, to_char(book_start, 'HH24:MI') as book_start, "+
				"to_char(book_end, 'HH24:MI') as book_end, book_custom, book_price " +
				"FROM place ,book WHERE place.place_no = book.place_no AND book.info_id = ?)"+
				"WHERE rnum BETWEEN ? AND ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id); 
			ps.setInt(2, start); 
			ps.setInt(3, end);
			rs = ps.executeQuery();
			while(rs.next()) { //rs에 값이 있다면 반복
				DTO dto = new DTO();
				dto.setRnum(rs.getInt("rnum"));
				dto.setBook_no(rs.getInt("book_no"));
				dto.setPlace_name(rs.getString("place_name"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setBook_date(rs.getDate("book_date"));
				dto.setBook_start(rs.getString("book_start"));
				dto.setBook_end(rs.getString("book_end"));
				dto.setBook_custom(rs.getInt("book_custom"));
				dto.setBook_price(rs.getInt("book_price"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			resClose();
		}
		return list;
	}

			//회원 탈퇴
			public int del(String id) {
				int success = 0;
				String sql = "DELETE FROM info WHERE info_id=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, id);
					success = ps.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
					return 0;
				}finally {
					resClose();//자원반납
				}
				return success;
			}

			//등록자 회원정보 수정
			public int regUpdate(DTO dto) {
				int success = 0;
				String sql = "UPDATE info SET info_pw=?, info_birth=TO_DATE(?,'YYYY-MM-DD'), info_email=?, info_gender=?, info_name=?"+
						 ", info_num=?, info_phone=? WHERE info_id=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, dto.getInfo_pw());
					ps.setDate(2, dto.getInfo_birth());
					ps.setString(3, dto.getInfo_email());
					ps.setString(4, dto.getInfo_gender());
					ps.setString(5, dto.getInfo_name());
					ps.setString(6, dto.getInfo_num());
					ps.setString(7, dto.getInfo_phone());
					ps.setString(8, dto.getInfo_id());
					success = ps.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
					return 0;
				}finally {
					resClose();
				}
				return success;
			}

			//등록자 전환
			public int regChange(DTO dto, String loginId) {
				int success = 0;
				String sql = "UPDATE info SET info_num=?, info_phone=?, info_div=? WHERE info_id=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, dto.getInfo_num());
					ps.setString(2, dto.getInfo_phone());
					ps.setString(3, dto.getInfo_div());
					ps.setString(4, loginId);
					success = ps.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
					return 0;
				}finally {
					resClose();
				}
				return success;
			}
			
			//찜 목록
			public ArrayList<DTO> likeList(String id, int start, int end) {
				//반환할 값을 담을 ArrayList 준비
				ArrayList<DTO> list = new ArrayList<DTO>();
				//쿼리문 준비
				String sql = "SELECT rnum, like_no, place_name, place_no " + 
						"FROM (SELECT ROW_NUMBER() OVER(ORDER BY like_no DESC) AS rnum, like_no, place_name, likeTb.place_no " + 
						"FROM likeTb, place WHERE likeTb.place_no = place.place_no AND likeTb.info_id=?) " + 
						"WHERE rnum BETWEEN ? AND ?";
				
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, id);
					ps.setInt(2, start);
					ps.setInt(3, end);
					rs = ps.executeQuery();
					while(rs.next()) {
						DTO dto = new DTO();
						dto.setRnum(rs.getInt("rnum"));
						dto.setLike_no(rs.getInt("like_no"));
						dto.setPlace_name(rs.getString("place_name"));
						dto.setPlace_no(rs.getInt("place_no"));
						list.add(dto);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return list;
			}

			public ArrayList<DTO> placeList(String id, int start, int end) {
				//반환할 값을 담을 ArrayList 준비
				ArrayList<DTO> list = new ArrayList<DTO>();
				ArrayList<Integer> place = new ArrayList<Integer>();
				//쿼리문 준비
				String sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY place_date) AS rnum, "+
						"place_no, place_name, info_id, to_char(place_date, 'YYYY-MM-DD hh24:mi:ss') as place_date "+
						"FROM place WHERE info_id=?) " + 
						"WHERE rnum BETWEEN ? AND ?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, id); 
					ps.setInt(2, start); 
					ps.setInt(3, end);
					rs = ps.executeQuery();
					while(rs.next()) { //rs에 값이 있다면 반복
						DTO dto = new DTO();
						dto.setRnum(rs.getInt("rnum"));
						dto.setPlace_no(rs.getInt("place_no"));
						place.add(rs.getInt("place_no"));
						dto.setPlace_name(rs.getString("place_name"));
						dto.setPlace_date(Timestamp.valueOf(rs.getString("place_date")));
						//System.out.println(rs.getString("place_date"));
						dto.setInfo_id(rs.getString("info_id"));
						//double scoreAvg =  scoreAvg(place_no);
						//dto.setReview_score(scoreAvg);
						list.add(dto);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return list;
			}

			public double scoreAvg(int place_no) {
				double scoreAvg = 0;
				String sql = "SELECT AVG(review_score) as scoreAvg FROM review WHERE place_no=?";
				try {
					Context ctx = new InitialContext();
					DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
					conn = ds.getConnection();
					ps = conn.prepareStatement(sql);
					ps.setInt(1, place_no);
					rs = ps.executeQuery();
					if(rs.next()) {
						scoreAvg = rs.getDouble("scoreAvg");
					}
				} catch (Exception e) {
					e.printStackTrace();
					return scoreAvg;
				}finally {
					resClose();
				}
				return scoreAvg;
			}

			//회원 삭제
			public int userDel(String[] userDel) {
				int success = 0;
				String sql = "DELETE FROM info WHERE info_id=?";
				try {
					for(int i=0; i<userDel.length; i++) {
						ps = conn.prepareStatement(sql);
						ps.setString(1, userDel[i]);
						success += ps.executeUpdate();
						ps.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return 0;
				}finally {
					resClose();
				}
				return success;
			}

			//회원정보
			public DTO userInfo(String loginId) {
				DTO dto = null;
				String sql = "SELECT * FROM info WHERE info_id=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, loginId);
					rs = ps.executeQuery();
					
					if(rs.next()) {
						dto = new DTO();
						dto.setInfo_id(rs.getString("info_id"));
						dto.setInfo_name(rs.getString("info_name"));
						dto.setInfo_birth(rs.getDate("info_birth"));
						dto.setInfo_gender(rs.getString("info_gender"));
						dto.setInfo_email(rs.getString("info_email"));
						dto.setInfo_div(rs.getString("info_div"));
						dto.setInfo_num(rs.getString("info_num"));
						dto.setInfo_phone(rs.getString("info_phone"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return dto;
			}

			//통계 페이지 
			public ArrayList<DTO> total(String id) {
				ArrayList<DTO> list = new ArrayList<DTO>();
				String sql = "SELECT place_no, place_name FROM place WHERE info_id=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, id);
					rs = ps.executeQuery();
					while(rs.next()) {
						DTO dto = new DTO();
						dto.setPlace_no(rs.getInt("place_no"));
						dto.setPlace_name(rs.getString("place_name"));
						list.add(dto);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return list;
			}

			//예약자 수 
			public Integer bookCnt(int place_no) {
				int bookCnt = 0;
				String sql = "SELECT COUNT (*) as book_count FROM book WHERE place_no = ?";
				try {
					Context ctx = new InitialContext();
					DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
					conn = ds.getConnection();
					ps = conn.prepareStatement(sql);
					ps.setInt(1, place_no);
					rs = ps.executeQuery();
					if(rs.next()) {
						bookCnt = rs.getInt("book_count");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}finally {
					resClose();
				}
				return bookCnt;
			}

			//통계 검색버튼 누른 후 상세보기
			public ArrayList<DTO> totalDetail(int p_id, String startDate, String endDate, int start, int end) {
				ArrayList<DTO> list = new ArrayList<DTO>();
				String sql = "SELECT rnum, book_date, place_name, info_id, book_custom " + 
						"FROM (SELECT ROW_NUMBER() OVER(ORDER BY book_date) AS rnum, "+
						"to_char(book.book_date, 'yyyy-MM-dd') as book_date, place.place_name, book.info_id, book.book_custom " + 
						"FROM book, place WHERE place.place_no=book.place_no AND book.place_no=? "+
						"AND book.book_date BETWEEN to_date(?, 'yyyy-MM-dd') AND to_date(?, 'yyyy-MM-dd')) " + 
						"WHERE rnum BETWEEN ? AND ?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setInt(1, p_id);
					ps.setString(2, startDate);
					ps.setString(3, endDate);
					ps.setInt(4, start);
					ps.setInt(5, end);
					rs = ps.executeQuery();
					while(rs.next()) {
						DTO dto = new DTO();
						dto.setRnum(rs.getInt("rnum"));
						dto.setBook_date(rs.getDate("book_date"));
						dto.setPlace_name(rs.getString("place_name"));
						dto.setInfo_id(rs.getString("info_id"));
						dto.setBook_custom(rs.getInt("book_custom"));
						list.add(dto);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return list;
			}

			//아이디 찾기
			public String id(String name, String email) {
				String result = null;
				String sql = "SELECT info_id FROM info WHERE info_name=? AND info_email=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, name);
					ps.setString(2, email);
					rs = ps.executeQuery();
					if(rs.next()) {
						result = rs.getString("info_id");
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return result;
			}

			//비밀번호 찾기
			public String pw(String id, String name, String email) {
				String result = null;
				String sql = "SELECT info_pw FROM info WHERE info_id=? AND info_name=? AND info_email=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, id);
					ps.setString(2, name);
					ps.setString(3, email);
					rs = ps.executeQuery();
					if(rs.next()) {
						result = rs.getString("info_pw");
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return result;
			}

			//회원정보수정 현재비밀번호 체크
			public String updatePwChk(String loginId) {
				String result = null;
				String sql = "SELECT info_pw FROM info WHERE info_id=?";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, loginId);
					rs = ps.executeQuery();
					if(rs.next()) {
						result = rs.getString("info_pw");
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return null;
				}finally {
					resClose();
				}
				return result;
			}

			

			
}
