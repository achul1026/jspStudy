package servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import membership.MemberDAO;
import membership.MemberDTO;

public class MemberAuth extends HttpServlet{
	MemberDAO dao; // JDBC 프로그래밍을 위해 MemberDAO 타입의 DAO 객체를 멤버 변수로 선언한다.
	
	@Override
	public void init() throws ServletException { 
		// application 내장 객체 얻기
		ServletContext application = this.getServletContext();
		
		// web.xml에서 DB 연결 정보 얻기
		String driver = application.getInitParameter("OracleDriver");
		String connectUrl = application.getInitParameter("OracleURL");
		String oId = application.getInitParameter("OracleId");
		String oPass = application.getInitParameter("OraclePwd");
		
		// DAO 생성
		dao = new MemberDAO(driver, connectUrl, oId, oPass);
	}
	// 서블릿을 초기화 해줄 init() 메서드를 정의, init() 메서드에서 DB연결을 위한 DAO객체를 생성한다.
	// 먼저 application 내장 객체를 가져와서 web.xml에 등록한 컨텍스트 초기화 매개변수중 DB 연결 정보들을 읽는다.
	// 그리고 이 정보를 인수로 건네 MemberDAO 객체를 생성한다.
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException{
		// 서블릿 초기화 매개변수에서 관리자 ID 받기 
		// 클리이언트 요청을 처리할 service() 메서드를 정의하고, web.xml에서 추가한 서블릿 초기화
		// 매개변수를 얻어 온다. 관리자 아이디로 설정한 값이다.
		String admin_id = this.getInitParameter("admin_id");
		
		// 인증을 요청한 ID/패스워드
		// JSP에서 매개변수로 전달한 id와 pass를 받아서 memeber테이블의 일치하는 회원(레코드)를 찾는다.
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		// 회원 테이블에서 인증 요청한 ID/패스워드에 해당하는 회원 찾기
		MemberDTO memberDTO = dao.getMemberDTO(id, pass);
		
		// 찾은 회원의 이름에 따른 처리
		String memberName = memberDTO.getName();
		if(memberName != null) { // 일치하는 회원 찾음
			req.setAttribute("authMessage", memberName + "회원님 방가요~~~");
		}else { // 일치하는 회원 없음
			if(admin_id.equals(id)) { // 관리자
				req.setAttribute("authMessage", admin_id + "는 최고 관리자 입니다.");
			}else {
				req.setAttribute("authMessage", "귀하는 회원이 아닙니다.");
			}
		}
		req.getRequestDispatcher("/13Servlet/MemberAuth.jsp").forward(req, resp);
	}
	
	@Override
	public void destroy() {
		dao.close();
	}
}
