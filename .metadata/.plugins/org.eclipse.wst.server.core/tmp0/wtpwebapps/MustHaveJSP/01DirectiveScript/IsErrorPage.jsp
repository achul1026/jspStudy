<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page ���þ� - errorPage, IsErrorPage �Ӽ�</title>
</head>
<body>
	<h2>���� �� �Ͻ����� ������ �߻��Ͽ����ϴ�.</h2>
	<p>
		������ : <%= exception.getClass().getName() %> 
		<br>
		���� �޽��� : <%= exception.getMessage() %>
	</p>
</body>
</html>