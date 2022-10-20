<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LifeCycly.jsp</title>
</head>
<body>
	<script>
		function requestAction(frm, met){ // 폼값을 전송해주는 자바스크립트 코드이다.
										  // 첫번째 인수는 <form> 태그의 DOM 객체이고,
										  // 두번째 인수는 정송 방식이다.
			if(met == 1){
				frm.method = 'get';
			}else {
				frm.method = 'post';
			}
			frm.submit();
		}
	</script>
	
	<h2>서블릿 수명주기(Life Cycle) 메서드</h2>
	<form action="./LifeCycle.do"> <!-- <form> 태그를 정의한다. action 속성을 제외한 나머지는 클릭시 자바스크립트에서 설정 -->
		<input type="button" value="Get 방식 요청하기" onclick="requestAction(this.form, 1);"/>
		<input type="button" value="Post 방식 요청하기" onclick="requestAction(this.form, 2)"/>
	</form>
</body>
</html>