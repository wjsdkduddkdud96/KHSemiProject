package com.semi.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class DTO {
	//게시판
	private int rnum;
	private int board_no;
	private String board_title;
	private String board_content;
	private Date board_date;
	private String board_category;

	//회원정보
	private String info_id;
	private String info_pw;
	private Date info_birth;
	private String info_email;
	private String info_gender;
	private String info_name;
	private String info_div;
	private String info_num;
	private String info_phone;
	
	//장소등록
	private int place_no;
	private String place_name;
	private String place_info;
	private String place_home;
	private String place_loc;
	private String place_guide;
	private String place_attention;
	private Timestamp place_date;
	private String place_category;
	private String place_photo;
	private String place_start;
	private String place_end;
	private long place_price;
	private String place_phone;
	
	//예약
	private int book_no;
	private Date book_date;
	private String book_start;
	private String book_end;
	private long book_price;
	private int book_custom;
	
	//답글
	private int reply_no;
	private Date reply_date;
	private String reply_content;
	
	//찜하기
	private int like_no;
	
	//후기
	private int review_no;
	private String review_content;
	private Date review_date;
	private double review_score;
	
	//QA
	private int qa_no;
	private String qa_content;
	private Date qa_date;
	private String qa_title;
	
	//QA답글
	private int qareply_no;
	private String qareply_content;
	private Date qareply_date;
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public Date getBoard_date() {
		return board_date;
	}
	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	public String getInfo_id() {
		return info_id;
	}
	public void setInfo_id(String info_id) {
		this.info_id = info_id;
	}
	public String getInfo_pw() {
		return info_pw;
	}
	public void setInfo_pw(String info_pw) {
		this.info_pw = info_pw;
	}
	public Date getInfo_birth() {
		return info_birth;
	}
	public void setInfo_birth(Date info_birth) {
		this.info_birth = info_birth;
	}
	public String getInfo_email() {
		return info_email;
	}
	public void setInfo_email(String info_email) {
		this.info_email = info_email;
	}
	public String getInfo_gender() {
		return info_gender;
	}
	public void setInfo_gender(String info_gender) {
		this.info_gender = info_gender;
	}
	public String getInfo_name() {
		return info_name;
	}
	public void setInfo_name(String info_name) {
		this.info_name = info_name;
	}
	public String getInfo_div() {
		return info_div;
	}
	public void setInfo_div(String info_div) {
		this.info_div = info_div;
	}
	public String getInfo_num() {
		return info_num;
	}
	public void setInfo_num(String info_num) {
		this.info_num = info_num;
	}
	public String getInfo_phone() {
		return info_phone;
	}
	public void setInfo_phone(String info_phone) {
		this.info_phone = info_phone;
	}
	public int getPlace_no() {
		return place_no;
	}
	public void setPlace_no(int place_no) {
		this.place_no = place_no;
	}
	public String getPlace_phone() {
		return place_phone;
	}
	public void setPlace_phone(String place_phone) {
		this.place_phone = place_phone;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public String getPlace_info() {
		return place_info;
	}
	public void setPlace_info(String place_info) {
		this.place_info = place_info;
	}
	public String getPlace_home() {
		return place_home;
	}
	public void setPlace_home(String place_home) {
		this.place_home = place_home;
	}
	public String getPlace_loc() {
		return place_loc;
	}
	public void setPlace_loc(String place_loc) {
		this.place_loc = place_loc;
	}
	public String getPlace_guide() {
		return place_guide;
	}
	public void setPlace_guide(String place_guide) {
		this.place_guide = place_guide;
	}
	public String getPlace_attention() {
		return place_attention;
	}
	public void setPlace_attention(String place_attention) {
		this.place_attention = place_attention;
	}
	public Timestamp getPlace_date() {
		return place_date;
	}
	public void setPlace_date(Timestamp place_date) {
		this.place_date = place_date;
	}
	public String getPlace_category() {
		return place_category;
	}
	public void setPlace_category(String place_category) {
		this.place_category = place_category;
	}
	public String getPlace_photo() {
		return place_photo;
	}
	public void setPlace_photo(String place_photo) {
		this.place_photo = place_photo;
	}
	public String getPlace_start() {
		return place_start;
	}
	public void setPlace_start(String place_start) {
		this.place_start = place_start;
	}
	public String getPlace_end() {
		return place_end;
	}
	public void setPlace_end(String place_end) {
		this.place_end = place_end;
	}
	public long getPlace_price() {
		return place_price;
	}
	public void setPlace_price(long place_price) {
		this.place_price = place_price;
	}
	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}
	public Date getBook_date() {
		return book_date;
	}
	public void setBook_date(Date book_date) {
		this.book_date = book_date;
	}
	public String getBook_start() {
		return book_start;
	}
	public void setBook_start(String book_start) {
		this.book_start = book_start;
	}
	public String getBook_end() {
		return book_end;
	}
	public void setBook_end(String book_end) {
		this.book_end = book_end;
	}
	public long getBook_price() {
		return book_price;
	}
	public void setBook_price(long book_price) {
		this.book_price = book_price;
	}
	public int getBook_custom() {
		return book_custom;
	}
	public void setBook_custom(int book_custom) {
		this.book_custom = book_custom;
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public Date getReply_date() {
		return reply_date;
	}
	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public int getLike_no() {
		return like_no;
	}
	public void setLike_no(int like_no) {
		this.like_no = like_no;
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public Date getReview_date() {
		return review_date;
	}
	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}
	public int getQa_no() {
		return qa_no;
	}
	public void setQa_no(int qa_no) {
		this.qa_no = qa_no;
	}
	public String getQa_content() {
		return qa_content;
	}
	public void setQa_content(String qa_content) {
		this.qa_content = qa_content;
	}
	public Date getQa_date() {
		return qa_date;
	}
	public void setQa_date(Date qa_date) {
		this.qa_date = qa_date;
	}
	public int getQareply_no() {
		return qareply_no;
	}
	public void setQareply_no(int qareply_no) {
		this.qareply_no = qareply_no;
	}
	public String getQareply_content() {
		return qareply_content;
	}
	public void setQareply_content(String qareply_content) {
		this.qareply_content = qareply_content;
	}
	public Date getQareply_date() {
		return qareply_date;
	}
	public void setQareply_date(Date qareply_date) {
		this.qareply_date = qareply_date;
	}
	public String getQa_title() {
		return qa_title;
	}
	public void setQa_title(String qa_title) {
		this.qa_title = qa_title;
	}
	public double getReview_score() {
		return review_score;
	}
	public void setReview_score(double review_score) {
		this.review_score = review_score;
	}
	
	//getter, setter
	
	
	
}
