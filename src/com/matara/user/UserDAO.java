package com.matara.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class UserDAO {

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

	
	
	
	// idCheck(id)
	public int idCheck(String id, String pw) {
		int result = -1;
		try {
			// 1,2 디비연결
						conn = getConnection();
						// 3 sql구문 & pstmt객체 생성
						sql = "select user_pw from user where user_id=?";
						pstmt = conn.prepareStatement(sql);

						pstmt.setString(1, id);
						// 4 sql 실행
						rs = pstmt.executeQuery();
						// 5 데이터처리
						if (rs.next()) {
							if (pw.equals(rs.getString("user_pw"))) {
								result = 1; // 회원있음
							} else {
								result = 0; // 비밀번호 오류
							}

						} else {
							result = -1; // 비회원

						}

					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						closeDB();
					}

					return result;
				}// idCheck(id)

	
	
//////////////////////////////////////////////////////////////////

	
	
	// joinIDCheck(id)
	public int joinIDCheck(String id) {
			int result = 0;
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql구문 & pstmt객체 생성
				sql = "select * from user where user_id=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);
				// 4 sql 실행
				rs = pstmt.executeQuery();
				// 5 데이터처리
				if (rs.next()) {
					if(rs.getInt("user_div") == 1){
						result = 1; // 일반회원이 있음 -> 아이디 사용 X 
					}else{
						result = 2; // 대여소회원 있음 -> 아이디 사용 X 
					}

				} else {

					result = 0; // 회원 없음 -> 아이디 사용 O
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return result;
		}// joinIDCheck(id)

	
	
//////////////////////////////////////////////////////////////////
	
	
	
	// mailCheck(id)
		public int mailCheck(String mail) {
			int result = 0;
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql구문 & pstmt객체 생성
				sql = "select * from user where user_mail=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, mail);
				// 4 sql 실행
				rs = pstmt.executeQuery();
				// 5 데이터처리
				if(rs.next()){
					result = 1; // 해당메일 X
				}else{
					result = 0; //해당메일 O
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return result;
		}// mailCheck(id)

//////////////////////////////////////////////////////////////////


	
	
	// joinUser(id)
		public void joinUser(UserBean udto) {

			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql구문 & pstmt객체 생성
				sql = "insert into user(user_id, user_pw, user_name, user_phone, user_mail, user_div)" + "values(?,?,?,?,?,?)";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, udto.getUser_id());
				pstmt.setString(2, udto.getUser_pw());
				pstmt.setString(3, udto.getUser_name());
				pstmt.setString(4, udto.getUser_phone());
				pstmt.setString(5, udto.getUser_mail());
				pstmt.setInt(6, udto.getUser_div());

				// 4 sql 실행
				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}// joinUser(id)
	
	
//////////////////////////////////////////////////////////////////


	
	
		// deleteUser(id)
		public int deleteUser(String id, String pw) {

			int result = -1;
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql구문 & pstmt객체 생성
				sql = "select user_pw from user where user_id=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, id);
				// 4 sql 실행
				rs = pstmt.executeQuery();
				// 5 데이터처리
				UserBean udto = new UserBean();

				if (rs.next()) {

					udto.setUser_pw(rs.getString("user_pw"));
					if (udto.getUser_pw().equals(pw)) {

						sql = "delete from user where user_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						// 4 sql 실행
						pstmt.executeUpdate();

						result = 1; // 삭제 성공
					} else {
						result = 0;  // 비밀번호 오류
					}

				} else {
						result = -1; // 세션만료
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return result;
		}// deleteUser(id)
	
	
//////////////////////////////////////////////////////////////////
 
	
		// Info(id)
					public UserBean infoUser(String id) {
						UserBean ub = null;
						try {
							// 1,2 디비연결
							conn = getConnection();
							// 3 sql구문 & pstmt객체 생성
							sql = "select * from user where user_id=?";
							pstmt = conn.prepareStatement(sql);

							pstmt.setString(1, id);
							// 4 sql 실행
							rs = pstmt.executeQuery();
							// 5 데이터처리
							

							if (rs.next()) {
								ub = new UserBean();
								ub.setUser_id(rs.getString("user_id"));
								ub.setUser_pw(rs.getString("user_pw"));
								ub.setUser_name(rs.getString("user_name"));
								ub.setUser_phone(rs.getString("user_phone"));
								ub.setUser_mail(rs.getString("user_mail"));
								ub.setUser_div(rs.getInt("user_div"));
							} 

						} catch (SQLException e) {
							e.printStackTrace();
						} finally {
							closeDB();
						}

						return ub;
					}// Info(id)
		

			
//////////////////////////////////////////////////////////////////


			
	
					// updateUser(udto)
					public int updateUser(UserBean udto) {
						int result = 0;
						try {
							// 1,2 디비연결
							conn = getConnection();
							// 3 sql구문 & pstmt객체 생성
							sql = "select * from user where user_id=?";
							pstmt = conn.prepareStatement(sql);

							pstmt.setString(1, udto.getUser_id());
							// 4 sql 실행
							rs = pstmt.executeQuery();

							if (rs.next()) {
								
									sql="update user set user_name=?, user_phone=? where user_id=?";
									pstmt = conn.prepareStatement(sql);
									
									pstmt.setString(1, udto.getUser_name());
									pstmt.setString(2, udto.getUser_phone());
									pstmt.setString(3, udto.getUser_id());
									
									pstmt.executeUpdate();
									
									result = 1;
								

							} else {
								result = 0;
							}

						} catch (SQLException e) {
							e.printStackTrace();
						} finally {
							closeDB();
						}

						return result;
					}// updateUser(udto)
	
	
	
	
	
	
	
	
	
	
	
}
