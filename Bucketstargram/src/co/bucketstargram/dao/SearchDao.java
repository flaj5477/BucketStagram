package co.bucketstargram.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import co.bucketstargram.dto.BucketDto;
import co.bucketstargram.dto.LibraryDto;

public class SearchDao {
	Connection conn = null; // DB연결된 상태(세션)을 담은 객체
    PreparedStatement psmt = null;  // SQL 문을 나타내는 객체
    ResultSet rs = null;  // 쿼리문을 날린것에 대한 반환값을 담을 객체
    
	public SearchDao() {
		try {
            String user = "lee"; 
            String pw = "1234";
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            
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
	
	public void close() {
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public ArrayList<BucketDto> bucketSearch(String word){
		String sql = "SELECT bucket_member_id, bucket_title, bucket_type, "
					+"bucket_compliation, bucket_like, bucket_image_path "
					+"FROM bucket_info_tb "
					+"WHERE bucket_title LIKE '%'||UPPER(?)||'%' "
					+"OR bucket_contents LIKE '%'||UPPER(?)||'%' "
					+"OR bucket_type LIKE '%'||UPPER(?)||'%'";

		ArrayList<BucketDto> bucketResult = new ArrayList<BucketDto>();
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,word); 
			psmt.setString(2,word);
			psmt.setString(3,word);
			rs = psmt.executeQuery();
			while (rs.next()) {
				BucketDto dto = new BucketDto();
				dto.setBucketMemberId(rs.getString(1));
				dto.setBucketTitle(rs.getString(2));
				dto.setBucketType(rs.getString(3));
				dto.setBucketCompliation(rs.getString(4));
				dto.setBucketLike(rs.getInt(5));
				dto.setBucketImagePath(rs.getString(6));
				bucketResult.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bucketResult;
	}
	
	public ArrayList<LibraryDto> librarySearch(String word){
		String sql = "SELECT lib_title, lib_type, lib_like, lib_image_path "
					+"FROM library_info_tb " 
					+"WHERE UPPER(lib_title) LIKE '%'||UPPER(?)||'%' "
					+"OR UPPER(lib_contents) LIKE '%'||UPPER(?)||'%' "
					+"OR UPPER(lib_type) LIKE '%'||UPPER(?)||'%'";
	 
		
		ArrayList<LibraryDto> libResult = new ArrayList<LibraryDto>();
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,word); 
			psmt.setString(2,word);
			psmt.setString(3,word);
			rs = psmt.executeQuery();
			while (rs.next()) {
				LibraryDto dto = new LibraryDto();
				dto.setLibTitle(rs.getString(1));
				dto.setLibType(rs.getString(2));
				dto.setLibLike(rs.getInt(3));
				dto.setLibImagePath(rs.getString(4));
				libResult.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return libResult;
	}
}
