<%@ page import="common.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// 속성 저장
	pageContext.setAttribute("pageInteger", 1000);
	pageContext.setAttribute("pageString", "페이지 영역의 문자열");
	pageContext.setAttribute("pagePerson", new Person("한석봉",99));
%>
<!DOCTYPE html>
<html>
<head>
<title>page 영역</title>
</head>
<body>
	<h2>page 영역의 속성값 읽기</h2>
	<%
		int pInteger = (Integer)(pageContext.getAttribute("pageInteger"));
		String pString = pageContext.getAttribute("pageString").toString();
		Person pPerson = (Person)(pageContext.getAttribute("pagePerson"));
	%>
	<ul>
		<li>Integer 객체 : <%=pInteger %></li>
		<li>String 객체 : <%=pString %></li>
		<li>Person 객체 : <%=pPerson.getName() %>, <%=pPerson.getAge() %></li>
	</ul>
	
	<h2>include된 파일에서 page영역 읽어오기</h2>
	<%@ include file="PageInclude.jsp" %>
	<!-- include 지시어로 포함 시킨 JSP 파일은 원본 그대로 삽입된 후 컴파일이 진행된다. 따라서 결합된 파일은 하나의 페이지 이므로 page 영역이 공유 된다. -->
	
	<h2>페이지 이동 후 page영역 읽어오기</h2>
	<a href="PageLocation.jsp">PageLocation.jsp 바로가기</a>
	<!-- a 태그를 통한 이동은 새로운 페이지를 요청하는 것이다. 즉, 서로 다른 페이지이므로 page 영역은 공유 되지 않는다. -->
</body>
</html>