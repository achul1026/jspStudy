<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <!-- 지시어 -->
<%!
	String str1 = "JSP";
	String str2 = "안녕하세요!";
	/* 스크립트 요소 (선언부) */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Hello JSP</title>
</head>
<body>
	<h2>처음 만들어 보는 <%=str1 %></h2>
		<!-- 스크립트 요소(표현식) -->
	<p>
		<%
			out.println(str2 + str1 + "입니다. 화이팅!!!!!");
					/* 스크립트 요소(스크립틀릿) */
		%>
	</p>
</body>
</html>