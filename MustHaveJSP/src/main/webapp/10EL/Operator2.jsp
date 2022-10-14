<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 예시에서 사용할 변수 선언
	pageContext.setAttribute("num1", 9);
	pageContext.setAttribute("num2", "10");
	
	pageContext.setAttribute("nullStr", null);
	pageContext.setAttribute("emptyStr", "");
	pageContext.setAttribute("lengthZero", new Integer[0] );
	pageContext.setAttribute("sizeZero", new ArrayList());
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 연산자</title>
</head>
<body>
	<h3>empty 연산자</h3> 
	empty nullStr : ${ empty nullStr }<br>
	empty emptyStr : ${ empty emptyStr }<br>
	empty lengthZero : ${ empty lengthZero }<br>
	empty sizeZero : ${ empty sizeZero }
	<!-- 값이 없는(empty)상태이므로 모두 true를 반환한다. -->
	
	<h3>삼항 연산자</h3>
	num1 gt num2 :"참" : "거짓" => ${ num1 gt num2 ? "num1이 크다." : "num2가 크다." }
	<!-- num1과 num2는 각 9와 10이므로 num2가 더 크다. 따라서 false를 반환하여 "num2가 크다."가 출력된다. -->
	
	<h3>null 연산</h3>
	null + 10 : ${ null + 10 }<br>
	nullStr + : ${ nullStr + 10 }<br>
	param.noVar > 10 : ${ param.noVar > 10 }
	<!-- null은 모두 0으로 처리된다. 실행에는 문제가 없으나 null과 정수를 연산하는 부분을 이클립스에서는 에러로 표시한다. -->
</body>
</html>