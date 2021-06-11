package com.matara.user;

public class UserBean {

	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private String user_mail;
	private int user_div;
	private int idchk_result;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_mail() {
		return user_mail;
	}
	public void setUser_mail(String user_mail) {
		this.user_mail = user_mail;
	}
	
	
	public int getUser_div() {
		return user_div;
	}
	public void setUser_div(int user_div) {
		this.user_div = user_div;
	}
	public int getIdchk_result() {
		return idchk_result;
	}
	public void setIdchk_result(int idchk_result) {
		this.idchk_result = idchk_result;
	}
	@Override
	public String toString() {
		return "UserDTO [user_id=" + user_id + ", user_pw=" + user_pw + ", user_name=" + user_name + ", user_phone="
				+ user_phone + ", user_mail=" + user_mail + ", user_div=" + user_div + ", idchk_result="
				+ idchk_result + "]";
	}
	
	
	
	
		
		
		
}




