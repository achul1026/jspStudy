<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%!
	public int add(int num1, int num2){
		return num1 + num2;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>스크립트 요소</title>
</head>
<body>
<%
	int result = add(10,20);
%>
 덧셈 결과 : <%= result %><br>
 덧셈 결과 : <%= add(30,40) %>
</body>
</html>