package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
public class DBConnPool {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	// 기본 생성자
	public DBConnPool() {
		try {
			// 커넥션 풀(DataSource) 얻기
			Context initCtx = new InitialContext(); // 자바의 네이밍 서비스(JNDI)에서 이름과 실제 객체를 연결해주는 개념이 Context이며, InitialContext는 네이밍 서비스를 이용하기 위한 시작점이다.
													// 이 객체에 lookup() 메서드에 이름을 건네 원하는 객체를 찾아올수있다.
			Context ctx = (Context)initCtx.lookup("java:comp/env"); // "java:comp/env" 라는 이름을 인수로 context 객체를 얻어 온다.
																	// "java:comp/env" 는 현재 웹 어플리케이션의 루트 디렉토리라고 생각하면 된다.
																	// 즉, 현재 웹 어플리케이션이 사용할 수 있는 모든 자원은 "java:comp/env"아래에 위치한다.
			DataSource source = (DataSource)ctx.lookup("dbcp_myoracle"); // "java:comp/env"아래에 위치한 "dbcp_myoracle" 자원을 얻어온다.
																		 // 이 자원이 바로 데이터소스(커넥션 풀)이다.
																		 // "dbcp_myoracle"은 context.xml파일에 추가한 <ResourceLink>에 있는 name속성의 값이다.
			
			// 커넥션 풀을 통해 연결 얻기
			con = source.getConnection();								 // 데이터 소스를 통해 풀에 생성되어 있는 연결 객체를 얻어와 멤버 변수에 저장하면 생성이 마무리 된다.
			
			System.out.println("DB 커넥션 풀 연결 성공");
		}catch(Exception e) {
			System.out.println("DB 커넥션 풀 자원 반납");
			e.printStackTrace();
		}
	}
	
	
	// 연결 해제(자원 반납)
	public void close() {
		try {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (psmt != null) psmt.close();
			if (con != null) con.close(); // 자동으로 커넥션 풀로 반납됨
			
			System.out.println("DB 커넥션 풀 자원 반납");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
