package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;

public class JDBConnect {
	public Connection con; // 데이터베이스와 연결을 담당
	public Statement stmt; // 인파라미터가 없는 정적 쿼리문을 실행할 때 사용
	public PreparedStatement psmt; // 인파리미터가 잇는 동적 쿼리문을 실행할 때 사용 인파라미터는 쿼리문 작성 시 매개변수로 전달된 값을 설정할때 사용
								   // ?(물음표)로 표현
	public ResultSet rs;
	
	// 기본 생성자
	 public JDBConnect() {
	        try {
	            // JDBC 드라이버 로드
	            Class.forName("oracle.jdbc.OracleDriver");

	            // DB에 연결
	            String url = "jdbc:oracle:thin:@localhost:1521:xe";  
	            String id = "musthave";
	            String pwd = "1234"; 
	            con = DriverManager.getConnection(url, id, pwd); 

	            System.out.println("DB 연결 성공(기본 생성자)");
	        }
	        catch (Exception e) {            
	            e.printStackTrace();
	        }
	    }
	
	// 연결 해제(자원 반납)
	public void close() {
		try {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (psmt != null) psmt.close();
			if (con != null) con.close();
			
			System.out.println("JDBC 자원 해제");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 두번째 생성자
	public JDBConnect(String driver, String url, String id, String pwd) {
		try {
			// JDBC 드라이버 로드
			Class.forName(driver);
			
			// DB에 연결
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(인수 생성자1)");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//  세번째 생성자
	public JDBConnect(ServletContext application) {
		try {
			// JDBC 드라이버 로드 
			String driver = application.getInitParameter("OracleDriver");
			Class.forName(driver);
			
			// DB에 연결
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pwd = application.getInitParameter("OraclePwd");
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공(인수 생성자2)");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
