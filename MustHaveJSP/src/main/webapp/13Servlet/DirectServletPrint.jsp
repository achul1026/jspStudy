<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DirectServletPrint.jsp</title>
</head>
<body>
	<h2>web.xml에서 매핑 후 Servlet에서 직접 출력하기</h2>
	<form method="post" action="../13Servlet/DirectServletPrint.do">
	<!-- post방식으로 전송하기 위해 <form>태그를 사용한다. 요청명은 action속성에 지정하였다. -->
		<input type="submit" value="바로가기"/>
	</form>
</body>
</html>