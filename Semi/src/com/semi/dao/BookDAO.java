package com.semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.semi.dto.DTO;

public class BookDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	//DB 접속
	public BookDAO() {
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

	public int delete(String[] delList) {
		int delCnt=0;
		String sql = "DELETE FROM book WHERE book_no=?";
		try {
			for(int i=0; i<delList.length;i++) {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(delList[i]));
				delCnt += ps.executeUpdate();
				ps.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			resClose();
		}
		return delCnt;
	}

	//예약하기
	public int bookWrite(DTO dto, String loginId) {
		int success = 0;
		String sql = "INSERT INTO book(book_no, place_no, info_id, book_date, book_start, book_end, book_price, book_custom) "+
		"VALUES(book_seq.NEXTVAL, ?, ?, TO_DATE(?,'YY-MM-DD'), TO_DATE(?,'hh24:mi'), TO_DATE(?,'hh24:mi'), ?, ?)";
		try {
			ps = conn.prepareStatement(sql, new String[] {"book_no"});
			ps.setInt(1, dto.getPlace_no());
			ps.setString(2, loginId);
			ps.setDate(3, dto.getBook_date());
			ps.setString(4, dto.getBook_start());
			ps.setString(5, dto.getBook_end());
			ps.setLong(6, dto.getBook_price());
			ps.setInt(7, dto.getBook_custom());
			
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
				success = (int) rs.getLong(1);
			}
			
/*			if(rs.next()) {
				
				sql = "SELECT place_name, book_date, book_start, book_end, book_custom, book_price FROM place p, book b "+
				"WHERE book_no = ?";
				ps= conn.prepareStatement(sql);
				ps.setInt(1, success);
				rs = ps.executeQuery();
			}*/
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			resClose();
		}
		return success;
	}

	//예약 정보
	public DTO bookInfo(String loginId, String book_no) {
		DTO dto = null;
		/*String sql = "SELECT info_id, book_date, TO_CHAR(book_start, 'HH24:MI') AS book_start, TO_CHAR(book_end, 'HH24:MI') AS book_end, book_price, book_custom FROM book WHERE info_id=?";*/
		String sql = "SELECT p.place_name, b.info_id, b.book_date, TO_CHAR(b.book_start, 'HH24:MI') AS book_start, TO_CHAR(b.book_end, 'HH24:MI') AS book_end, b.book_price, b.book_custom " + 
				"FROM place p ,book b WHERE p.place_no = b.place_no AND b.info_id=? AND b.book_no=?"; 
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			ps.setString(2, book_no);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new DTO();
				dto.setPlace_name(rs.getString("place_name"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setBook_date(rs.getDate("book_date"));
				dto.setBook_start(rs.getString("book_start"));
				dto.setBook_end(rs.getString("book_end"));
				dto.setBook_price(rs.getLong("book_price"));
				dto.setBook_custom(rs.getInt("book_custom"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			resClose();
		}
		return dto;
	}

}
