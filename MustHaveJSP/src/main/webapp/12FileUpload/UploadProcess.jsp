<%@ page import="fileupload.MyfileDAO" %>
<%@ page import="fileupload.MyfileDTO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String saveDirectory = application.getRealPath("/Uploads"); // 저장할 디렉터리
	int maxPostSize = 1024 * 1000;								// 파일 최대 크기(1MB)
	String encoding = "UTF-8";									// 인코딩 방식
	// application 내장 객체의 getRealPath() 메서드를 통해 UPloads폴더의 '물리적 경로'를 얻어온다.
	// 업로드 최대 용량은 1MB로, 인코딩 방식은 UTF-8이다.
	try{
		// 1. MultipartRequest 객체 생성
		MultipartRequest mr = new MultipartRequest(request, saveDirectory,
													maxPostSize, encoding);
		// 위에서 준비한 값을 건네 MultipartRequest 객체를 생성한다. 객체가 정상적으로 생성되면
		// 파일은 업로드가 완료 된다. 이때 파일은 원본 파일명 그대로 저장한다.
		
		// 2. 새로운 파일명 생성
		String fileName = mr.getFilesystemName("attachedFile"); 	// 현재 파일 이름
		String ext = fileName.substring(fileName.lastIndexOf("."));	// 파일 확장자
		// MultipartRequest 클래스에서 서버에 저장된 파일명을 얻어온 후 확장자를 분리해준다.
		
		String now = new SimpleDateFormat("yyyyMMdd HmsS").format(new Date());
		String newFileName = now + ext;								// 새로운 파일 이름("업로드일시.확장자")
		// 현재 날짜와 시간을 구한 후 확장자와 결합하여 새로운 파일명을 만든다.
		
		// 3. 파일명 변경
		File oldFile = new File(saveDirectory + File.separator + fileName);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		// 위에서 저장한 파일명과 새롭게 생성한 파일명으로 File 객체를 생성한다. 중간에 사용된 File.separator는 경로를 구분하는
		// 특수 기호를 뜻한다. 서버의 운영체제에 따라 경로를 표현하는 방법이 다르므로 환경에 상관없이 코드가 동작하려면 이와 같이 하는 것이 좋다.
		
		// 4. 다른 폼값 받기
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		String[] cateArray = mr.getParameterValues("cate");
		StringBuffer cateBuf = new StringBuffer();
		if(cateArray == null){
			cateBuf.append("선택 없음");
		}else{
			for(String s : cateArray){
				cateBuf.append(s + ", ");
			}
		}
		// 파일 이외의 나머지 폼값을 MultipartRequest 객체의 getParameter() 메서드를 통해 받는다.
		// 카테고리는 필수가 아니므로 체크한 값이 없다면 "선택 없음"을 저장하고, 여러개를 선택했다면 쉼표(,)로 구분된 하나의 문자열로 만들어 저장
		
		
		// 5. DTO 생성
		MyfileDTO dto = new MyfileDTO();
		dto.setName(name);
		dto.setTitle(title);
		dto.setCate(cateBuf.toString());
		dto.setOfile(fileName);
		dto.setSfile(newFileName);
		// DAO 객체를 생성하여 전송된 폼값을 담는다.
		
		// 6. DAO를 통해 데이터베이스에 반영
		MyfileDAO dao = new MyfileDAO();
		dao.insertFile(dto);
		dao.close();
		// DAO 객체를 생성하고, 앞서 만든 insertFile() 메서드를 호출해 데이터베이스에 데이터를 저장한다.
		
		// 7. DAO를 통해 JSP로 리다이렉션
		response.sendRedirect("FileList.jsp");
		// 저장에 성공했다면 FileList.jsp로 이동한다. 
		// 만약에 업로드에 실패하여 예외가 발생하면 request 영역에 메시지를 저장한 후 FileUploadMain.jsp로 포워드 한다.
		
	}catch(Exception e){
		e.printStackTrace();
		request.setAttribute("errorMessage", "파일 업로드 오류");
		request.getRequestDispatcher("FileUploadMain.jsp").forward(request, response);
	}
%>