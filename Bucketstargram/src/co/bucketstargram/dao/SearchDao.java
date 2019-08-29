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
	
	public ArrayList<LibraryDto> librarySearch(String word){
		LibraryDto dto = null;
		ArrayList<LibraryDto> libResult = new ArrayList<LibraryDto>();
		String sql = "SELECT lib_id, lib_title, lib_type, lib_like, lib_image_path "
					+"FROM library_info_tb " 
					+"WHERE UPPER(lib_title) LIKE '%'||UPPER(?)||'%' "
					+"OR UPPER(lib_contents) LIKE '%'||UPPER(?)||'%' "
					+"OR UPPER(lib_type) LIKE '%'||UPPER(?)||'%'"
					+"ORDER BY lib_id";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,word); 
			psmt.setString(2,word);
			psmt.setString(3,word);
			rs = psmt.executeQuery();
			while (rs.next()) {
				dto = new LibraryDto();
				dto.setLibId(rs.getString(1));
				dto.setLibTitle(rs.getString(2));
				dto.setLibType(rs.getString(3));
				dto.setLibLike(rs.getInt(4));
				dto.setLibImagePath(rs.getString(5));
				libResult.add(dto);		
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return libResult;
	}
	public ArrayList<BucketDto> bucketSearch(String word){
		BucketDto dto = null;
		ArrayList<BucketDto> bucketResult = new ArrayList<BucketDto>();
		String sql = "SELECT bucket_id, bucket_member_id, bucket_title, bucket_type, "
					+"bucket_compliation, bucket_like, bucket_image_path "
					+"FROM bucket_info_tb "
					+"WHERE bucket_title LIKE '%'||UPPER(?)||'%' "
					+"OR bucket_contents LIKE '%'||UPPER(?)||'%' "
					+"OR bucket_type LIKE '%'||UPPER(?)||'%'"
					+"ORDER BY bucket_id";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,word); 
			psmt.setString(2,word);
			psmt.setString(3,word);
			rs = psmt.executeQuery();
			while (rs.next()) {
				dto = new BucketDto();
				dto.setBucketId(rs.getString(1));
				dto.setBucketMemberId(rs.getString(2));
				dto.setBucketTitle(rs.getString(3));
				dto.setBucketType(rs.getString(4));
				dto.setBucketCompliation(rs.getString(5));
				dto.setBucketLike(rs.getInt(6));
				dto.setBucketImagePath(rs.getString(7));
				bucketResult.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bucketResult;
	}
	
	public int libCount(String word) {
		int count = 0;
		String sql = "SELECT count(rownum)"
					+"FROM library_info_tb "
					+"WHERE lib_title LIKE '%'||UPPER(?)||'%' "
					+"OR lib_contents LIKE '%'||UPPER(?)||'%' "
					+"OR lib_type LIKE '%'||UPPER(?)||'%'";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,word); 
			psmt.setString(2,word);
			psmt.setString(3,word);
			rs = psmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public int bucketCount(String word) {
		int count = 0;
		String sql = "SELECT count(rownum)"
					+"FROM bucket_info_tb "
					+"WHERE bucket_title LIKE '%'||UPPER(?)||'%' "
					+"OR bucket_contents LIKE '%'||UPPER(?)||'%' "
					+"OR bucket_type LIKE '%'||UPPER(?)||'%'";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,word); 
			psmt.setString(2,word);
			psmt.setString(3,word);
			rs = psmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
}
