package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DirectServletPrint extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		// post 방식의 요청이므로 doPost() 메서드를 오버라이딩하였다.
		resp.setContentType("text/html;charset=UTF-8");
		// 클라이언트에 응답하기 위해 response 내장 객체에 응답 콘텐츠 타입을 지정한다. 콘텐츠
		// 타입은 "text/html"으로, 캐릭터셋은 "UTF-8"로 지정한다.
		PrintWriter writer = resp.getWriter();
		// 웹 브라우저에 전송할 응답 결과를 쓰기 위해 response 내장 객체에서 PrintWriter 객체를
		// 얻어온다.
		
		writer.println("<html>");
		writer.println("<head><title>DirectServletPrint</title></head>");
		writer.println("<body>");
		writer.println("<h2>서블릿에서 직접 출력한다.</h2>");
		writer.println("<p>jsp로 포워드하지 않는다.</p>");
		writer.println("<body>");
		writer.println("</html>");
		// PrintWriter는 println()메서드를 제공한다. 이 메서드를 이용해 응답 내용을 출력한다. 
		// 출력 내용은 간단한 태그들로 구성된 기본적인 HTML 문서이다. 
		writer.close();
		// 마지막으로 PrintWriter 객체를 닫아준다.
	}
}
