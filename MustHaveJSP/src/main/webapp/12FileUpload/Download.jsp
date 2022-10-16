<%@ page import="util.JSFunction" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String saveDirectory = application.getRealPath("/Uploads");
	String saveFilename = request.getParameter("sName");
	String originalFilename = request.getParameter("oName");
	// Uploads 폴더의 물리적 경로를 얻어오고 저장된 파일명과 원본 파일명을 매개변수로 받아 변수에 저장 한다.
	
	try{
		// 파일을 찾아 입력 스트림 생성
		File file = new File(saveDirectory, saveFilename);
		InputStream inStream = new FileInputStream(file);
		// 파일을 찾아 스트림 생성
	
		// 한글 파일명 깨짐 방지
		String client = request.getHeader("User-Agent");
		// request 내장 객체를 통해 요청 헤더 중 User-Agent를 읽어 온다. 이 값으로 요청을 보낸 웹 브라우저의 종류를 알 수 있다.
		if(client.indexOf("WOW64") == -1){
			// 파일명이 한글인 경우 깨짐 방지를 위한 처리를 한다.
			// 웹 브라우저가 인터넷 익스플로러가 아닌 경우에는 getBytes("UTF-8")로 원본 파일명을 바이트 배열로 변환 후,
			// ISO-8859-1 캐릭터셋의 문자열로 재생성한다.
			originalFilename = new String(originalFilename.getBytes("UTF-8"),
											"ISO-8859-1");
		}else {
			// 인터넷 익스플로러인 경우 getBytes("KSC5601")을 이용하여 바이트 배열로 변환 후, 문자열을 재생성한다.
			// 이는 웹 브라우저에 따라 한글 처리 방식이 다르기 때문이다.
			originalFilename = new String(originalFilename.getBytes("KSC5601"),
											"ISO-8859-1");
		}
	
		// 파일 다운로드용 응답 헤더 설정
		response.reset();
		// 응답 해더를 초기화 한 후
		response.setContentType("application/octet-stream");
		// 파일 다운로드 창을 띄우기 위한 콘텐츠 타입을 지정한다. octet-stream은 8비트 단위의 바이너리 데이터를 의미한다.
		// 응답 헤더로 설정하게 되면 파일의 종류에 상관없이 웹 브라우저는 다운로드 창을 띄우게 된다.
		response.setHeader("Content-Disposition",
							"attachment; filename=\"" + originalFilename + "\"");
		response.setHeader("Content-Length", "" + file.length());
		// 웹 브라우저에서 파일 다운로드 창이 뜰 때 원본 파일명이 기본으로 입력되도록 설정한다.
	
		// 출력 스트림 초기화
		out.clear();
		// 새로운 출력 스트림을 생성하기 위해 초기화 한다. JSP가 열린 상태에서 다운로드를 위해 또 다른
		// JSP를 열면 출력 스트림이 중복으로 생성되기 때문에 이 부분이 없으면 예외가 발생한다.
	
		// response 내장 객체로부터 새로운 출력 스트림 생성
		OutputStream outStream = response.getOutputStream();
		
		// 출력 스트림에 파일 내용 출력
		byte b[] = new byte[(int)file.length()];
		int readBuffer = 0;
		while((readBuffer = inStream.read(b)) > 0){
			outStream.write(b, 0, readBuffer);
		}
	
		// 입, 출력 스트립 닫기
		inStream.close();
		outStream.close();
		
	}catch(FileNotFoundException e){
		JSFunction.alertBack("파일을 찾을 수 없습니다.", out);
	}catch(Exception e){
		JSFunction.alertBack("예외가 발생하였습니다.", out);
	}
%>