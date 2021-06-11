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







public class CommunityDAO {

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

	// getBoardCount()
	// 디비에 들어있는 글의 개수 계산후 리턴
	public int getBoardCount() {

		int cnt = 0;

		try {
			// 1,2 드라이버로드, 디비연결
			conn = getConnection();

			// 3 sql 작성(select) & pstmt 객체 생성
			sql = "select count(*) from community";
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
		CommunityBean cb = null;
		// BoardBean bb = new BoardBean();

		try {
			// 1,2 드라이버로드, 디비연결
			conn = getConnection();
			// 3 sql 구문 & pstmt 객체
			sql = "select * from community";
			pstmt = conn.prepareStatement(sql);

			// 4 sql 실행
			rs = pstmt.executeQuery();

			// 5 데이터처리
			while (rs.next()) {
				// 데이터 있을때 bb 객체 생성
				cb = new CommunityBean();

				// DB정보 -> Bean 저장
				cb.setCommu_id(rs.getInt("commu_id"));
				cb.setBg_id(rs.getInt("bg_id"));
				cb.setUser_id(rs.getString("user_id"));
				cb.setCommu_category(rs.getString("commu_category"));
				cb.setCommu_sub(rs.getString("commu_sub"));
				cb.setCommu_content(rs.getString("commu_content"));
				cb.setCommu_readcount(rs.getInt("commu_readcount"));
				cb.setCommu_re_ref(rs.getInt("commu_re_ref"));
				cb.setCommu_re_lev(rs.getInt("commu_re_lev"));
				cb.setCommu_re_seq(rs.getInt("commu_re_seq"));
				cb.setCommu_date(rs.getDate("commu_date"));
				cb.setCommu_ip(rs.getString("commu_ip"));
				cb.setFile_name(rs.getString("file_name"));

				// Bean -> ArrayList 한칸에 저장
				boardListAll.add(cb);

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
		CommunityBean cb = null;
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
			sql= "select * from community order by commu_re_ref desc, commu_re_seq asc limit ?,?";			
			
			pstmt = conn.prepareStatement(sql);
			
			// ?
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);		
			
			// 4 sql 실행
			rs = pstmt.executeQuery();
			
			// 5 데이터처리 
			while(rs.next()){
				// 데이터 있을때 bb 객체 생성
				cb = new CommunityBean();
				
				// DB정보 -> Bean 저장
				cb.setCommu_id(rs.getInt("commu_id"));
				cb.setBg_id(rs.getInt("bg_id"));
				cb.setUser_id(rs.getString("user_id"));
				cb.setCommu_category(rs.getString("commu_category"));
				cb.setCommu_sub(rs.getString("commu_sub"));
				cb.setCommu_content(rs.getString("commu_content"));
				cb.setCommu_readcount(rs.getInt("commu_readcount"));
				cb.setCommu_re_ref(rs.getInt("commu_re_ref"));
				cb.setCommu_re_lev(rs.getInt("commu_re_lev"));
				cb.setCommu_re_seq(rs.getInt("commu_re_seq"));
				cb.setCommu_date(rs.getDate("commu_date"));
				cb.setCommu_ip(rs.getString("commu_ip"));
				cb.setFile_name(rs.getString("file_name"));
				// Bean -> ArrayList 한칸에 저장
				boardList.add(cb);
				
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
		public void insertBoard(CommunityBean cb){
			int num = 0;
			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리 하는 메서드로 변경
				conn = getConnection();		
				
				// 3 sql (글번호를 계산하는 구문)
				sql = "select max(commu_id) from community";
				
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
				sql = "insert into community values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				// ?
				pstmt.setInt(1, num);
				pstmt.setInt(2, cb.getBg_id());
				pstmt.setString(3, cb.getUser_id());
				pstmt.setString(4, cb.getCommu_category());
				pstmt.setString(5, cb.getCommu_sub());
				pstmt.setString(6, cb.getCommu_content());
				pstmt.setInt(7, cb.getCommu_readcount()); 
				pstmt.setInt(8, num);// re_ref에 글번호 num 저장
				pstmt.setInt(9, cb.getCommu_re_lev());
				pstmt.setInt(10, cb.getCommu_re_seq());
				pstmt.setString(11, cb.getCommu_ip());
				pstmt.setString(12, cb.getFile_name());
				
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
				sql = "update community set commu_readcount=commu_readcount+1 where commu_id=?";
				
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
		public CommunityBean getBoard(int num){
			CommunityBean cb = null;
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 작성(select) & pstmt 객체 
				sql = "select * from community where commu_id=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				// 4 sql 실행
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리 (bean 저장)
				if(rs.next()){
					cb = new CommunityBean();
					
					cb.setCommu_id(rs.getInt("commu_id"));
					cb.setBg_id(rs.getInt("bg_id"));
					cb.setUser_id(rs.getString("user_id"));
					cb.setCommu_category(rs.getString("commu_category"));
					cb.setCommu_sub(rs.getString("commu_sub"));
					cb.setCommu_content(rs.getString("commu_content"));
					cb.setCommu_readcount(rs.getInt("commu_readcount"));
					cb.setCommu_re_ref(rs.getInt("commu_re_ref"));
					cb.setCommu_re_lev(rs.getInt("commu_re_lev"));
					cb.setCommu_re_seq(rs.getInt("commu_re_seq"));
					cb.setCommu_date(rs.getDate("commu_date"));
					cb.setCommu_ip(rs.getString("commu_ip"));
					cb.setFile_name(rs.getString("file_name"));
					
				}
				
				System.out.println(" 글번호에 해당하는 글정보 저장완료! ");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return cb;
		}
		// getBoard(num)
		

		///////////////////////////////////////////////////////////////////////////////
		
		
		// updateBoard(bb)
		public void updateBoard(CommunityBean cb){
			int check = -1;
			
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 작성 (select-본인확인) & pstmt 객체
				sql = "update community set commu_category=?, commu_sub=?, commu_content=?, file_name=? where commu_id=?";
				pstmt = conn.prepareStatement(sql);
						
						// ? 
				pstmt.setString(1, cb.getCommu_category());
				pstmt.setString(2, cb.getCommu_sub());
				pstmt.setString(3, cb.getCommu_content());
				pstmt.setString(4, cb.getFile_name());
				pstmt.setInt(5, cb.getCommu_id());
						
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
		public void deleteBoard(int commu_id){
			
			try {
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 생성(select) & pstmt 객체 생성
				sql="delete from community where commu_id=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, commu_id);
				
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
		
		// reInsertBoard(bb)
		public void reInsertBoard(CommunityBean cb){
			int num = 0;
			try {
				// 1) 답글 작성 번호(num)계산
				// 1,2 디비연결
				conn = getConnection();
				// 3 sql 구문 & pstmt 객체
				sql = "select max(commu_id) from community";
				pstmt = conn.prepareStatement(sql);
				
				// 4 sql 실행
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리
				if(rs.next()){
					//rs.getInt("max(num)");
					num = rs.getInt(1)+1;
				}
				
				System.out.println(" 답글 번호 계산 완료 : "+num);			
				
				// 2) 답글 순서 재배치 (정렬)
				// -> re_ref(같은그룹)안에서  re_seq(순서)를 정렬
				//            "           기존의 순서값보다 큰값이 있으면 순서를 1증가
				sql = "update community set commu_re_seq = commu_re_seq+1 where commu_re_ref=? and commu_re_seq>?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, cb.getCommu_re_ref());
				pstmt.setInt(2, cb.getCommu_re_seq());
				
				// sql 실행
				pstmt.executeUpdate();
				
				System.out.println(" 답글 정렬 완료! ");
				
				// 3) 답글 쓰기 
				sql = "insert into community values(?,?,?,?,?,?,?,?,?,?,now(),?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				pstmt.setInt(2, cb.getBg_id());
				pstmt.setString(3, cb.getUser_id());
				pstmt.setString(4, cb.getCommu_category());
				pstmt.setString(5, cb.getCommu_sub());
				pstmt.setString(6, cb.getCommu_content());
				pstmt.setInt(7, cb.getCommu_readcount()); 
				pstmt.setInt(8, cb.getCommu_re_ref());// re_ref에 글번호 num 저장
				pstmt.setInt(9, cb.getCommu_re_lev()+1);
				pstmt.setInt(10, cb.getCommu_re_seq()+1);
				pstmt.setString(11, cb.getCommu_ip());
				pstmt.setString(12, cb.getFile_name());
				
				
				// sql 실행
				pstmt.executeUpdate();
				
				System.out.println(" 답글 작성완료! ");
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
		
		}
		// reInsertBoard(bb)
		

		///////////////////////////////////////////////////////////////////////////////
		
		

}
