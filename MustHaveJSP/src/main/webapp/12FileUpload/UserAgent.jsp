<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User-Agent 확인하기</title>
</head>
<body>
<%
	String client = request.getHeader("User-Agent");
	out.println(client);
%>
<!-- 인터넷 익스플로러의 실행 결과에서 출력되는 "WOW64"는 "Windows on Windows 64-bit"라는 뜻으로,
	64비트 버전의 윈도우에서 32비트 응용프로그램을 실행할 수 있다는 의미를 가지고 있다. -->
</body>
</html>