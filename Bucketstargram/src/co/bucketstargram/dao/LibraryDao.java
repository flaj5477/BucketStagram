package co.bucketstargram.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import co.bucketstargram.dto.LibraryDto;

public class LibraryDao {
	Connection conn = null; // DB연결된 상태(세션)을 담은 객체
    PreparedStatement psmt = null;  // SQL 문을 나타내는 객체
    ResultSet rs = null;  // 쿼리문을 날린것에 대한 반환값을 담을 객체
    
	public LibraryDao() {
		// TODO Auto-generated constructor stub
		try {
            String user = "lee"; 
            String pw = "1234";
            String url = "jdbc:oracle:thin:@114.200.227.226:1521:xe";
            
            Class.forName("oracle.jdbc.driver.OracleDriver");        
            conn = DriverManager.getConnection(url, user, pw);
            
        } catch (ClassNotFoundException cnfe) {
            System.out.println("DB 드라이버 로딩 실패 :"+cnfe.toString());
        } catch (SQLException sqle) {
            System.out.println("DB 접속실패 : "+sqle.toString());
        } catch (Exception e) {
            System.out.println("Unkonwn error");
            e.printStackTrace();
        }
	}
	
	private void close() {
		// TODO Auto-generated method stub
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public ArrayList<LibraryDto> getLibraryList() {
		// TODO Auto-generated method stub
		ArrayList<LibraryDto> libraryList = null;
		LibraryDto library = null;
		String sql = "SELECT * FROM library_info_tb";
		
		try {
			libraryList = new ArrayList<LibraryDto>();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				library = new LibraryDto();
				library.setLibId(rs.getString("LIB_ID"));
				library.setLibTitle(rs.getString("LIB_TITLE"));
				library.setLibContents(rs.getString("LIB_CONTENTS"));
				library.setLibType(rs.getString("LIB_TYPE"));
				library.setLibLike(rs.getInt("LIB_LIKE"));			//좋아요가 필요할까??? 위시리스트에서 갯수 조회해서 가져올껀데?
				library.setLibImagePath(rs.getString("LIB_IMAGE_PATH"));
				library.setLibWriteDate(rs.getString("LIB_WRITE_DATE"));
				
				libraryList.add(library);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return libraryList;
	}
	
	
}
