<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberAuth.jsp</title>
</head>
<body>
	<h2>MVC 패턴으로 회원인증하기</h2>
	<p>
		<strong>${ authMessage }</strong> <!-- 서블릿에서 회원인증 처리 후 결과 메시지를 출력 -->
		<br>
		<a href="./MemberAuth.mvc?id=nakja&pass=1234">회원인증(관리자)</a>
		<a href="./MemberAuth.mvc?id=musthave&pass=1234">회원인증(회원)</a>
		<a href="./MemberAuth.mvc?id=stranger&pass=1234">회원인증(비회원)</a>
		<!-- 위 링크는 차례로 관리자 ID, 회원 ID, 비회원 ID로 인증을 요청하는 기능이다.
		 	회원 여부는 member 테이블에 존재하는 아이디인지 여부로 판단하며, 관리자 아이디는 web.xml에서
			서블릿 초기화 매개변수로 설정된다. -->
	</p>
</body>
</html>