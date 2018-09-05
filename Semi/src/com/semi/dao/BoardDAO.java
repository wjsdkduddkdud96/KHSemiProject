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

public class BoardDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	//DB 접속
	public BoardDAO() {
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
	
	//문의사항 제목 검색,문의사항 리스트
	public ArrayList<DTO> search(String search, String board_category, int i, int j) {
		ArrayList<DTO> list = new ArrayList<DTO>();
		String sql = "SELECT rnum, board_no, info_id, board_title, board_content, board_date,board_category "
				+ " FROM(SELECT ROW_NUMBER() OVER(ORDER BY board_no DESC) AS rnum, " + 
				" board_no, info_id, board_title, board_content, board_date,board_category "
				+ " FROM board WHERE board_title LIKE ? AND board_category=?) " + 
				" WHERE rnum BETWEEN ? AND ? ORDER BY board_date DESC";
		System.out.println(search);
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setString(2, board_category);
			ps.setInt(3, i);
			ps.setInt(4, j);
			rs = ps.executeQuery();
			while (rs.next()) {
				DTO dto = new DTO();
				dto.setRnum(rs.getInt("rnum"));
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_date(rs.getDate("board_date"));
				dto.setBoard_category(rs.getString("board_category"));
				System.out.println(dto.getBoard_no()+"/"+dto.getBoard_date());
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return list;
	}
	

	//상세보기
	public DTO detail(int i) { //resClose 없음
		DTO dto = null;
		String sql = "SELECT * FROM board WHERE board_no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,(i));
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new DTO();
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_date(rs.getDate("board_date"));
				dto.setBoard_category(rs.getString("board_category"));				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			/*resClose();*/
		}
		return dto;
	}

	//문의사항 수정
	public Integer update(String board_no, String board_title, String board_content) {
		int success=0;
		String sql="UPDATE board SET board_title=?, board_content=? WHERE board_no=? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_title);
			ps.setString(2, board_content);
			ps.setInt(3, Integer.parseInt(board_no));
			success = ps.executeUpdate();
			System.out.println(success);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
		
	}

	// 문의사항 삭제
	public int delete(String board_no) {
		String sql = "DELETE FROM board WHERE board_no =?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(board_no));
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return success;
	}

	//문의사항 글쓰기
	public int write(DTO dto, String title, String content, String category) {
		String sql = "INSERT INTO board(board_no, info_id, board_title, board_content,board_date,board_category) "
				+ "VALUES(seq_boardno.NEXTVAL, ?, ? ,?,SYSDATE,?)";
		int result = 0;
		try {
			ps = conn.prepareStatement(sql, new String[] {"board_no"});
			ps.setString(1, dto.getInfo_id());
			ps.setString(2, title);
			ps.setString(3, content);
			ps.setString(4, category);
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				result = (int) rs.getLong(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return result;
	}

	//답글 쓰기
	public int replyWrite(DTO dto, String board_no, String answerTxt) {
		String sql = "INSERT INTO reply(reply_no, info_id, board_no, reply_date, reply_content) "
				+ " VALUES(replyno_seq.NEXTVAL, ?, ?, sysdate, ?)";
		int result = 0;
		try {
			ps = conn.prepareStatement(sql, new String[] {"reply_no"});
			ps.setString(1, dto.getInfo_id());
			ps.setInt(2, Integer.parseInt(board_no));
			ps.setString(3, answerTxt);
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				result = (int) rs.getLong(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return result;
	}

	//답글 리스트
	public ArrayList<DTO> reDetail(int i) {
		ArrayList<DTO> list = new ArrayList<DTO>();
		/*String sql = "SELECT * FROM reply WHERE board_no=? ORDER BY reply_no";*/
		String sql = "SELECT rnum,reply_no,info_id,board_no,reply_date,reply_content "
				+ "FROM(SELECT ROW_NUMBER() OVER(ORDER BY reply_no DESC) AS rnum, "+ 
				" reply_no,info_id,board_no,reply_date,reply_content " + 
				" FROM reply) reply WHERE board_no=? ORDER BY reply_no";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,i);
			rs = ps.executeQuery();
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setRnum(rs.getInt("rnum"));
				dto.setReply_no(rs.getInt("reply_no"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setReply_date(rs.getDate("reply_date"));
				dto.setReply_content(rs.getString("reply_content"));			
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}

	//문의사항 답글 수정
	public Integer replyUpdate(String reply_no, String reply) {
		int success=0;
		String sql="UPDATE reply SET reply_content=? WHERE reply_no=? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, reply);
			ps.setInt(2, Integer.parseInt(reply_no));
			success = ps.executeUpdate();
			System.out.println(success);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	//문의사항 답글 삭제
	public Integer replyDelete(String reply_no) {
		String sql = "DELETE FROM reply WHERE reply_no =?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(reply_no));
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return success;
	}
	

}
