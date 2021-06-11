package com.matara.comment;

import java.sql.Date;

public class CommentBean {

	private int comment_idx;
	private int commu_id;
	private String user_id;
	private String comment_content;
	private int comment_re_ref;
	private int comment_re_lev;
	private int comment_re_seq;
	private Date comment_date;
	private String comment_ip;
	private String file_name;
	
	
	
	public int getComment_idx() {
		return comment_idx;
	}
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}
	public int getCommu_id() {
		return commu_id;
	}
	public void setCommu_id(int commu_id) {
		this.commu_id = commu_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public int getComment_re_ref() {
		return comment_re_ref;
	}
	public void setComment_re_ref(int comment_re_ref) {
		this.comment_re_ref = comment_re_ref;
	}
	public int getComment_re_lev() {
		return comment_re_lev;
	}
	public void setComment_re_lev(int comment_re_lev) {
		this.comment_re_lev = comment_re_lev;
	}
	public int getComment_re_seq() {
		return comment_re_seq;
	}
	public void setComment_re_seq(int comment_re_seq) {
		this.comment_re_seq = comment_re_seq;
	}
	public Date getComment_date() {
		return comment_date;
	}
	public void setComment_date(Date comment_date) {
		this.comment_date = comment_date;
	}
	public String getComment_ip() {
		return comment_ip;
	}
	public void setComment_ip(String comment_ip) {
		this.comment_ip = comment_ip;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	@Override
	public String toString() {
		return "commentBean [comment_idx=" + comment_idx + ", commu_id=" + commu_id + ", user_id=" + user_id
				+ ", comment_content=" + comment_content + ", comment_re_ref=" + comment_re_ref + ", comment_re_lev="
				+ comment_re_lev + ", comment_re_seq=" + comment_re_seq + ", comment_date=" + comment_date
				+ ", comment_ip=" + comment_ip + ", file_name=" + file_name + "]";
	}
	
	
	
}
