<%@ page import="java.util.Date" %>
<%@ page import="common.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- core 태그를 사용하기 위해 taglib 지시어를 선언 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - set 1</title>
</head>
<body>
	<!-- 변수 선언 -->
	<c:set var="directVar" value="100"/>
	<c:set var="elVar" value="${ directVar mod 5 }"/>
	<c:set var="expVar" value="<%= new Date() %>"/>
	<c:set var="betweenVar">
		변수값을 요렇게 설정
	</c:set>
	<!-- 먼저 사용할 변수들을 선언, value 속성에는 값을 직접 입력할 수도, EL이나 표현식을 사용할 수도 있다. 또한 태그 사이에 값을 지정할
		수도 있다. scope 속성을 사용하지 않으므로 모든 변수는 page 영역에 저장된다. -->
	
	<h4>EL을 이용해 변수 출력</h4>
	<ul>
		<li>directVar : ${ pageScope.directVar }</li>
		<li>elVar : ${ elVar }</li>
		<li>expVar : ${ expVar }</li>
		<li>betweenVar : ${ betweenVar }</li>
	</ul>
	<!-- 위에 설정한 변수를 출력 -->
	
	<h4>자바빈즈 생성 1 - 생성자 사용</h4>
	<c:set var="personVar1" value='<%= new Person("박문수",50) %>' scope="request"/>
	<ul>
		<li>이름 : ${ requestScope.personVar1.name }</li>
		<li>나이 : ${ personVar1.age }</li>
	</ul>
	<!-- 자바빈즈를 변수로 선언할 수도 있다. 자바빈즈 생성 시 생성자를 통해 초깃값을 설정하고, request 영역에 
		변수를 저장한 다음, 다시 request영역에 저장된 자바빈즈를 출력 -->
	
	<h4>자바빈즈 생성 2 - target, property 사용</h4>
	<c:set var="personVar2" value="<%= new Person() %>" scope="request"/>
	<c:set target="${ personVar2 }" property="name" value="정약용"/>
	<c:set target="${ personVar2 }" property="age" value="60"/>
	<ul>
		<li>이름 : ${ personVar2.name }</li>
		<li>나이 : ${ requestScope.personVar2.age }</li>
	</ul>
	<!-- 자바빈즈를 생성한 후 값을 나중에 설정하려면 target과 property 속성을 사용한다.
		target에는 변수를 지정하고 property에는 멤버 변수명을 지정하면된다. -->
</body>
</html>