<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="common.JDBConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>JDBC</title>
</head>
<body>
	<h2>회원 목록 조회 테스트(executeQuery())</h2>
	<%
		// DB에 연결
		JDBConnect jdbc = new JDBConnect();
		
		// 쿼리문 생성
		String sql = "SELECT id, pass, name, regidate FROM member";
		// SQL문에 인파라미터가 전혀 없으므로 PrepagedStatement가 아닌 Statement를 사용한다.
		Statement stmt = jdbc.con.createStatement();
		// 이때 사용한 메서드도 perpareStatement()가 아닌 createStatement() 이다.
		
		// 쿼리 수행
		ResultSet rs = stmt.executeQuery(sql);
		// 쿼리는 executeQuery() 메서드를 이용하며 결과는 ResultSet 객체로 받는다.
		// 결과 확인(웹 페이지에 출력)
		while(rs.next()){
		//	next()메서드를 이용하여 ResultSet 객체에서 다음 행(레코드)을 반환한다.
			String id = rs.getString(1);
			String pw = rs.getString(2);
			String name = rs.getString("name");
			java.sql.Date regidate = rs.getDate("regidate");
			
			out.println(String.format("%s %s %s %s", id, pw, name, regidate) + "<br>");
			// 반환된 행에서 아이디, 패스워드, 이름, 가입일자를 차례로 읽어서 웹 페이지에 출력한다.
			// get 메서드들에서 컬럼을 지정할 때는 인덱스와 컬럼명 둘 다 사용할 수 있으며, 컬럼명을 사용시 
			// 차후 테이블에서 새로운 컬럼이 추가 되거나 순서가 변경 되어도 소스코드 수정없이 사용할 수 있는 이점이 있다.
		}
		
		// 연결 닫기
		jdbc.close();
	%>
</body>
</html>