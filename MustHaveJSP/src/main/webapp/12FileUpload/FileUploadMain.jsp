<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
<script>
	/* 작성폼의 입력값을 검증하기 위한 자바스크립트 함수이다. 작성자 이름, 제목, 첨부파일이 입력되었는지 확인하여 
		만약 입력되지 않았다면 경고창을 띄우고 해당 입력란으로 포커스를 이동시킨다. 그리고 전송을 취소하기 위해 false를 반환한다.*/
	function validateForm(form){
		if(form.name.value == ""){
			alert("작성자를 입력하세요.");
			form.name.focus();
			return false;
		}
		if(form.title.value == ""){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if(form.attachedFile.value == ""){
			alert("첨부파일은 필수 입력입니다.");
			return false;
		}
	}
</script>
</head>
<body>
	<h3>파일 업로드</h3>
	<span style="color: red;">${ errorMassage }</span>
	<!-- <form>태그는 method는 post로, enctype은 multipart/form-data로 설정, 또한 입력값 검증을 위해 onsubmit 이벤트
			핸들러에서 validateForm 함수를 호출한다.  -->
	<form name="fileForm" method="post" enctype="multipart/form-data"
			action="UploadProcess.jsp" onsubmit="return validateForm(this);">
		작성자 : <input type="text" name="name=" value="머스트해브"/><br>
		제목 :  <input type="text" name="title"/><br>
		카테고리(선택사항) : 
			<input type="checkbox" name="cate" value="사진" checked/> 사진
			<input type="checkbox" name="cate" value="과제" checked/> 과제
			<input type="checkbox" name="cate" value="워드" checked/> 워드
			<input type="checkbox" name="cate" value="음원" checked/> 음원 <br>		
		첨부파일 : <input type="file" name="attachedFile"/><br>
		<input type="submit" value="전송하기"/>
	</form>
</body>
</html>