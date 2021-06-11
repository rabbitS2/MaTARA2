package com.matara.user;

public class RentshopBean {


	private int rentshop_info_idx;
	private String user_id;
	private String rentshop_info_name;
	private String rentshop_info_tel;
	private String rentshop_info_addr;
	private String rentshop_info_x;
	private String rentshop_info_y;
	private int rentshop_info_total;
	private int rentshop_info_abike;
	private int rentshop_info_kbike;
	private int rentshop_info_tbike;
	private String keyword;
	
	
	public int getRentshop_info_idx() {
		return rentshop_info_idx;
	}
	public void setRentshop_info_idx(int rentshop_info_idx) {
		this.rentshop_info_idx = rentshop_info_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getRentshop_info_name() {
		return rentshop_info_name;
	}
	public void setRentshop_info_name(String rentshop_info_name) {
		this.rentshop_info_name = rentshop_info_name;
	}
	public String getRentshop_info_tel() {
		return rentshop_info_tel;
	}
	public void setRentshop_info_tel(String rentshop_info_tel) {
		this.rentshop_info_tel = rentshop_info_tel;
	}
	public String getRentshop_info_addr() {
		return rentshop_info_addr;
	}
	public void setRentshop_info_addr(String rentshop_info_addr) {
		this.rentshop_info_addr = rentshop_info_addr;
	}
	public String getRentshop_info_x() {
		return rentshop_info_x;
	}
	public void setRentshop_info_x(String rentshop_info_x) {
		this.rentshop_info_x = rentshop_info_x;
	}
	public String getRentshop_info_y() {
		return rentshop_info_y;
	}
	public void setRentshop_info_y(String rentshop_info_y) {
		this.rentshop_info_y = rentshop_info_y;
	}
	public int getRentshop_info_total() {
		return rentshop_info_total;
	}
	public void setRentshop_info_total(int rentshop_info_total) {
		this.rentshop_info_total = rentshop_info_total;
	}
	public int getRentshop_info_abike() {
		return rentshop_info_abike;
	}
	public void setRentshop_info_abike(int rentshop_info_abike) {
		this.rentshop_info_abike = rentshop_info_abike;
	}
	public int getRentshop_info_kbike() {
		return rentshop_info_kbike;
	}
	public void setRentshop_info_kbike(int rentshop_info_kbike) {
		this.rentshop_info_kbike = rentshop_info_kbike;
	}
	public int getRentshop_info_tbike() {
		return rentshop_info_tbike;
	}
	public void setRentshop_info_tbike(int rentshop_info_tbike) {
		this.rentshop_info_tbike = rentshop_info_tbike;
	}
	@Override
	public String toString() {
		return "RentshopBean [rentshop_info_idx=" + rentshop_info_idx + ", user_id=" + user_id + ", rentshop_info_name="
				+ rentshop_info_name + ", rentshop_info_tel=" + rentshop_info_tel + ", rentshop_info_addr="
				+ rentshop_info_addr + ", rentshop_info_x=" + rentshop_info_x + ", rentshop_info_y=" + rentshop_info_y
				+ ", rentshop_info_total=" + rentshop_info_total + ", rentshop_info_abike=" + rentshop_info_abike
				+ ", rentshop_info_kbike=" + rentshop_info_kbike + ", rentshop_info_tbike=" + rentshop_info_tbike + "]";
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
	
	
		
}
