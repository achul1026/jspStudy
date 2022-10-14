<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="common.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List 컬렉션</title>
</head>
<body>
	<%
		List<Object> aList = new ArrayList<Object>();
		aList.add("청해진");
		aList.add(new Person("장보고",28));
		pageContext.setAttribute("Ocean", aList);
	%>
	<ul>
		<li>0번째 요소 : ${ Ocean[0] }</li>
		<li>1번째 요소 : ${ Ocean[1].name }, ${ Ocean[1].age }</li>
		<li>2번째 요소 : ${ Ocean[2] }</li><!-- 출력되지 않음 -->
	</ul>
	
	<h2>Map 컬렉션</h2>
	<%
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("한글","훈민정음");
		map.put("Eng","English");
		pageContext.setAttribute("King",map);
	%>
	<ul>
		<li>영문 Key : ${ King["End"] }, ${ King['Eng'] }, ${ King.Eng }</li>
		<li>한글 Key : ${ King["한글"] }, ${ King['한글'] }, \${ King.한글 }<!-- 에러 --></li>
															<!-- EL 코드를 주석하려면 앞에 \(역슬래시)를 붙인다. -->
	</ul>
</body>
</html>