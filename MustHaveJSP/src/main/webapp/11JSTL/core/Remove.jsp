<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 변수 선언 -->
<c:set var="scopeVar" value="Page Value"/>
<c:set var="scopeVar" value="Requset Value" scope="request" />
<c:set var="scopeVar" value="Session Value" scope="session" />
<c:set var="scopeVar" value="Application Value" scope="application"/>
<!-- 4가지 영역 모두 위와 같이 변수에 값을 저장, 영역을 지정하지 않으면 가장 좁은 영역인 page영역이 지정된다. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - remove</title>
</head>
<body>
	<h4>출력하기</h4>
	<ul>
		<li>scopeVar : ${ scopeVar }</li>
		<li>requestScope.scopeVar : ${ requestScope.scopeVar }</li>
		<li>sessionScope.scopeVar : ${ sessionScope.scopeVar }</li>
		<li>applicationScope.scopeVar : ${ applicationScope.scopeVar }</li>
	</ul>
	
	<h4>session 영역에서 삭제하기</h4>
	<c:remove var="scopeVar" scope="session"/>
	<ul>
		<li>sessionScope.scopeVar : ${ sessionScope.scopeVar }</li>
	</ul>
	<!-- scope를 session으로 설정 / session 영역에 저장된 변수가 삭제된다. 
		그래서 출력을 해도 출력되지 않는다. -->
	
	<h4>scope 지정 없이 삭제하기</h4>
	<c:remove var="scopeVar"/>
	<ul>
		<li>scopeVar : ${ scopeVar }</li>
		<li>requestScope.scopeVar : ${ requestScope.scopeVar }</li>
		<li>appliationScope.scopeVar : ${ applicationScope.scopeVar }</li>
	</ul>
	<!-- scope를 지정하지 않으면 4가지 영역 전체에서 scopeVar를 삭제한다.
		그래서 출력 되지 않는다. -->
</body>
</html>