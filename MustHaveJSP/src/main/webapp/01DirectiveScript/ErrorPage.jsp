<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    errorPage="IsErrorPage.jsp" %>
    <!-- 에러 페이지 지정 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>page 지시어 - errorPage, isErrorPage 속성 </title>
</head>
<body>
<%
	int myAge = Integer.parseInt(request.getParameter("age"))+ 10;
	out.println("10년 후의 당신의 나이는 "+ myAge + " 입니다.");

%>
</body>
</html>