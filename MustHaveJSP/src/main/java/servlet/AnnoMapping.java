package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/13Servlet/AnnoMapping.do")
// @WebServlet 애너테이션을 이용해 이 서블릿이 요청명 "/13Servlet/AnnoMapping.do"를 처리할 것임을
// 요청명은 web.xml에서 <url-pattern>에 입력한 값과 똑같이, 컨텍스트 루트를 제외한 경로를 입력하면 된다.
public class AnnoMapping extends HttpServlet{
	// 이 클래스는 서블릿이므로 HttpSerlet을 상속하고 
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		// doGet() 메서드를 오버라이딩한다.
		req.setAttribute("message", "@WebServelt으로 매핑"); // request 영역에 데이터를 저장
		req.getRequestDispatcher("/13Servlet/AnnoMapping.jsp").forward(req, resp);
		// AnnoMapping.jsp로 포워드한다.
	}
}
