package fileupload;

import java.util.List;
import java.util.Vector;

import common.DBConnPool;

public class MyfileDAO extends DBConnPool{ // 커넥션 풀을 사용하기 위해 DBConnPool을 상속한다.
	// 새로운 게시물을 입력한다.
    public int insertFile(MyfileDTO dto) {
		// 새로운 게시물을 입력하기 위한 메서드, 매개변수로 DTO 객체를 받고, 작성폼을 통해 전송된 값이 DTO 객체에 저장한 후
		// 이 insertFile() 메서드의 인수로 전달된다.
        int applyResult = 0;
        try {
            String query = "INSERT INTO MYFILE ( "
                + " idx, name, title, cate, ofile, sfile, postdate) "
                + " VALUES ( "
                + " seq_myfile_num.nextval, ?, ?, ?, ?, ?, sysdate)";
                        
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getName());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getCate());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile());
        
            applyResult = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("INSERT 중 예외 발생");
            e.printStackTrace();
        }        
        return applyResult;
    }
    
    // 파일 목록을 반환한다.
    public List<MyfileDTO> myFileList(){
    	List<MyfileDTO> fileList = new Vector<MyfileDTO>();
    	
    	// 쿼리문 작성
    	String query = "SELECT * FROM myfile ORDER BY idx DESC";
    	try {
    		psmt = con.prepareStatement(query);  // 쿼리 준비
    		rs = psmt.executeQuery();			 // 쿼리 실행
    		
    		while(rs.next()) {
    			// DTO에 저장
    			MyfileDTO dto = new MyfileDTO();
    			dto.setIdx(rs.getString(1));
    			dto.setName(rs.getString(2));
    			dto.setTitle(rs.getString(3));
    			dto.setCate(rs.getString(4));
    			dto.setOfile(rs.getString(5));
    			dto.setSfile(rs.getString(6));
    			dto.setPostdate(rs.getString(7));
    			
    			fileList.add(dto); // 목록에 추가
    		}
    	}catch(Exception e) {
    		System.out.println("SELECT 시 예외 발생");
    		e.printStackTrace();
    	}
    	
    	return fileList; // 목록 반환
    }
}