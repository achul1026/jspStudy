<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//예시에서 사용할 변수 선언
	int num1 = 3;
	pageContext.setAttribute("num2", 4);
	pageContext.setAttribute("num3","5"); // num3와 num4는 문자열을 입력했지만 EL에서 산술 연산 시 자동으로 숫자로 변경
	pageContext.setAttribute("num4","8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 연산자</title>
</head>
<body>
	<h2>변수 선언 및 할당</h2>
	스크립틀릿에서 선언한 변수 : ${ num1 }<br> 
	page 영역에 저장된 변수 : ${ num2 }<br> 
	변수 할당 및 즉시 출력 : ${ num1 = 7 }<br> 
	변수 할당 및 별도 출력 : ${ num2 = 8;'' } => ${ num2 }<br> 
	num1 = ${ num1 }, num2 = ${ num2 }, num3 = ${ nu3 }, num4 = ${ num4 }
	
	<!-- EL은 스크립틀릿에서 선언한 변수를 즉시 사용할 수 없다. 따라서 null이므로 아무것도 출력되지 않는다. -->
	<!-- page 영역에 저장된 속성은 정상적으로 출력 -->
	<!-- EL 3.0부터는 변수에 값을 할당할 수 있다. 하지만 할당과 동시에 출력된다. -->
	<!-- 할당만 하려면 ${변수명=값;''}처럼 사용해야한다. -->
	
	<h3>산술 연산자</h3> <!-- 산술연산자는 자바와 같다. 단, 나눗셈에div, 나머지 연산에 mod를 추가로 사용한다.ㄴ -->
    num1 + num2 : ${ num1 + num2 } <br />
    num1 - num2 : ${ num1 - num2 } <br />
    num1 * num2 : ${ num1 * num2 } <br />
    num3 / num4 : ${ num3 / num4 } <br />
    num3 div num4 : ${ num3 div num4 } <br />
    num3 % num4 : ${ num3 % num4 } <br />
    num3 mod num4 : ${ num3 mod num4 }
	
	<h3>+ 연산자는 덧셈만 가능</h3> <!-- EL에서는 + 연산자는 덧셈을 위해서만 사용한다. 숫자 형태의 문자열이라면 자동으로 숫자로 변환되어 계산되지만
									문자가 포함되어 있다면 변환이 되지 않으므로 에러가 발생한다. -->
    num1 + "34" : ${ num1 + "34" } <br /> 
    num2 + "이십" : \${num2 + "이십" }<!-- 에러 발생(주석 처리) --> <br />
    "삼십" + "사십" : \${"삼십" + "사십" }<!-- 에러 발생(주석 처리) -->
	
	<h3>비교 연산자</h3> <!-- 비교 연산자와 논리 연산자도 문자 형태의 연산자(gt, and 등)를 사용할 수 있다. -->
    num4 > num3 : ${ num4 gt num3 } <br />
    num1 < num3 : ${ num1 lt num3 } <br />
    num2 >= num4 : ${ num2 ge num4 } <br />
    num1 == num4 : ${ num1 eq num4 } 
	
	<h3>논리 연산자</h3>
    num3 <= num4 && num3 == num4 : ${ num3 le num4 and num3 eq num4 } <br />
    num3 >= num4 || num3 != num4 : ${ num3 ge num4 or num3 ne num4 }
</body>
</html>