<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    buffer="1kb" 
    autoFlush="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>page ���þ� - buffer,autoFlush �Ӽ� </title>
</head>
<body>
<%
	for(int i = 0; i<=100;i++){
		out.println("abcde12345");
	}
%>
</body>
</html>