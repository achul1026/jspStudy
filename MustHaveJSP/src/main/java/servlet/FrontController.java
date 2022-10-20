package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.one") // 와일드 카드(*)를 사용하여 URL패턴이 *.one에 해당하는 요청을 모두 이 서블릿과 매칭
public class FrontController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException{
		String uri = req.getRequestURI();
		// request 내장 객체로부터 현재 경로에서 호스트명을 제외한 나머지 부분을 알아낸 다음
		
		int lastSlash = uri.lastIndexOf("/");
		// 마지막 슬래시(/)의 인덱스를 구한다. 
		
		String commandStr = uri.substring(lastSlash);
		// 그리고 이 인덱스로 경로의 마지막 부분의 문자열을 얻어 온다.
		
		if(commandStr.equals("/regist.one"))
			registFunc(req);
		else if(commandStr.equals("/login.one"))
			loginFunc(req);
		else if(commandStr.equals("/freeboard.one"))
			freeboardFunc(req);
		// 이 문자열을 통해 페이지를 구분하여, 각 페이지를 처리할 수 있는 메서드를 호출한다.
		
		req.setAttribute("uri", uri);
		req.setAttribute("commandStr", commandStr);
		// uri와 페이지 구분을 위한 문자열(commandStr)을 request 영역에 저장하고, 
		
		req.getRequestDispatcher("/13Servlet/FrontController.jsp")
			.forward(req, resp);
		// FrontController.jsp로 포워드 한다.
	}
	
	// 페이지별 처리 메서드
	// 각 페이지를 처리할 수 있는 메서드들로, 각 페이지에 출력할 데이터를 request 영역에 저장한다.
	void registFunc(HttpServletRequest req) {
		req.setAttribute("resultValue", "<h4>회원가입</h4>");
	}
	
	void loginFunc(HttpServletRequest req) {
		req.setAttribute("resultValue", "<h4>로그인</h4>");
	}
	
	void freeboardFunc(HttpServletRequest req) {
		req.setAttribute("resultValue", "<h4>자유게시판</h4>");
	}
}
