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

public class PlaceDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	// DB 접속
	public PlaceDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 자원반납
	public void resClose() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<DTO> search(int start, int end, String keyword, String category, String loc) {
		ArrayList<DTO> list = new ArrayList<DTO>();
		int addSQL = 1;

		/*
		 * SELECT place_no, place_name, place_intro, place_category, place_loc FROM
		 * (SELECT ROW_NUMBER() OVER(ORDER BY place_no DESC) AS rnum, place_no,
		 * place_name, place_intro, place_category, place_loc FROM place WHERE
		 * place_category = '카테고리' AND place_loc = '%지역%' AND (place_name || place_intro) LIKE '%검색_키워드%'
		 * ) WHERE (rnum BETWEEN 1 AND 2);
		 */

		String sql = "SELECT place_no, place_name, place_intro, place_category, place_loc"
				+ " FROM (SELECT ROW_NUMBER() OVER(ORDER BY place_no DESC) AS rnum, place_no, place_name, place_intro, place_category, place_loc  FROM place";
		if (!category.equals("none") || !loc.equals("none") || !keyword.equals("none")) {
			sql += " WHERE ";
			if (!category.equals("none")) {
				sql += " place_category = ?";
				addSQL++;
			}
			if (!loc.equals("none")) {
				if(addSQL>1) {
					sql+=" AND ";
				}
				addSQL++;
				sql += " place_loc LIKE ?";
			}
			if (!keyword.equals("none")) {
				if(addSQL>1) {
					sql+=" AND ";
				}
				addSQL++;
				sql += " (place_name || place_intro) LIKE ?";
				// set string 시 %% 추가해야한다.
			}
		}
		
		sql += ") WHERE (rnum BETWEEN ? AND ?)";
		
		addSQL=1;
		try {
			ps = conn.prepareStatement(sql);
			if (!category.equals("none")) {
				ps.setString(addSQL, category);
				addSQL++;
			}
			if (!loc.equals("none")) {
				ps.setString(addSQL,  "%" +loc+ "%");
				addSQL++;
			}
			if (!keyword.equals("none")) {
				ps.setString(addSQL, "%" + keyword + "%");
				addSQL++;
			}
			ps.setInt(addSQL, start);
			ps.setInt(addSQL+1, end);

			rs = ps.executeQuery();

			while (rs.next()) {
				ResultSet placeRs = null;
				DTO dto = new DTO();
				dto.setPlace_no(rs.getInt("place_no"));
				dto.setPlace_name(rs.getString("place_name"));
				dto.setPlace_info(rs.getString("place_intro"));
				dto.setPlace_category(rs.getString("place_category"));
				dto.setPlace_loc(rs.getString("place_loc"));

				String infoSql = "SELECT * FROM placeinfo WHERE place_no=?";
				ps = conn.prepareStatement(infoSql);
				ps.setInt(1, rs.getInt("place_no"));
				placeRs = ps.executeQuery();
				if (placeRs.next()) {
					dto.setPlace_price(placeRs.getLong("place_price"));
				}

				infoSql = "SELECT * FROM photo WHERE place_no=?";
				ps = conn.prepareStatement(infoSql);
				ps.setInt(1, rs.getInt("place_no"));
				placeRs = ps.executeQuery();
				if (placeRs.next()) {
					dto.setPlace_photo(placeRs.getString("place_photo"));
				}

				if (placeRs != null) {
					placeRs.close();
				}
				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return list;
	}

	public long write(DTO dto) { //resClose 없음
	String sql="INSERT INTO place(place_no,info_id,place_name,place_intro,place_home,"+
			"place_loc,place_guid,place_attention,place_date,place_category,place_tel)"+" VALUES(place_seq.NEXTVAL,?,?,?,?,?,?,?,SYSDATE,?,?)";
				long success=0;
				try {
					ps=conn.prepareStatement(sql,new String[] {"place_no"});
					ps.setString(1, dto.getInfo_id());
					ps.setString(2, dto.getPlace_name());
					ps.setString(3, dto.getPlace_info());
					ps.setString(4, dto.getPlace_home());
					ps.setString(5, dto.getPlace_loc());
					ps.setString(6, dto.getPlace_guide());
					ps.setString(7, dto.getPlace_attention());
					ps.setString(8, dto.getPlace_category());
					ps.setString(9, dto.getPlace_phone());
					int a=ps.executeUpdate();
					System.out.println(a+"place 성공여부");
					rs = ps.getGeneratedKeys();
					if(rs.next()) {
						success = rs.getLong(1);
						sql="INSERT INTO placeinfo(place_no,place_start,place_end,place_price) VALUES(?,to_date(?,'hh24:mi'),to_date(?,'hh24:mi'),?)";
						ps=conn.prepareStatement(sql);
						ps.setLong(1, success);
						ps.setString(2, dto.getPlace_start());
						ps.setString(3, dto.getPlace_end());
						ps.setLong(4, dto.getPlace_price());
						int b=ps.executeUpdate();
						System.out.println(b+"place_info 성공여부");
						
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return success;
	}

	public void photowrite(ArrayList<DTO> list, long success) {
		DTO dto;
		String sql;
		//String savepath="D:/04_semi_project/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/04_semiProject/upload/";
		for(int i=0;i<list.size();i++) {
			dto=list.get(i);
			String fileName = dto.getPlace_photo();
			System.out.println("fileName"+fileName);
			if(success>0) {
				sql = "INSERT INTO photo (place_no,place_photo)"
						+"VALUES(?,?)";
				try {
					ps=conn.prepareStatement(sql);
					ps.setLong(1, success);
					ps.setString(2, fileName);
					ps.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
			}
			}
		}resClose();
	}

	public int likeDel(String[] like_id) {
		int delCnt=0;
		String sql = "DELETE FROM likeTb WHERE like_no=?";
		try {
			for(int i=0; i<like_id.length;i++) {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(like_id[i]));
				delCnt += ps.executeUpdate();
				ps.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return delCnt;
	}

	public ArrayList<DTO> detailphoto(String number) {
		
		ArrayList<DTO> list=new ArrayList<>();
		String sql="SELECT * FROM photo WHERE place_no = ?";
		try {
			ps  = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(number));
			rs = ps.executeQuery();
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setPlace_photo(rs.getString("place_photo"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}

	public int delete(int p_id) {
		int success = 0;
		String sql = "DELETE FROM place WHERE place_no=?";
		try {
			sql = "DELETE FROM place WHERE place_no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_id);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	public DTO detail(int place_no) {
		System.out.println("DAO-place_no : "+place_no);
		DTO dto = new DTO();
		String sql ="SELECT * FROM place WHERE place_no =?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			rs = ps.executeQuery();
			if(rs.next()) {				
				dto.setPlace_no(rs.getInt("place_no"));
				dto.setInfo_id(rs.getString("info_id"));
				dto.setPlace_name(rs.getString("place_name"));
				dto.setPlace_info(rs.getString("place_intro"));
				dto.setPlace_home(rs.getString("place_home"));
				dto.setPlace_loc(rs.getString("place_loc"));
				dto.setPlace_guide(rs.getString("place_guid"));
				dto.setPlace_attention(rs.getString("place_attention"));
				dto.setPlace_category(rs.getString("place_category"));
				dto.setPlace_phone(rs.getString("place_tel"));
				sql="SELECT*FROM placeinfo WHERE place_no=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, place_no);
				rs=ps.executeQuery();
				if(rs.next()) {
					dto.setPlace_start(rs.getString("place_start"));
					dto.setPlace_end(rs.getString("place_end"));
					dto.setPlace_price(rs.getLong("place_price"));
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			resClose();
		}
		return dto;
	}

	public int like(int place_no, String id) {
		int success =0;
		String sql = "INSERT INTO likeTb(like_no,place_no,info_id) VALUES(like_seq.NEXTVAL,?,?)";
		try {
			ps =conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			ps.setString(2, id);
			success=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}		
		return success;
	}

	public int detaillikedel(int place_no, String id) {
		int success =0;
		String sql = "DELETE FROM likeTb WHERE place_no=? AND info_id=?";
		try {
			ps =conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			ps.setString(2, id);
			success=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}		
		return success;
	}

	public boolean detaillike(int place_no, String id) {
		String sql = "SELECT * FROM likeTb WHERE place_no=? AND info_id=?";
		boolean success= false;
		try {
			ps =conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			ps.setString(2, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				success=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	public DTO updatedetail(int place_no) { //resClose 없음
		System.out.println("DAO-place_no : "+place_no);
		DTO dto = new DTO();
		String sql ="SELECT * FROM place WHERE place_no =?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			rs = ps.executeQuery();
			if(rs.next()) {				
				dto.setPlace_no(rs.getInt("place_no"));
				dto.setPlace_name(rs.getString("place_name"));
				dto.setPlace_info(rs.getString("place_intro"));
				dto.setPlace_home(rs.getString("place_home"));
				dto.setPlace_loc(rs.getString("place_loc"));
				dto.setPlace_guide(rs.getString("place_guid"));
				dto.setPlace_attention(rs.getString("place_attention"));
				dto.setPlace_category(rs.getString("place_category"));
				dto.setPlace_phone(rs.getString("place_tel"));
				sql="SELECT*FROM placeinfo WHERE place_no=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, place_no);
				rs=ps.executeQuery();
				if(rs.next()) {
					dto.setPlace_start(rs.getString("place_start"));
					dto.setPlace_end(rs.getString("place_end"));
					dto.setPlace_price(rs.getLong("place_price"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dto;
	}

	public ArrayList<DTO> updatephoto(int place_no) {
		ArrayList<DTO> list=new ArrayList<>();
		String sql="SELECT * FROM photo WHERE place_no = ?";
		try {
			ps  = conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			rs = ps.executeQuery();
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setPlace_photo(rs.getString("place_photo"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}

	public long update(DTO dto) { //resClose 없음
		String sql="UPDATE place SET place_name=?,place_intro=?,place_home=?,"+
				"place_loc=?,place_guid=?,place_attention=?,place_category=?,place_tel=?"+"WHERE place_no=? AND info_id=?";
					long success=dto.getPlace_no();
					try {
						ps=conn.prepareStatement(sql,new String[] {"place_no"});
						ps.setString(1, dto.getPlace_name());
						ps.setString(2, dto.getPlace_info());
						ps.setString(3, dto.getPlace_home());
						ps.setString(4, dto.getPlace_loc());
						ps.setString(5, dto.getPlace_guide());
						ps.setString(6, dto.getPlace_attention());
						ps.setString(7, dto.getPlace_category());
						ps.setString(8, dto.getPlace_phone());
						ps.setInt(9, dto.getPlace_no());
						ps.setString(10, dto.getInfo_id());
						int a=ps.executeUpdate();
						System.out.println(a+"placeupdate 성공여부");
						sql="UPDATE placeinfo SET place_start=to_date(?,'hh24:mi'),place_end=to_date(?,'hh24:mi'),place_price=?"+"WHERE place_no=?";;
						ps=conn.prepareStatement(sql);							
						ps.setString(1, dto.getPlace_start());
						ps.setString(2, dto.getPlace_end());
						ps.setLong(3, dto.getPlace_price());
						ps.setLong(4, dto.getPlace_no());
						int b=ps.executeUpdate();
						System.out.println(b+"place_info 성공여부");
					} catch (SQLException e) {
						e.printStackTrace();
					}
					return success;
	}

	public ArrayList<DTO> writeupdatephoto(int place_no) { //resClose 없음
		ArrayList<DTO> list=new ArrayList<>();
		String sql="SELECT * FROM photo WHERE place_no = ?";
		try {
			ps  = conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			rs = ps.executeQuery();
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setPlace_photo(rs.getString("place_photo"));
				list.add(dto);
			}
			sql="DELETE FROM photo WHERE place_no=?";
			ps  = conn.prepareStatement(sql);
			ps.setInt(1, place_no);
			int count=ps.executeUpdate();
			System.out.println("사진삭제쿼리"+count);
			if(count<=0) {
				list=null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
