package com.matara.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TravelDAO {

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
	
	
	
	
	//////////////////////////////////////////////////////////////////

	// getBoardCount()
	// 디비에 들어있는 글의 개수 계산후 리턴
	public int getBoardCount() {

		int cnt = 0;

		try {
			// 1,2 드라이버로드, 디비연결
			conn = getConnection();

			// 3 sql 작성(select) & pstmt 객체 생성
			sql = "select count(*) from travel";
			pstmt = conn.prepareStatement(sql);

			// 4 sql 실행
			rs = pstmt.executeQuery();

			// 5 데이터 처리
			if (rs.next()) {
				cnt = rs.getInt(1);// "count(*)"
				// cnt = rs.getInt("count(*)");
			}

			System.out.println("SQL 구문 실행완료!");
			System.out.println(" 글 개수 : " + cnt + "개");

		} catch (Exception e) {
			System.out.println(" 게시판 글개수_에러 발생!! ");
			e.printStackTrace();
		} finally {
			// 자원해제
			closeDB();
		}

		return cnt;
	}
	// getBoardCount()

	
	
	
	///////////////////////////////////////////////////////////////////////////////

	
	
	
	
	// getBoardList()
	public ArrayList getBoardList() {
		// DB데이터 1row 정보를 BoardBean 저장 -> ArrayList 한칸에 저장

		// 게시판의 글정보를 모두 저장하는 가변길이 배열
		ArrayList boardListAll = new ArrayList();

		// 게시판 글 1개의 정보를 저장하는 객체
		TravelBean tb = null;
		// BoardBean bb = new BoardBean();

		try {
			// 1,2 드라이버로드, 디비연결
			conn = getConnection();
			// 3 sql 구문 & pstmt 객체
			sql = "select * from travel";
			pstmt = conn.prepareStatement(sql);

			// 4 sql 실행
			rs = pstmt.executeQuery();

			// 5 데이터처리
			while (rs.next()) {
				// 데이터 있을때 bb 객체 생성
				tb = new TravelBean();

				// DB정보 -> Bean 저장
				tb.setTravel_id(rs.getInt("travel_id"));
				tb.setBg_id(rs.getInt("bg_id"));
				tb.setUser_id(rs.getString("user_id"));
				tb.setTravel_sub(rs.getString("travel_sub"));
				tb.setTravel_content(rs.getString("travel_content"));
				tb.setTravel_readcount(rs.getInt("travel_readcount"));
				tb.setTravel_date(rs.getDate("travel_date"));
				tb.setTravel_ip(rs.getString("travel_ip"));
				tb.setFile_name(rs.getString("file_name"));

				// Bean -> ArrayList 한칸에 저장
				boardListAll.add(tb);

			} // while 끝

			System.out.println(" 게시판 모든정보 저장완료! ");
			System.out.println(" 총 " + boardListAll.size() + "개");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return boardListAll;
	}
	// getBoardList()

	
	
	////////////////////////////////////////////////////////////////////////////////
	
	
	
	// getBoardList(startRow,pageSize)
	public ArrayList getBoardList(int startRow,int pageSize){
		// DB데이터 1row 정보를 BoardBean 저장 -> ArrayList 한칸에 저장
		
		// 게시판의 글정보를 원하는만큼 저장하는 가변길이 배열
		ArrayList boardList = new ArrayList();
		
		// 게시판 글 1개의 정보를 저장하는 객체 
		TravelBean tb = null;
		//BoardBean bb = new BoardBean();
		
		
		try {
			// 1,2 드라이버로드, 디비연결
			conn = getConnection();
			// 3 sql 구문 & pstmt 객체 
			//   글 정보 정렬 - order by
			//            - re_ref 값을 최신글 위쪽으로 정렬 (내림차순)
			//            - re_seq 값을 사용 (오름차순)
			//            - limit a,b   (a 시작행-1,b 개수)
			//            ex) 1번글 -> 0번 인덱스			
			
			
			//sql= "select * from itwill_board";
			sql= "select * from travel order by travel_id desc limit ?,?";			
			
			pstmt = conn.prepareStatement(sql);
			
			// ?
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);		
			
			// 4 sql 실행
			rs = pstmt.executeQuery();
			
			// 5 데이터처리 
			while(rs.next()){
				// 데이터 있을때 bb 객체 생성
				tb = new TravelBean();
				
				// DB정보 -> Bean 저장
				tb.setTravel_id(rs.getInt("travel_id"));
				tb.setBg_id(rs.getInt("bg_id"));
				tb.setUser_id(rs.getString("user_id"));
				tb.setTravel_sub(rs.getString("travel_sub"));
				tb.setTravel_content(rs.getString("travel_content"));
				tb.setTravel_readcount(rs.getInt("travel_readcount"));
				tb.setTravel_date(rs.getDate("travel_date"));
				tb.setTravel_ip(rs.getString("travel_ip"));
				tb.setFile_name(rs.getString("file_name"));
				
				// Bean -> ArrayList 한칸에 저장
				boardList.add(tb);
				
			}//while 끝
			
			System.out.println(" 게시판 모든정보 저장완료! ");
			System.out.println(" 총 "+boardList.size()+"개");		
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		
		return boardList;
	}
	// getBoardList(startRow,pageSize)
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////

	
	
	
	// insertBoard
		public void insertBoard(TravelBean tb){
			int num = 0;
			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리 하는 메서드로 변경
				conn = getConnection();		
				
				// 3 sql (글번호를 계산하는 구문)
				sql = "select max(travel_id) from travel";
				
				pstmt = conn.prepareStatement(sql);
				
				// 4 sql 실행
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리
				//  max(num) - sql 함수를 실행했을경우 커서이동 가능(데이터여부 상관없음)
				//  num     - sql 컬럼의 경우  커서 이동 불가능
				if(rs.next()){
					//num = rs.getInt("max(num)")+1;
					num = rs.getInt(1)+1;
				}
				
				System.out.println(" 글번호  : "+num);
				
				////////////////////////////////////////////////////
				
				// 3 sql 작성 (insert) & pstmt 객체 생성
				sql = "insert into travel values(?,?,?,?,?,?,now(),?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				// ?
				pstmt.setInt(1, num);
				pstmt.setInt(2, tb.getBg_id());
				pstmt.setString(3, tb.getUser_id());
				pstmt.setString(4, tb.getTravel_sub());
				pstmt.setString(5, tb.getTravel_content());
				pstmt.setInt(6, tb.getTravel_readcount());
				pstmt.setString(7, tb.getTravel_ip());
				pstmt.setString(8, tb.getFile_name());
				
				// 4 sql 실행	
				
				pstmt.executeUpdate();
				
				System.out.println(" sql 구문 실행완료  : 글쓰기 완료! ");
				
			} catch (SQLException e) {
				System.out.println("디비 연결 실패!!");
				e.printStackTrace();
			} finally{
				// 자원해제 
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}			
			}
			
		}
		// insertBoard()
		

	///////////////////////////////////////////////////////////////////////////////
	
	
		// updateReadcount(num)
		public void updateReadcount(int num){
			
			try {
				//1,2 디비연결
				conn = getConnection();
				
				//3 sql 구문 작성(update) & pstmt 객체
				sql = "update travel set travel_readcount=travel_readcount+1 where travel_id=?";
				
				pstmt = conn.prepareStatement(sql);
				
				//?
				pstmt.setInt(1, num);
				
				//4 sql 실행
				pstmt.executeUpdate();
				
				System.out.println(" 글 조회수 증가 완료! ");			
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
		}
		// updateReadcount(num)
		
		

		///////////////////////////////////////////////////////////////////////////////
		
		// getBoard(num)
		public TravelBean getBoard(int num){
			TravelBean tb = null;
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 작성(select) & pstmt 객체 
				sql = "select * from travel where travel_id=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				// 4 sql 실행
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리 (bean 저장)
				if(rs.next()){
					tb = new TravelBean();
					
					tb.setTravel_id(rs.getInt("travel_id"));
					tb.setBg_id(rs.getInt("bg_id"));
					tb.setUser_id(rs.getString("user_id"));
					tb.setTravel_sub(rs.getString("travel_sub"));
					tb.setTravel_content(rs.getString("travel_content"));
					tb.setTravel_readcount(rs.getInt("travel_readcount"));
					tb.setTravel_date(rs.getDate("travel_date"));
					tb.setTravel_ip(rs.getString("travel_ip"));
					tb.setFile_name(rs.getString("file_name"));
					
				}
				
				System.out.println(" 글번호에 해당하는 글정보 저장완료! ");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return tb;
		}
		// getBoard(num)
		

		///////////////////////////////////////////////////////////////////////////////
		
		
		// updateBoard(bb)
		public void updateBoard(TravelBean cb){
			int check = -1;
			
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 작성 (select-본인확인) & pstmt 객체
				sql = "update travel set travel_sub=?, travel_content=?, file_name=? where travel_id=?";
				pstmt = conn.prepareStatement(sql);
						
						// ? 
				pstmt.setString(1, cb.getTravel_sub());
				pstmt.setString(2, cb.getTravel_content());
				pstmt.setString(3, cb.getFile_name());
				pstmt.setInt(4, cb.getTravel_id());
						
				// 4 sql 실행
				check = pstmt.executeUpdate();
						
				
				System.out.println(" 글 수정 완료! "+check);
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
		}
		// updateBoard(bb)
		

		///////////////////////////////////////////////////////////////////////////////
		
		
		
		
		// deleteBoard(bb)
		public void deleteBoard(int travel_id){
			
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 생성(select) & pstmt 객체 생성
				sql="delete from travel where travel_id=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, travel_id);
				
			    // 4 sql 실행
				pstmt.executeUpdate();
				
					
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
		}
		// deleteBoard(bb)
		
		

		///////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
}
