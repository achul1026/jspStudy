package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool{ // 커넥션 풀 상속
	public MVCBoardDAO() {
		super();
	}
	
	// 검색 조건에 맞는 게시물의 개수를 반환한다. 
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		
		// 쿼리문 준비
		String query = "SELECT COUNT(*) FROM MVCBOARD";
		
		// 검색 조건이 있다면 WHERE 절로 추가
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		try {
			stmt = con.createStatement(); 		// 쿼리문 생성
			rs = stmt.executeQuery(query);; 	// 쿼리문 실행
			rs.next();
			totalCount = rs.getInt(totalCount); // 검색된 게시물의 개수 저장
		}catch(Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;					// 게시물 개수를 서블릿으로 반환
	}
	
	// 검색 조건에 맞는 게시물 목록을 반환(페이징 기능 구현)
	public List<MVCBoardDTO> selectListPage(Map<String, Object>map){
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		
		// 쿼리문 조건
		String query = " "
					+ "SELECT * FROM ("
					+ "		SELECT Tb.*, ROWNUM rNUM FROM("
					+ "			SELECT * FROM MVCBOARD ";
		
		// 검색 조건이 있다면 WHERE절로 추가
		if(map.get("searchWord") != null) {
			query += "	WHERE " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += "		ORDER BY idx DESC "
				+ "		) Tb"
				+ " ) "
				+ "	WHERE rNUM BETWEEN ? AND ?"; // 게시물 구간은 인파라미터로.. 
		
		try {
			psmt = con.prepareStatement(query);	// 동적 쿼리문 생성
			psmt.setString(1, map.get("start").toString());	// 인파라미터 설정
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();		// 쿼리문 실행
			
			// 반환된 게시물 목록을 List 컬렉션에 추가 
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				board.add(dto);
			}
		}catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return board;	// 목록 반환
	}
	
	// 게시글 데이터를 받아 DB에 추가한다.(파일 업로드 지원)
	// 웹 페이지(Write.jsp)에서 전송한 폼값을 서블릿(WriteController)이 받아 DTO에 저장 후 DAO로 전달
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		try {
			String query = "INSERT INTO mvcboard ("
					+ " idx, name, title, content, ofile, sfile, pass) "
					+ " VALUES ( "
					+ " seq_board_num.NEXTVAL, ?, ?, ?, ?, ?, ?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			result = psmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환한다.
	public MVCBoardDTO selectView(String idx) {
		MVCBoardDTO dto = new MVCBoardDTO(); // DTO 객체 생성
		String query = "SELECT * FROM mvcboard WHERE idx=?"; // 쿼리문 템플릿 준비
		try {
			psmt = con.prepareStatement(query); // 쿼리문 준비
			psmt.setString(1, idx);				// 인파리미터 설정
			rs = psmt.executeQuery();			// 쿼리문 실행
			
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
			}
		}catch(Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	// 주어진 일련번호에 해당하는 게시물의 조회수를 1 증가 시킨다.
	public void updateVisit(String idx) {
		String query = "UPDATE mvcboard SET "
					+ " visitcount = visitcount + 1"
					+ " WHERE idx=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}catch(Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	// 다운로드 횟수를 1 증가 시킨다.
	public void downCountPlus(String idx) {
		String sql = "UPDATE mvcboard SET "
					+ " downcount = downcount+1 "
					+ " WHERE idx=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}catch(Exception e) {
			
		}
	}
	
	// 입력한 비밀번호가 지정한 일련번호의 게시물의 비밀번호와 일치하는지 확인
	public boolean confirmPassword(String pass, String idx) {
		boolean isCorr = true;
		try {
			String sql = "SELECT COUNT(*) FROM mvcboard WHERE pass=? AND idx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);;
			psmt.setString(2, idx);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1) == 0) {
				isCorr = false;
			}
		}catch(Exception e) {
			isCorr = false;
			e.printStackTrace();
		}
		
		return isCorr;
	}
	
	// 지정한 일련번호의 게시물을 삭제 한다.
	public int deletePost(String idx) {
		int result = 0;
		try {
			String query = "DELETE FROM mvcboard WHERE idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시글 데이터를 받아 DB에 저장되어 있던 내용을 갱신한다.(파일 업로드 지원)
	public int updatePost(MVCBoardDTO dto) {
		int result = 0;
		try {
			// 쿼리문 템플릿 준비
			String query = "UPDATE mvcboard"
						+ " SET title=?, name=?, content=?, ofile, sfile=? "
						+ " WHERE idx=? and pass=?";
			
			// 쿼리문 준비
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			psmt.setString(7, dto.getPass());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
}
