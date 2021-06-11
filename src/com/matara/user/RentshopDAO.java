package com.matara.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;




public class RentshopDAO {

		private Connection conn = null;
		private PreparedStatement pstmt = null;
		private ResultSet rs = null;
		private String sql = "";

		private Connection getConnection() {
			try {
				// Context 객체를 생성 (프로젝트 정보를 가지고있는객체)
				Context initCTX = new InitialContext();
	
				// DB연동 정보를 불러오기(context.xml)
				DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
	
				conn = ds.getConnection();
	
				System.out.println(" 드라이버 로드, 디비연결 성공! ");
				System.out.println(conn);
	
			} catch (NamingException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	
			return conn;
		}
		// getConnection() - 디비연결 끝



	//////////////////////////////////////////////////////////////////



		// 자원해제코드 - finally 구문에서 사용
		public void closeDB() {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}



		//////////////////////////////////////////////////////////////////

		// rentshopAdd(rb)
		public void rentshopAdd(RentshopBean rb) {
			int num = 0;
			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리 하는 메서드로 변경
				conn = getConnection();

				sql = "select max(rentshop_info_idx) from rentshop_info";

				pstmt = conn.prepareStatement(sql);

				// 4 sql 실행
				rs = pstmt.executeQuery();

				if (rs.next()) {
					num = rs.getInt(1) + 1;
				}

				// 3 sql 작성 (insert) & pstmt 객체 생성
				sql = "insert into rentshop_info values(?,?,?,?,?,?,?,?,?,?,?)";

				pstmt = conn.prepareStatement(sql);

				// ?
				pstmt.setInt(1, num);
				pstmt.setString(2, rb.getUser_id());
				pstmt.setString(3, rb.getRentshop_info_name());
				pstmt.setString(4, rb.getRentshop_info_tel());
				pstmt.setString(5, rb.getRentshop_info_addr());
				pstmt.setString(6, rb.getRentshop_info_x());
				pstmt.setString(7, rb.getRentshop_info_y());
				pstmt.setInt(8, rb.getRentshop_info_total());
				pstmt.setInt(9, rb.getRentshop_info_abike());
				pstmt.setInt(10, rb.getRentshop_info_kbike());
				pstmt.setInt(11, rb.getRentshop_info_tbike());

				// 4 sql 실행

				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

		}// rentshopAdd(rub)

		//////////////////////////////////////////////////////////////////

		// getRentshopCount()
		// 디비에 들어있는 글의 개수 계산후 리턴
		public int getRentshopCount(String id) {

			int cnt = 0;

			try {
				// 1,2 드라이버로드, 디비연결
				conn = getConnection();

				// 3 sql 작성(select) & pstmt 객체 생성
				sql = "select count(*) from rentshop_info where user_id=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);

				// 4 sql 실행
				rs = pstmt.executeQuery();

				// 5 데이터 처리
				if (rs.next()) {
					cnt = rs.getInt(1);
				}

				System.out.println("SQL 구문 실행완료!");
				System.out.println(" 글 개수 : " + cnt + "개");

			} catch (Exception e) {
				System.out.println(" 게시판 글개수_에러 발생 ");
				e.printStackTrace();
			} finally {
				// 자원해제
				closeDB();
			}

			return cnt;
		}
		// getRentshopCount()

		///////////////////////////////////////////////////////////////////////////////
		
		
		
		
//////////////////////////////////////////////////////////////////

		// getRentshopCount()
		// 디비에 들어있는 글의 개수 계산후 리턴
		public int getRentshopCount() {
		
		int cnt = 0;
		
		try {
		// 1,2 드라이버로드, 디비연결
		conn = getConnection();
		
		// 3 sql 작성(select) & pstmt 객체 생성
		sql = "select count(*) from rentshop_info";
		pstmt = conn.prepareStatement(sql);
		
		
		// 4 sql 실행
		rs = pstmt.executeQuery();
		
		// 5 데이터 처리
		if (rs.next()) {
		cnt = rs.getInt(1);
		}
		
		System.out.println("SQL 구문 실행완료!");
		System.out.println(" 글 개수 : " + cnt + "개");
		
		} catch (Exception e) {
		System.out.println(" 게시판 글개수_에러 발생 ");
		e.printStackTrace();
		} finally {
		// 자원해제
		closeDB();
		}
		
		return cnt;
		}
		// getRentshopCount()

///////////////////////////////////////////////////////////////////////////////

		// getRentshopList()
		public ArrayList getRentshopList(String id) {
			// DB데이터 1row 정보를 BoardBean 저장 -> ArrayList 한칸에 저장

			ArrayList rentshopList = new ArrayList();

			RentshopBean rb = null;

			try {
				conn = getConnection();

				sql = "select * from rentshop_info where user_id=? order by rentshop_info_idx";

				pstmt = conn.prepareStatement(sql);

				// ?
				pstmt.setString(1, id);

				// 4 sql 실행
				rs = pstmt.executeQuery();

				// 5 데이터처리
				while (rs.next()) {
					// 데이터 있을때 bb 객체 생성
					rb = new RentshopBean();

					// DB정보 -> Bean 저장
					rb.setRentshop_info_idx(rs.getInt("rentshop_info_idx"));
					rb.setRentshop_info_name(rs.getString("rentshop_info_name"));
					rb.setRentshop_info_tel(rs.getString("rentshop_info_tel"));
					rb.setRentshop_info_addr(rs.getString("rentshop_info_addr"));
					rb.setRentshop_info_x(rs.getString("rentshop_info_x"));
					rb.setRentshop_info_y(rs.getString("rentshop_info_y"));
					rb.setRentshop_info_total(rs.getInt("rentshop_info_total"));
					rb.setRentshop_info_abike(rs.getInt("rentshop_info_abike"));
					rb.setRentshop_info_kbike(rs.getInt("rentshop_info_kbike"));
					rb.setRentshop_info_tbike(rs.getInt("rentshop_info_tbike"));

					// Bean -> ArrayList 한칸에 저장
					rentshopList.add(rb);

				} // while 끝

				System.out.println(" 게시판 모든정보 저장완료! ");
				System.out.println(" 총 " + rentshopList.size() + "개");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return rentshopList;
		}
		// getRentshopList()

		///////////////////////////////////////////////////////////////////////////////
		
		
		
		// getRentshopList()
				public ArrayList getRentshopList(int startRow,int pageSize) {
					// DB데이터 1row 정보를 BoardBean 저장 -> ArrayList 한칸에 저장

					ArrayList rentshopList = new ArrayList();

					RentshopBean rb = null;

					try {
						conn = getConnection();

						sql = "select * from rentshop_info order by rentshop_info_idx desc limit ?,?;";

						pstmt = conn.prepareStatement(sql);

						// ?
						pstmt.setInt(1, startRow-1);
						pstmt.setInt(2, pageSize);
						
						// 4 sql 실행
						rs = pstmt.executeQuery();

						// 5 데이터처리
						while (rs.next()) {
							// 데이터 있을때 bb 객체 생성
							rb = new RentshopBean();

							// DB정보 -> Bean 저장
							rb.setRentshop_info_idx(rs.getInt("rentshop_info_idx"));
							rb.setRentshop_info_name(rs.getString("rentshop_info_name"));
							rb.setRentshop_info_tel(rs.getString("rentshop_info_tel"));
							rb.setRentshop_info_addr(rs.getString("rentshop_info_addr"));
							rb.setRentshop_info_x(rs.getString("rentshop_info_x"));
							rb.setRentshop_info_y(rs.getString("rentshop_info_y"));
							rb.setRentshop_info_total(rs.getInt("rentshop_info_total"));
							rb.setRentshop_info_abike(rs.getInt("rentshop_info_abike"));
							rb.setRentshop_info_kbike(rs.getInt("rentshop_info_kbike"));
							rb.setRentshop_info_tbike(rs.getInt("rentshop_info_tbike"));

							// Bean -> ArrayList 한칸에 저장
							rentshopList.add(rb);

						} // while 끝

						System.out.println(" 게시판 모든정보 저장완료! ");
						System.out.println(" 총 " + rentshopList.size() + "개");

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						closeDB();
					}

					return rentshopList;
				}
				// getRentshopList()

				///////////////////////////////////////////////////////////////////////////////
				
				
				

		// rentshopDEL()
		public void rentshopDEL(String idx) {

			try {
				conn = getConnection();

				sql = "delete from rentshop_info where rentshop_info_idx=?";

				pstmt = conn.prepareStatement(sql);

				// ?
				pstmt.setString(1, idx);

				// 4 sql 실행
				pstmt.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}

		}
		// rentshopDEL()

		///////////////////////////////////////////////////////////////////////////////

		// getBoard(num)
		public RentshopBean getRentshop(int idx) {
			RentshopBean rb = null;
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 작성(select) & pstmt 객체
				sql = "select * from rentshop_info where rentshop_info_idx=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, idx);
				// 4 sql 실행
				rs = pstmt.executeQuery();

				// 5 데이터 처리 (bean 저장)
				if (rs.next()) {
					rb = new RentshopBean();
					rb.setRentshop_info_idx(rs.getInt("rentshop_info_idx"));
					rb.setUser_id(rs.getString("user_id"));
					rb.setRentshop_info_name(rs.getString("rentshop_info_name"));
					rb.setRentshop_info_tel(rs.getString("rentshop_info_tel"));
					rb.setRentshop_info_tel(rs.getString("rentshop_info_tel"));
					rb.setRentshop_info_addr(rs.getString("rentshop_info_addr"));
					rb.setRentshop_info_total(rs.getInt("rentshop_info_total"));
					rb.setRentshop_info_abike(rs.getInt("rentshop_info_abike"));
					rb.setRentshop_info_kbike(rs.getInt("rentshop_info_kbike"));
					rb.setRentshop_info_tbike(rs.getInt("rentshop_info_tbike"));

				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return rb;
		}
		// getBoard(num)

		//////////////////////////////////////////////////////////////////
		
		
		
		
		
		

		// rentshopUpdate(rb)
		public void rentshopUpdate(RentshopBean rb) {
			try {

				conn = getConnection();

				sql = "update rentshop_info set rentshop_info_name=?, rentshop_info_tel=?, rentshop_info_addr=?, rentshop_info_x=?, rentshop_info_y=?, rentshop_info_total=?, rentshop_info_abike=?, rentshop_info_kbike=?, rentshop_info_tbike=? where rentshop_info_idx=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, rb.getRentshop_info_name());
				pstmt.setString(2, rb.getRentshop_info_tel());
				pstmt.setString(3, rb.getRentshop_info_addr());
				pstmt.setString(4, rb.getRentshop_info_x());
				pstmt.setString(5, rb.getRentshop_info_y());
				pstmt.setInt(6, rb.getRentshop_info_total());
				pstmt.setInt(7, rb.getRentshop_info_abike());
				pstmt.setInt(8, rb.getRentshop_info_kbike());
				pstmt.setInt(9, rb.getRentshop_info_tbike());
				pstmt.setInt(10, rb.getRentshop_info_idx());

				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

		}// rentshopUpdate(rb)

		
		
		
		
		
		
		// getRentshopList()
		public ArrayList getRentshopList(int startRow,int pageSize,String keyword) {
			// DB데이터 1row 정보를 BoardBean 저장 -> ArrayList 한칸에 저장

			ArrayList rentshopList = new ArrayList();

			RentshopBean rb = null;

			try {
				conn = getConnection();

				sql = "select * from rentshop_info where rentshop_info_addr like '%"+ keyword +"%' order by rentshop_info_idx desc limit ?,?;";

				pstmt = conn.prepareStatement(sql);

				// ?
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				
				// 4 sql 실행
				rs = pstmt.executeQuery();

				// 5 데이터처리
				while (rs.next()) {
					// 데이터 있을때 bb 객체 생성
					rb = new RentshopBean();

					// DB정보 -> Bean 저장
					rb.setRentshop_info_idx(rs.getInt("rentshop_info_idx"));
					rb.setRentshop_info_name(rs.getString("rentshop_info_name"));
					rb.setRentshop_info_tel(rs.getString("rentshop_info_tel"));
					rb.setRentshop_info_addr(rs.getString("rentshop_info_addr"));
					rb.setRentshop_info_x(rs.getString("rentshop_info_x"));
					rb.setRentshop_info_y(rs.getString("rentshop_info_y"));
					rb.setRentshop_info_total(rs.getInt("rentshop_info_total"));
					rb.setRentshop_info_abike(rs.getInt("rentshop_info_abike"));
					rb.setRentshop_info_kbike(rs.getInt("rentshop_info_kbike"));
					rb.setRentshop_info_tbike(rs.getInt("rentshop_info_tbike"));

					// Bean -> ArrayList 한칸에 저장
					rentshopList.add(rb);

				} // while 끝

				System.out.println(" 게시판 모든정보 저장완료! ");
				System.out.println(" 총 " + rentshopList.size() + "개");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return rentshopList;
		}
		// getRentshopList()


		
	}
