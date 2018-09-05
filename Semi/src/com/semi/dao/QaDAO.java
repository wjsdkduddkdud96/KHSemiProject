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

public class QaDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	// DB 접속
	public QaDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Q&A 쓰기(완)
	public int write(DTO dto) {
		String sql = "INSERT INTO qa VALUES (qa_seq.NEXTVAL, ?, ?, ?, SYSDATE, ?)";
		int success = 0; 
		
		try {
			ps = conn.prepareStatement(sql, new String[] {"qa_no"});
			ps.setInt(1, dto.getPlace_no());
			ps.setString(2, dto.getInfo_id());
			ps.setString(3, dto.getQa_content());
			ps.setString(4, dto.getQa_title());
			
			success= ps.executeUpdate();
			rs = ps.getGeneratedKeys();
		
			if(rs.next()) {
				dto.setQa_no((int)rs.getLong(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		return success;
	}

	// Q&A 리스트 (완)
	public ArrayList<DTO> list(int place_no, int start, int end) {
		ArrayList<DTO> list = new ArrayList<>();
		String sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY qa_no DESC) AS rnum," 
			    			+"qa_no, qa_title, qa_date, info_id FROM qa WHERE place_no = ?)"
			    				+"WHERE rnum BETWEEN ? AND ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			ps.setInt(2, start);
			ps.setInt(3, end);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setRnum(rs.getInt("rnum"));
				dto.setQa_no(rs.getInt("qa_no"));
				dto.setQa_title(rs.getString("qa_title"));
				dto.setQa_date(rs.getDate("qa_date"));
				dto.setInfo_id(rs.getString("info_id"));
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

	// Q&A 상세보기 (완)
	public DTO detail(int qa_no) {
		String sql = "SELECT * FROM qa WHERE qa_no = ?";
		DTO dto = new DTO();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qa_no);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dto.setQa_no(rs.getInt("qa_no"));
				dto.setPlace_no(rs.getInt("place_no"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setQa_title(rs.getString("qa_title"));
				dto.setQa_content(rs.getString("qa_content"));
				dto.setQa_date(rs.getDate("qa_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			resClose();
		}
		return dto;
	}

	// Q&A 업데이트(완)
	public int update(DTO dto) {
		String sql = "UPDATE qa SET qa_title = ?, qa_content = ? WHERE qa_no = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getQa_title());
			ps.setString(2, dto.getQa_content());
			ps.setInt(3, dto.getQa_no());
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0; 
		} finally {
			resClose();
		}
		return success;
	}

	// Q&A 삭제(완)
	public int delete(int qa_no) {
			int place_no = 0;
			String sql = "SELECT place_no FROM qa WHERE qa_no = ?";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, qa_no);
				rs = ps.executeQuery();
				
				if(rs.next()) {
					place_no = rs.getInt("place_no");
				}
				
				sql = "DELETE FROM qa WHERE qa_no = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, qa_no);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			} finally {
				resClose();
			}
			return place_no;
	}

	// Q&A 답변 쓰기(완)
	public int qaReplyWrite(DTO dto) {
		String sql = "INSERT INTO qareply(qareply_no, qa_no, info_id, qareply_content, qareply_date) VALUES (qa_reply_seq.NEXTVAL, ?, ?, ?, SYSDATE)";
		int success = 0;
		
		try {
			ps = conn.prepareStatement(sql, new String[] {"qareply_no"});
			// ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getQa_no());
			ps.setString(2, dto.getInfo_id());
			ps.setString(3, dto.getQareply_content());
			
			success = ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			
			if(rs.next()) {
				dto.setQareply_no(rs.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		return success;
	}

	// Q&A 답글 리스트(완)
	public ArrayList<DTO> qaReplyList(int qa_no) {
		ArrayList<DTO> list = new ArrayList<>();
		
		String sql = "SELECT info_id, qareply_no, qareply_content FROM qareply WHERE qa_no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qa_no);
		
			rs = ps.executeQuery();
		
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setInfo_id(rs.getString("info_id"));
				dto.setQareply_no(rs.getInt("qareply_no"));
				dto.setQareply_content(rs.getString("qareply_content"));
			
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

	// Q&A 답글 삭제(완)
	public int qaReplyDelete(int qareply_no) {
		int qa_no = 0;
		String sql = "SELECT qa_no FROM qareply WHERE qareply_no = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qareply_no);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				qa_no = rs.getInt("qa_no");
			}
			
			sql = "DELETE FROM qareply WHERE qareply_no = ?";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, qareply_no);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		return qa_no;
	}

	// Q&A 답글 수정(완)
	public int qaReplyUpdate(int qareply_no, String qareply_content) {
		int qa_no = 0;
		String sql = "SELECT qa_no FROM qareply WHERE qareply_no = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qareply_no);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				qa_no = rs.getInt("qa_no");
			}
			
			sql = "UPDATE qareply SET qareply_content = ? WHERE qareply_no = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, qareply_content);
			ps.setInt(2, qareply_no);
			
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		return qa_no;
	}

	// 자원 반납
	public void resClose() {
		try {
			if(rs != null) {rs.close();}
			if(ps != null) {ps.close();}
			if(conn != null) {conn.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int listSize(int place_no) {
		int max_size = 0;
		String sql = "SELECT COUNT(*) FROM qa WHERE place_no = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				max_size = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally {
			resClose();
		}
		
		return max_size;
	}

	// Q&A 검색 요청
	public ArrayList<DTO> search(int place_no, String search_keyword) {
		ArrayList<DTO> list = new ArrayList<>();
		String sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY qa_no DESC) AS rnum," 
					+"qa_no, qa_title, qa_date, info_id FROM qa WHERE place_no = ?)"
						+"WHERE qa_title LIKE ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			ps.setString(2, "%"+search_keyword+"%");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setRnum(rs.getInt("rnum"));
				dto.setQa_no(rs.getInt("qa_no"));
				dto.setQa_title(rs.getString("qa_title"));
				dto.setQa_date(rs.getDate("qa_date"));
				dto.setInfo_id(rs.getString("info_id"));
				
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
}