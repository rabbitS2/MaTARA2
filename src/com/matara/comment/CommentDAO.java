package com.matara.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.matara.board.CommunityBean;


public class CommentDAO {

	
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
	
	
	// getCommentCount()
		// 디비에 들어있는 글의 개수 계산후 리턴
		public int getCommentCount() {

			int cnt = 0;

			try {
				// 1,2 드라이버로드, 디비연결
				conn = getConnection();

				// 3 sql 작성(select) & pstmt 객체 생성
				sql = "select count(*) from comment";
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
		// getCommentCount()

		
		
		
		///////////////////////////////////////////////////////////////////////////////

		
		// getCommentList(startRow,pageSize)
		public ArrayList getCommentList(int startRow,int pageSize){
			
			ArrayList commentsList = new ArrayList();
			
			CommentBean cb = null;
			
			
			try {
				conn = getConnection();
				
				sql= "select * from comment order by comment_re_ref desc, comment_re_seq asc limit ?,?";			
				
				pstmt = conn.prepareStatement(sql);
				
				// ?
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);		
				
				// 4 sql 실행
				rs = pstmt.executeQuery();
				
				// 5 데이터처리 
				while(rs.next()){
					// 데이터 있을때 bb 객체 생성
					cb = new CommentBean();
					
					// DB정보 -> Bean 저장
					cb.setComment_idx(rs.getInt("comment_idx"));
					cb.setCommu_id(rs.getInt("commu_id"));
					cb.setUser_id(rs.getString("user_id"));
					cb.setComment_content(rs.getString("comment_content"));
					cb.setComment_re_ref(rs.getInt("comment_re_ref"));
					cb.setComment_re_lev(rs.getInt("comment_re_lev"));
					cb.setComment_re_seq(rs.getInt("comment_re_seq"));
					cb.setComment_date(rs.getDate("comment_date"));
					cb.setComment_ip(rs.getString("comment_ip"));
					cb.setFile_name(rs.getString("file_name"));
					// Bean -> ArrayList 한칸에 저장
					commentsList.add(cb);
					
				}//while 끝
				
				System.out.println(" 게시판 모든정보 저장완료! ");
				System.out.println(" 총 "+commentsList.size()+"개");		
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}		
			
			return commentsList;
		}
		// getCommentList(startRow,pageSize)
		
		
		
		
		///////////////////////////////////////////////////////////////////////////////
		
		
		
		// insertComment
				public void insertComment(CommentBean cb){
					int num = 0;
					try {
						// 1 드라이버 로드
						// 2 디비 연결
						// => 한번에 처리 하는 메서드로 변경
						conn = getConnection();		
						
						// 3 sql (글번호를 계산하는 구문)
						sql = "select max(comment_idx) from comment";
						
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
						sql = "insert into comment values(?,?,?,?,?,?,?,now(),?,?)";
						
						pstmt = conn.prepareStatement(sql);
						
						// ?
						pstmt.setInt(1, num);
						pstmt.setInt(2, cb.getCommu_id());
						pstmt.setString(3, cb.getUser_id());
						pstmt.setString(4, cb.getComment_content());
						pstmt.setInt(5, num);// re_ref에 글번호 num 저장
						pstmt.setInt(6, cb.getComment_re_lev());
						pstmt.setInt(7, cb.getComment_re_seq());
						pstmt.setString(8, cb.getComment_ip());
						pstmt.setString(9, cb.getFile_name());
						
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
				// insertComment()
				

			///////////////////////////////////////////////////////////////////////////////
							
			// reInsertComment(bb)
			public void reInsertComment(CommentBean cb){
			int num = 0;
			try {
			// 1) 답글 작성 번호(num)계산
			// 1,2 디비연결
			conn = getConnection();
			// 3 sql 구문 & pstmt 객체
			sql = "select max(comment_idx) from comment";
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
			sql = "update comment set comment_re_seq = comment_re_seq+1 where comment_re_ref=? and comment_re_seq>?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cb.getComment_re_ref());
			pstmt.setInt(2, cb.getComment_re_seq());
			
			// sql 실행
			pstmt.executeUpdate();
			
			System.out.println(" 답글 정렬 완료! ");
			
			// 3) 답글 쓰기 
			sql = "insert into comment values(?,?,?,?,?,?,?,now(),?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, cb.getCommu_id());
			pstmt.setString(3, cb.getUser_id());
			pstmt.setString(4, cb.getComment_content());
			pstmt.setInt(5, cb.getComment_re_ref());// re_ref에 글번호 num 저장
			pstmt.setInt(6, cb.getComment_re_lev()+1);
			pstmt.setInt(7, cb.getComment_re_seq()+1);
			pstmt.setString(8, cb.getComment_ip());
			pstmt.setString(9, cb.getFile_name());
			
			// sql 실행
			pstmt.executeUpdate();
			
			System.out.println(" 답글 작성완료! ");
			
			} catch (SQLException e) {
			e.printStackTrace();
			} finally {
			closeDB();
			}
			
			}
			// reInsertComment(bb)
			
			
			///////////////////////////////////////////////////////////////////////////////
	
	
	
			// updateComment(bb)
			public void updateComment(CommentBean cb){
				int check = -1;
				
				try {
					// 1,2 디비연결
					conn = getConnection();
					// 3 sql 작성 (select-본인확인) & pstmt 객체
					sql = "update comment set comment_content=? where comment_idx=?";
					pstmt = conn.prepareStatement(sql);
							
							// ? 
					pstmt.setString(1, cb.getComment_content());
					pstmt.setInt(2, cb.getComment_idx());
							
					// 4 sql 실행
					check = pstmt.executeUpdate();
							
					
					System.out.println(" 글 수정 완료! "+check);
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					closeDB();
				}
				
			}
			// updateComment(bb)
			

			///////////////////////////////////////////////////////////////////////////////
						
						
						
						
			// deleteComment(bb)
			public void deleteComment(int comment_idx){
			
			try {
			// 1,2 디비연결
			conn = getConnection();
			// 3 sql 생성(select) & pstmt 객체 생성
			sql="delete from comment where comment_idx=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, comment_idx);
			
			// 4 sql 실행
			pstmt.executeUpdate();
			
			
			} catch (Exception e) {
			e.printStackTrace();
			} finally {
			closeDB();
			}
			
			}
			// deleteComment(bb)
			
			
			
			///////////////////////////////////////////////////////////////////////////////
			
			
			
			
	
	
	
	
	
	
}
