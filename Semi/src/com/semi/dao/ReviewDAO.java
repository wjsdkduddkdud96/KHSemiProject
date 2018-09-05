package com.semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.semi.dto.DTO;

public class ReviewDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	//DB 접속
	public ReviewDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 자원반납
	public void resClose() {
		try {
			if(rs != null) {rs.close();}
			if(ps != null) {ps.close();}
			if(conn != null) {conn.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 이용 후기 작성 요청(완)
	public int write(DTO dto) {
		int success = 0;
		String sql = "INSERT INTO review VALUES (review_no_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getInfo_id());
			ps.setInt(2, dto.getPlace_no());
			ps.setString(3, dto.getReview_content());
			ps.setDouble(4, dto.getReview_score());
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		return success;
	}

	public ArrayList<DTO> list(int place_no) {
		DTO dto = null;
		ArrayList<DTO> list = new ArrayList<>();
		String sql = "SELECT * FROM review WHERE place_no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, place_no);
		
			rs = ps.executeQuery();
		
			while(rs.next()) {
				dto = new DTO();
				dto.setReview_no(rs.getInt("review_no"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setPlace_no(rs.getInt("place_no"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setReview_score(rs.getDouble("review_score"));
				dto.setReview_date(rs.getDate("review_date"));
			
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			resClose();
		}
		return list;
	}

	// 이용 후기 삭제 요청
	public int delete(int review_no) {
		int place_no = 0;
		String sql = "SELECT place_no FROM review WHERE review_no = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, review_no);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				place_no = rs.getInt("place_no");
			}
			
			sql = "DELETE FROM review WHERE review_no = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, review_no);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		return place_no;
	}

	// 이용 후기 수정 요청
	public int update(int review_no, String review_content) {
		int success = 0;
		String sql = "UPDATE review SET review_content = ? WHERE review_no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, review_content);
			ps.setInt(2, review_no);
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		return success;
	}
}
