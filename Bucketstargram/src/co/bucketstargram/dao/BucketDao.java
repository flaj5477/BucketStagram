package co.bucketstargram.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import co.bucketstargram.dto.BucketDto;
import co.bucketstargram.dto.ReplyDto;

public class BucketDao {
    Connection conn = null; // DB연결된 상태(세션)을 담은 객체
    PreparedStatement psmt = null;  // SQL 문을 나타내는 객체
    ResultSet rs = null;  // 쿼리문을 날린것에 대한 반환값을 담을 객체
    
	public BucketDao() {
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

	public boolean insert(BucketDto bucket) {
		// TODO Auto-generated method stub
		boolean insertSuccess = false;
		
		try {
			psmt = conn.prepareStatement("INSERT INTO bucket_info_tb(bucket_id, bucket_member_id, bucket_title, bucket_contents, bucket_type, bucket_image_path) values(?, ?, ?, ?, ?, ?)");
			// 매개변수로 전달된 데이터를 쿼리문의 물음표에 값 매핑
			psmt.setString(1, bucket.getBucketId());
			psmt.setString(2, bucket.getBucketMemberId());
			psmt.setString(3, bucket.getBucketTitle());
			psmt.setString(4, bucket.getBucketContents());
			psmt.setString(5, bucket.getBucketType());
			psmt.setString(6, bucket.getBucketImagePath());
			// 쿼리 수행
			int insertNum = psmt.executeUpdate();
			if(insertNum > 0) {
				System.out.println("--- BucketDao.java | DB입력 성공 ---");
				insertSuccess = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return insertSuccess;
		} finally {
			close();
		}

		return insertSuccess;
	}

	public ArrayList<BucketDto> select(String userid) {
		// TODO Auto-generated method stub
		ArrayList<BucketDto> bucketList = null;
		BucketDto bucket = null;
		String sql = "SELECT * FROM bucket_info_tb LEFT OUTER JOIN " + 
				             "(SELECT mwl_bucket_id, COUNT(*) like_cnt FROM member_wish_list_tb GROUP BY mwl_bucket_id) " + 
				              "ON bucket_id = mwl_bucket_id " + 
				              "WHERE bucket_member_id=?";
		
		try {
			bucketList = new ArrayList<BucketDto>();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userid);
			rs = psmt.executeQuery();
			while(rs.next()) {
				bucket = new BucketDto();
				bucket.setBucketId(rs.getString("BUCKET_ID"));
				bucket.setBucketMemberId(rs.getString("BUCKET_MEMBER_ID"));
				bucket.setBucketTitle(rs.getString("BUCKET_TITLE"));
				bucket.setBucketContents(rs.getString("BUCKET_CONTENTS"));
				bucket.setBucketType(rs.getString("BUCKET_TYPE"));
				bucket.setBucketLike(rs.getInt("BUCKET_LIKE"));
				bucket.setBucketImagePath(rs.getString("BUCKET_IMAGE_PATH"));
				bucket.setBucketTag(rs.getString("BUCKET_TAG"));
				bucket.setBucketWriteDate(rs.getString("BUCKET_WRITE_DATE"));
				bucket.setBucketLike(rs.getInt("like_cnt"));
				
				bucketList.add(bucket);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return bucketList;
	}

	public ArrayList<HashMap<String, String>> getBucketInfo(String userId) {
		// TODO Auto-generated method stub'
		ArrayList<HashMap<String, String>> bucketInfoList = null;
		HashMap<String, String> bucket = null;
		
		String sql = "select * from (select * from (select * from bucket_info_tb where bucket_member_id = ?) left outer join " + 
				                   "(select mwl_bucket_id, count(*) likeCnt from member_wish_list_Tb GROUP BY mwl_bucket_id) " + 
				                   "on bucket_id = mwl_bucket_id) " + 
				                   "left outer join " + 
				                   "(select re_bucket_id, count(*) replyCnt from bucket_reply_tb group by re_bucket_id) " + 
				                   "on bucket_id = re_bucket_id";
		
		try {
			bucketInfoList = new ArrayList<HashMap<String, String>>();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				bucket = new HashMap<String, String>();
				
				bucket.put("bucketId",rs.getString("BUCKET_ID"));
				bucket.put("bucketMemberId",rs.getString("BUCKET_MEMBER_ID"));
				bucket.put("bucket_title",rs.getString("BUCKET_TITLE"));
				bucket.put("bucket_contents",rs.getString("BUCKET_CONTENTS"));
				bucket.put("bucket_type",rs.getString("BUCKET_TYPE"));
				bucket.put("bucket_compliation",rs.getString("BUCKET_COMPLIATION"));
				bucket.put("bucket_like", Integer.toString(rs.getInt("likeCnt")));
				bucket.put("bucketImagePath",rs.getString("BUCKET_IMAGE_PATH"));
				bucket.put("bucketTag",rs.getString("BUCKET_TAG"));
				bucket.put("bucketWriteDate",rs.getString("BUCKET_WRITE_DATE"));
				//내 버킷에는 좋아요 못누르니까 그냥 초기값을 N으로 설정함
				bucket.put("likeYN", "N");
				
				bucketInfoList.add(bucket);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return bucketInfoList;
	}
	
	private String getLikeCnt(String imageId, String userId) {
		// TODO Auto-generated method stub
		String sql = "SELECT count(*) AS bucket_like FROM member_wish_list_tb WHERE mwl_bucket_id = ? AND mwl_member_id = ?";
		String likeCnt = "";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, imageId);
			psmt.setString(2, userId);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				likeCnt = rs.getString("bucket_like"); 
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return likeCnt;
	}

	private String getLikeYN(String imageId, String userId) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM member_wish_list_tb WHERE mwl_bucket_id = ? AND mwl_member_id = ?";
		String likeYN = "N";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, imageId);
			psmt.setString(2, userId);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				likeYN = "Y";
			}else {
				likeYN = "N";
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return likeYN;
	}
	
	public String likeDelete(String bucketId, String userId) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM member_wish_list_tb WHERE mwl_bucket_id = ? AND mwl_member_id = ?";
		String result = "";
			
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bucketId);
			psmt.setString(2, userId);
			int deleteCnt = psmt.executeUpdate();
			
