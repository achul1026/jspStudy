<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AnnoMapping.jsp</title>
</head>
<body>
	<h2>애너테이션으로 매핑하기</h2>
	<p>
		<strong>${ message }</strong>
		<!-- EL을 이용해 request 영역에 저장된 데이터를 출력한다. -->
		<br>
		<a href="<%= request.getContextPath()%>/13Servlet/AnnoMapping.do">바로가기</a>
		<!-- request.getContextPath()는 컨텍스트 루트 경로를 반환한다. 그러면 프로젝트명인 "/MustHaveJSP"
			가 반환되며, 여기에 요청명을 합쳐 바로가기 링크를 완성한다. -->
	</p>
</body>
</html>