<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FrontController.jsp</title>
</head>
<body>
	<h2>한 번의 매핑으로 여러가지 요청 처리하기</h2>
	${ resultValue } <!-- 서블릿에서 request 영역에 저장할 결과값이다. -->
	<ol>
		<li>URI : ${ uri }</li> <!-- 클라이언트가 요청한 전체 경로를 표시한다. -->
		<li>요청명 : ${ commandStr }</li> <!-- 전체 경로에서 마지막의 xxx.one 부분을 추출한 문자열이다. -->
	</ol>
	<ul>
		<li><a href="../13Servlet/regist.one">회원가입</a></li>
		<li><a href="../13Servlet/login.one">로그인</a></li>
		<li><a href="../13Servlet/freeboard.one">자유게시판</a></li>
	</ul>
</body>
</html>