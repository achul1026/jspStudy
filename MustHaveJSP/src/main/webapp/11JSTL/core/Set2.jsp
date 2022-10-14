<%@ page import="common.Person" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - set 2</title>
</head>
<body>
	<h4>List 컬렉션 이용하기</h4>
	<%
		ArrayList<Person> pList = new ArrayList<Person>();
		pList.add(new Person("성상문", 55));
		pList.add(new Person("박팽년", 60));
	%>
	<!-- List 컬렉션을 생성하고, Person 객체를 추가한다. -->
	
	<c:set var="personList" value="<%= pList %>" scope="request"/>
	<ul>
		<li>아이디 : ${ requestScope.personList[0].name }</li>
		<li>비번 : ${ personList[0].age }</li>
	</ul>
	<!-- 이 컬렉션을 request영역에 "personList"라는 변수명으로 저장한 다음, 다시 불러와 출력한다.
		다른 영역에 똑같은 이름으로 저장한 속성이 없으므로 "requestScope"는 생략할 수 있다. -->
	
	<h4>Map 컬렉션 이용하기</h4>
	<%
		Map<String, Person> pMap = new HashMap<String, Person>();
		pMap.put("personArg1", new Person("하위지", 65));
		pMap.put("personArg2", new Person("이개", 67));
	%>
	<!-- Map 컬렉션을 생성하고, 역시 Person객체를 저장한다. -->
	<c:set var="personMap" value="<%= pMap %>" scope="request"/>
	<ul>
		<li>아이디 : ${ requestScope.personMap.personArg2.name }</li>
		<li>비번 : ${ personMap.personArg2.age }</li>
	</ul>
	<!-- request영역에 변수명 "personMap"으로 저장하고, 키를 통해 접근하여 출력한다.
		이번에도 같은 이유로 "requestScope"는 생략할 수 있다. -->
</body>
</html>