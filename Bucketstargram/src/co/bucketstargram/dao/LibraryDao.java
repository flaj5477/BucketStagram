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
	
	public ArrayList<LibraryDto> getLibPhotoList() {
		// TODO Auto-generated method stub
		ArrayList<LibraryDto> libraryList = null;
		LibraryDto library = null;
		String sql = "SELECT lib_id, lib_type, lib_image_path, (select count(*) from LIBRARY_WISH_LIST_TB where LWL_LIB_ID=lib.LIB_ID) as cnt \r\n" + 
				"FROM library_info_tb lib";
		
		try {
			libraryList = new ArrayList<LibraryDto>();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				library = new LibraryDto();
				library.setLibId(rs.getString("LIB_ID"));
				//library.setLibTitle(rs.getString("LIB_TITLE"));
				//library.setLibContents(rs.getString("LIB_CONTENTS"));
				library.setLibType(rs.getString("LIB_TYPE"));
				library.setLibLike(rs.getInt("cnt"));	//나중에 library순위대로 출력 할때 필요할듯
				library.setLibImagePath(rs.getString("LIB_IMAGE_PATH"));
				//library.setLibWriteDate(rs.getString("LIB_WRITE_DATE"));
				
				libraryList.add(library);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return libraryList;
	}
	
	public LibraryDto getdetailLib(String libId) {	
		LibraryDto library = new LibraryDto();
		String sql = "SELECT lib_title, lib_contents, lib_type, lib_image_path, lib_write_date " + 
				"FROM library_info_tb lib where lib_id = ?";
		String sql2 = "select lwl_member_id from LIBRARY_WISH_LIST_TB where LWL_LIB_ID= ? ";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, libId);
			rs = psmt.executeQuery();
			while(rs.next()) {
				library.setLibId(libId);
				library.setLibTitle(rs.getString("lib_title"));
				library.setLibContents(rs.getString("lib_contents"));
				library.setLibType(rs.getString("lib_type"));
				//library.setLibLike(rs.getInt("cnt"));
				library.setLibImagePath(rs.getString("lib_image_path"));
				library.setLibWriteDate(rs.getString("lib_write_date"));
			}
			
			psmt = conn.prepareStatement(sql2);	//라이브러리를 좋아요한 사람 리스트
			psmt.setString(1, libId);
			ResultSet rs2 = psmt.executeQuery();
			int libLikeCnt = 0;
			while(rs2.next()) {
				System.out.println(rs2.getString("lwl_member_id"));
				libLikeCnt++;
			//	library.addLibLikeMembList(rs2.getString("lwl_member_id"));
				//여기서 에러났음 왜났을까.............................................???????????????????????????????????????????????????
			}     
	        library.setLibLike(libLikeCnt); //좋아하는 사람 숫자
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		return library;
	}
	
	
}
