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
	
	//라이브러리 insert
	public boolean libInsert(LibraryDto library) {
		boolean success = false; 
		
		String sql = "insert into LIBRARY_INFO_TB(LIB_ID, LIB_TITLE, LIB_CONTENTS, LIB_TYPE, LIB_IMAGE_PATH) "
				+ "values(?,?,?,?,?)";
		
		try {
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, library.getLibId());
			psmt.setString(2, library.getLibTitle());
			psmt.setString(3, library.getLibContents());
			psmt.setString(4, library.getLibType());
			psmt.setString(5, library.getLibImagePath());
			
			int result = psmt.executeUpdate();
			if(result > 0) {
				System.out.println("------LibraryDao.java | DB입력 성공----------");
				success = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		
		return success;
	}
	
	//라이브러리 리스트 전체 select
	public ArrayList<LibraryDto> getLibPhotoList(String libType, int page) {
		// TODO Auto-generated method stub
		System.out.println("라이브러리 타입: " + libType + " 페이지: " + page);
		
		ArrayList<LibraryDto> libraryList = null;
		LibraryDto library = null;
		String where = "";
		
		//가져올 게시글 번호
		int begin = (page-1) * 20 + 1;
		int end = page * 20;
		
		if(libType!=null && libType!="") {

			where = "where lib_type= ?";
		}
		
		//20부터 30까지 출력
		String sql = "SELECT X.rn, X.*\r\n" + 
				"FROM\r\n" + 
				"  (SELECT rownum as rn, L.* \r\n" + 
				"  FROM \r\n" + 
				"    (select lib_id, lib_image_path, lib_type from library_info_tb " + where + " order by TO_NUMBER(lib_id)) L\r\n" + 
				"  WHERE rownum <=?) X\r\n" + 
				"WHERE X.rn >=?";
		
		try {
			libraryList = new ArrayList<LibraryDto>();
			psmt = conn.prepareStatement(sql);
			if(libType!=null && libType!="") {	//타입이 있을때
				psmt.setString(1, libType);
				psmt.setInt(2, end);
				psmt.setInt(3, begin);
			}
			else {	//타입이 없을때 
				psmt.setInt(1, end);
				psmt.setInt(2, begin);
			}
			rs = psmt.executeQuery();
			while(rs.next()) {
				library = new LibraryDto();
				library.setLibId(rs.getString("LIB_ID"));
				//library.setLibTitle(rs.getString("LIB_TITLE"));
				//library.setLibContents(rs.getString("LIB_CONTENTS"));
				library.setLibType(rs.getString("LIB_TYPE"));
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
	
	//라이브러리 상세정보 select
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
				library.addLibLikeMembList(rs2.getString("lwl_member_id"));
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

	//라이브러리 삭제
	public boolean delete(String libId) {	
		boolean success = false;
		String sql = "delete LIBRARY_INFO_TB where LIB_ID = ?";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, libId);
			int result = psmt.executeUpdate();
			if(result > 0) {
				success = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		return success;
	}
	
	
}
