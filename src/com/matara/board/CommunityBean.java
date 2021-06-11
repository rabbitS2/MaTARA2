package com.matara.board;

import java.sql.Date;

public class CommunityBean {
	
	private int commu_id;
	private int bg_id;
	private String user_id;
	private String commu_category;
	private String commu_sub;
	private String commu_content;
	private int commu_readcount;
	private int commu_re_ref;
	private int commu_re_lev;
	private int commu_re_seq;
	private Date commu_date;
	private String commu_ip;
	private String file_name;
	
	
	
	public int getCommu_id() {
		return commu_id;
	}
	public void setCommu_id(int commu_id) {
		this.commu_id = commu_id;
	}
	public int getBg_id() {
		return bg_id;
	}
	public void setBg_id(int bg_id) {
		this.bg_id = bg_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCommu_category() {
		return commu_category;
	}
	public void setCommu_category(String commu_category) {
		this.commu_category = commu_category;
	}
	public String getCommu_sub() {
		return commu_sub;
	}
	public void setCommu_sub(String commu_sub) {
		this.commu_sub = commu_sub;
	}
	public String getCommu_content() {
		return commu_content;
	}
	public void setCommu_content(String commu_content) {
		this.commu_content = commu_content;
	}
	public int getCommu_readcount() {
		return commu_readcount;
	}
	public void setCommu_readcount(int commu_readcount) {
		this.commu_readcount = commu_readcount;
	}
	public int getCommu_re_ref() {
		return commu_re_ref;
	}
	public void setCommu_re_ref(int commu_re_ref) {
		this.commu_re_ref = commu_re_ref;
	}
	public int getCommu_re_lev() {
		return commu_re_lev;
	}
	public void setCommu_re_lev(int commu_re_lev) {
		this.commu_re_lev = commu_re_lev;
	}
	public int getCommu_re_seq() {
		return commu_re_seq;
	}
	public void setCommu_re_seq(int commu_re_seq) {
		this.commu_re_seq = commu_re_seq;
	}
	public Date getCommu_date() {
		return commu_date;
	}
	public void setCommu_date(Date commu_date) {
		this.commu_date = commu_date;
	}
	public String getCommu_ip() {
		return commu_ip;
	}
	public void setCommu_ip(String commu_ip) {
		this.commu_ip = commu_ip;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	@Override
	public String toString() {
		return "CommunityBean [commu_id=" + commu_id + ", bg_id=" + bg_id + ", user_id=" + user_id + ", commu_category="
				+ commu_category + ", commu_sub=" + commu_sub + ", commu_content=" + commu_content
				+ ", commu_readcount=" + commu_readcount + ", commu_re_ref=" + commu_re_ref + ", commu_re_lev="
				+ commu_re_lev + ", commu_re_seq=" + commu_re_seq + ", commu_date=" + commu_date + ", commu_ip="
				+ commu_ip + ", file_name=" + file_name + "]";
	}
	
	
	

	
}
