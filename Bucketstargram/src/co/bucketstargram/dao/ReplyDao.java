package co.bucketstargram.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class ReplyDao {

	Connection conn = null; // DB연결된 상태(세션)을 담은 객체
    PreparedStatement psmt = null;  // SQL 문을 나타내는 객체
    ResultSet rs = null;  // 쿼리문을 날린것에 대한 반환값을 담을 객체
    
	public ReplyDao() {
		// TODO Auto-generated constructor stub
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
	
	
	public ArrayList<HashMap<String, String>> getReplyInfo(String imageId) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, String>> replyInfoList = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> reply = null;
		//String sql = "SELECT re_member_id, re_reply_contents FROM bucket_reply_tb WHERE re_bucket_id = '" + imageId + "'";
		String sql = "SELECT * FROM bucket_reply_tb br WHERE re_bucket_id = ?"; 
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, imageId);
			rs = psmt.executeQuery();

			while(rs.next()) {
				reply = new HashMap<String, String>();
				
				reply.put("reBucketId", rs.getString("re_bucket_id"));
				reply.put("reReplyId",rs.getString("re_reply_id"));
				reply.put("reMemberId",rs.getString("re_member_id"));
				reply.put("reReplyContents",rs.getString("re_reply_contents"));
				reply.put("reWriteDate",rs.getString("re_write_date"));
				
				replyInfoList.add(reply);
			
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		System.out.println("ReplyDao.java | replyInfoList.size() = " + replyInfoList.size());
		return replyInfoList;
	}

	public boolean insert(String replyId, String bucketId, String memberId, String replyCotents) {
		// TODO Auto-generated method stub
		boolean insertSuccess = false;
		String sql = "insert into bucket_reply_tb(RE_REPLY_ID, RE_BUCKET_ID, RE_MEMBER_ID, RE_REPLY_CONTENTS) values(?, ?, ?, ?)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, replyId);
			psmt.setString(2, bucketId);
			psmt.setString(3, memberId);
			psmt.setString(4, replyCotents);
			int n = psmt.executeUpdate();
			if(n != 0) {
				insertSuccess = true;
			}
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			close();
		}
		
		return insertSuccess;
	}
}