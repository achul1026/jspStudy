package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet{
	// HelloServlet 클래스를 servlet 패키지에 생성한 후 HttpServlet 클래스를 상속한다. 
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)  throws ServletException, IOException{
		// doGet() 메서드를 오버라이딩한다. 이때 이클립스의 자동완성 기능을 사용하면 필요한 모든 import가 자동으로 생성되니 간단하다. ctrl+shift+o
		req.setAttribute("message", "Hello Servlet...!!!");
		req.getRequestDispatcher("/13Servlet/HelloServlet.jsp").forward(req, resp);
		// request 영역에 message라는 속성으로 데이터를 저장하고 HelloServlet.jsp로 포워드한다.
		// req는 doGet() 메서드의 매개변수로 전달받은 request 내장 객체이다. request 영역에 저장된 데이터는 포워드
		// 된 페이지까지 공유되므로 해당 속성을 출력할 수 있다.
	}
}