			if(deleteCnt>0) {
				result="deleteSuccess";
			}
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println("Delete개수 DB 반영 실패");
			result = "deleteFail";
			e.printStackTrace();
			return result;
		}finally {
			close();
		}		
				
		return result;
	}
	
	public String likeInsert(String bucketId, String userId) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO member_wish_list_tb VALUES(?, ?)";
		String result = "";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			psmt.setString(2, bucketId);
			int insertCnt = psmt.executeUpdate();
			
			if(insertCnt>0) {
				result="insertSuccess";
			}
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println("Insert개수 DB 반영 실패");
			result = "insertFail";
			e.printStackTrace();
			return result;
		}finally {
			close();
		}
				
		return result;
	}

	public ArrayList<HashMap<String, String>> getWishBucketInfo(String userId) {
		// TODO Auto-generated method stub
		
		ArrayList<HashMap<String, String>> bucketInfoList = null;
		HashMap<String, String> bucket = null;
		String sql = "SELECT * FROM (SELECT bucket_info_tb.*, likeCnt FROM bucket_info_tb, (SELECT mwl_bucket_id, COUNT(*) likeCnt FROM member_wish_list_Tb GROUP BY mwl_bucket_id) " + 
				                    "WHERE bucket_id=mwl_bucket_id AND mwl_bucket_id IN (SELECT mwl_bucket_id FROM member_wish_list_tb WHERE mwl_member_id = ?)), " + 
				                    "(SELECT re_bucket_id, COUNT(*) reply_cnt FROM bucket_reply_tb GROUP BY re_bucket_id) " + 
				     "WHERE bucket_id = re_bucket_id";
		
		try {
			bucketInfoList = new ArrayList<HashMap<String, String>>();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();
			System.out.println("--- getWishBucketInfo 쿼리 정상 ---");

			while(rs.next()) {
				bucket = new HashMap<String, String>();
				bucket.put("bucketId",rs.getString("BUCKET_ID"));
				bucket.put("bucketMemberId",rs.getString("BUCKET_MEMBER_ID"));
				bucket.put("bucket_title",rs.getString("BUCKET_TITLE"));
				bucket.put("bucket_contents",rs.getString("BUCKET_CONTENTS"));
				bucket.put("bucket_type",rs.getString("BUCKET_TYPE"));
				bucket.put("bucket_compliation",rs.getString("BUCKET_COMPLIATION"));
				bucket.put("bucket_like", rs.getString("likeCnt"));
				bucket.put("bucketImagePath",rs.getString("BUCKET_IMAGE_PATH"));
				bucket.put("bucketTag",rs.getString("BUCKET_TAG"));
				bucket.put("bucketWriteDate",rs.getString("BUCKET_WRITE_DATE"));
				bucket.put("likeYN", "Y");
				bucket.put("replyCnt", Integer.toString(rs.getInt("REPLY_CNT")));
				
				bucketInfoList.add(bucket);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("--- getWishBucketInfo DB 작업 실패---");
		} finally {
			close();
		}
		
		return bucketInfoList;
	}

	public String delete(String bucketId) {
		// TODO Auto-generated method stub
		String result=null;
		String sql = "DELETE FROM bucket_info_tb WHERE bucket_id = ?";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bucketId);
			int deleteCnt = psmt.executeUpdate();
			
			if(deleteCnt>0) {
				result="deleteSuccess";
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
			result="deleteFail";
			return result;					
		}finally {
			close();
		}
		
		return result;
	}

	public String completionUpdate(String bucketId, String completionYN) {
		// TODO Auto-generated method stub
		String result = "challenging";
		String sql="";
		if(completionYN.equals("challenging") ||  completionYN == "challenging") {
			System.out.println("completion");
			sql = "UPDATE bucket_info_tb SET bucket_compliation='completion' WHERE bucket_id= ?";
			result = "completion";
		}else {
			System.out.println("challenging");
			sql = "UPDATE bucket_info_tb SET bucket_compliation='challenging' WHERE bucket_id= ?";
			result = "challenging";
		}
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bucketId);
			psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("DB작업 실패");
			e.printStackTrace();
			result="deleteFail";
			// TODO: handle exception
		}
		
		return result;
	}

	public BucketDto getBucketInfo(String userId, String bucketId) {
		// TODO Auto-generated method stub
		BucketDto bucket = new BucketDto();
		String likeYN=null;
		if(userId == null) {
			likeYN = "N";
		}else {			
			likeYN = getLikeYN(bucketId, userId);
		}
		int replyCnt = getReplyCnt(bucketId);
		String sql = "SELECT * FROM (SELECT * FROM bucket_info_tb WHERE bucket_id = ?) " + 
								    "LEFT OUTER JOIN " + 
								    "(SELECT mwl_bucket_id, COUNT(*) like_cnt FROM member_wish_list_tb GROUP BY mwl_bucket_id) " + 
								    "ON bucket_id = mwl_bucket_id";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bucketId);
			rs = psmt.executeQuery();
			
			if(rs.next()) {				
				bucket.setBucketId(rs.getString("BUCKET_ID"));
				bucket.setBucketMemberId(rs.getString("BUCKET_MEMBER_ID"));
				bucket.setBucketTitle(rs.getString("BUCKET_TITLE"));
				bucket.setBucketContents(rs.getString("BUCKET_CONTENTS"));
				bucket.setBucketType(rs.getString("BUCKET_TYPE"));
				bucket.setBucketCompliation(rs.getString("BUCKET_COMPLIATION"));
				bucket.setBucketLike(rs.getInt("like_cnt"));
				bucket.setBucketImagePath(rs.getString("BUCKET_IMAGE_PATH"));
				bucket.setBucketTag(rs.getString("BUCKET_TAG"));
				bucket.setBucketWriteDate(rs.getString("BUCKET_WRITE_DATE"));
				bucket.setBucketLiketYN(likeYN);
				bucket.setBucketReplyCnt(replyCnt);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return bucket;
	}

	private int getReplyCnt(String bucketId) {
		// TODO Auto-generated method stub
		int replyCnt = 0;
		String sql = "SELECT re_bucket_id, COUNT(*) reply_cnt FROM bucket_reply_tb WHERE re_bucket_id=? GROUP BY re_bucket_id";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bucketId);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				replyCnt = rs.getInt("reply_cnt"); 
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return replyCnt;
	}

	public String getImagePathbucketId(String bucketId) {
		// TODO Auto-generated method stub
		String imagePath=null;
		String sql ="SELECT bucket_image_path FROM bucket_info_tb WHERE bucket_id = ?";
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, bucketId);
			rs = psmt.executeQuery();
			if(rs.next()) {
				imagePath = rs.getString("bucket_image_path");
			}
		}catch (SQLException e) {
			// TODO: handle exception
		}finally {
			close();
		}
		return imagePath;
	}
}
