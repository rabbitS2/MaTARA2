package com.matara.board;

import java.sql.Date;

public class TravelBean {


	private int travel_id;
	private int bg_id;
	private String user_id;
	private String travel_sub;
	private String travel_content;
	private int travel_readcount;
	private Date travel_date;
	private String travel_ip;
	private String file_name;
	
	
	
	public int getTravel_id() {
		return travel_id;
	}
	public void setTravel_id(int travel_id) {
		this.travel_id = travel_id;
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
	public String getTravel_sub() {
		return travel_sub;
	}
	public void setTravel_sub(String travel_sub) {
		this.travel_sub = travel_sub;
	}
	public String getTravel_content() {
		return travel_content;
	}
	public void setTravel_content(String travel_content) {
		this.travel_content = travel_content;
	}
	public int getTravel_readcount() {
		return travel_readcount;
	}
	public void setTravel_readcount(int travel_readcount) {
		this.travel_readcount = travel_readcount;
	}
	public Date getTravel_date() {
		return travel_date;
	}
	public void setTravel_date(Date travel_date) {
		this.travel_date = travel_date;
	}
	public String getTravel_ip() {
		return travel_ip;
	}
	public void setTravel_ip(String travel_ip) {
		this.travel_ip = travel_ip;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	@Override
	public String toString() {
		return "TravelBean [travel_id=" + travel_id + ", bg_id=" + bg_id + ", user_id=" + user_id + ", travel_sub="
				+ travel_sub + ", travel_content=" + travel_content + ", travel_readcount=" + travel_readcount
				+ ", travel_date=" + travel_date + ", travel_ip=" + travel_ip + ", file_name=" + file_name + "]";
	}
	
	
	
	
	
	
}
