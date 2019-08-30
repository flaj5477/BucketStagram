package co.bucketstargram.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import co.bucketstargram.dto.BucketDto;

public class PopularDao {
	Connection conn = null; // DB연결된 상태(세션)을 담은 객체
	PreparedStatement psmt = null; // SQL 문을 나타내는 객체
	ResultSet rs = null; // 쿼리문을 날린것에 대한 반환값을 담을 객체

	public PopularDao() {
		// TODO Auto-generated constructor stub
		try {
			String user = "lee";
			String pw = "1234";
			String url = "jdbc:oracle:thin:@114.200.227.226:1521:xe";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, pw);

		} catch (ClassNotFoundException cnfe) {
			System.out.println("DB 드라이버 로딩 실패 :" + cnfe.toString());
		} catch (SQLException sqle) {
			System.out.println("DB 접속실패 : " + sqle.toString());
		} catch (Exception e) {
			System.out.println("Unkonwn error");
			e.printStackTrace();
		}
	}

	private void close() {
		// TODO Auto-generated method stub
		try {
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public ArrayList<BucketDto> select() {
		// TODO Auto-generated method stub
		ArrayList<BucketDto> bucketList = null;
		BucketDto bucket = null;
		String sql = "SELECT * FROM bucket_info_tb order by bucket_like desc";

		try {
			bucketList = new ArrayList<BucketDto>();
			psmt = conn.prepareStatement(sql);
			// psmt.setString(1, userid);
			rs = psmt.executeQuery();
			while (rs.next()) {
				bucket = new BucketDto();
				bucket.setBucketId(rs.getString("BUCKET_ID"));
				bucket.setBucketMemberId(rs.getString("BUCKET_MEMBER_ID"));
				bucket.setBucketTitle(rs.getString("BUCKET_TITLE"));
				bucket.setBucketContents(rs.getString("BUCKET_CONTENTS"));
				bucket.setBucketType(rs.getString("BUCKET_TYPE"));
				bucket.setBucketLike(rs.getInt("BUCKET_LIKE"));
				bucket.setBucketImagePath(rs.getString("BUCKET_IMAGE_PATH"));
				bucket.setBucketTag(rs.getString("BUCKET_TAG"));
//					bucket.setBucketWriteDate(rs.getString("BUCKET_WRITE_DATE"));

				bucketList.add(bucket);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return bucketList;
	}

	public ArrayList<BucketDto> getPopList(String popType, int page) {
		// TODO Auto-generated method stub
		System.out.println("타입: " + popType + " 페이지: " + page);

		ArrayList<BucketDto> bucketList = null;
		BucketDto bucket = null;
		String where = "";

		// 가져올 게시글 번호
		int begin = (page - 1) * 20 + 1;
		int end = page * 20;

		if (popType != null && popType != "") {

			where = "where bucket_type= ?";
		}

		// 20부터 30까지 출력

		
		/*
		 * String sql = "SELECT X.rn, X.*\r\n" + "FROM\r\n" +
		 * "  (SELECT rownum as rn, B.* \r\n" + "  FROM \r\n" +
		 * "    (select bucket_id, bucket_image_path, bucket_type, bucket_member_id, bucket_title, bucket_like from bucket_info_tb "
		 * + where + " order by bucket_like desc) B\r\n" + "  WHERE rownum <=?) X\r\n" +
		 * "WHERE X.rn >=?";
		 */
		 
		
		
		
		  String sql = "select X.rn, X.* FROM(select rownum as rn, B.* " +
		  "FROM (select * from " + "(select * from (select * from bucket_info_tb "+where+") " +
		  "left outer join(select mwl_bucket_id, count(*) likeCnt from member_wish_list_Tb GROUP BY mwl_bucket_id) "
		  + " on bucket_id = mwl_bucket_id) B order by likeCnt desc nulls last ) B " +
		  "WHERE rownum <=?) X where X.rn >=?";
		 
		 
		 

		
		
		/*
		 * String sql =
		 * "select X.rn, X.* FROM(select rownum as rn, B.* FROM (select bucket_id, bucket_image_path, bucket_type, bucket_member_id, bucket_title, bucket_like from bucket_info_tb"
		 * + where + "order by bucket_like desc) B  WHERE rownum <=?) X WHERE X.rn >=?";
		 */
		 

		try {
			bucketList = new ArrayList<BucketDto>();
			psmt = conn.prepareStatement(sql);
			if (popType != null && popType != "") { // 타입이 있을때
				psmt.setString(1, popType);
				psmt.setInt(2, end);
				psmt.setInt(3, begin);
			} else { // 타입이 없을때
				psmt.setInt(1, end);
				psmt.setInt(2, begin);
			}
			rs = psmt.executeQuery();
			while (rs.next()) {
				bucket = new BucketDto();
				bucket.setBucketId(rs.getString("BUCKET_ID"));
				bucket.setBucketMemberId(rs.getString("BUCKET_MEMBER_ID"));
				bucket.setBucketTitle(rs.getString("BUCKET_TITLE"));
//					bucket.setBucketContents(rs.getString("BUCKET_CONTENTS"));
				bucket.setBucketType(rs.getString("BUCKET_TYPE"));
				bucket.setBucketImagePath(rs.getString("BUCKET_IMAGE_PATH"));
//					bucket.setBucketTag(rs.getString("BUCKET_TAG"));
//					bucket.setBucketWriteDate(rs.getString("BUCKET_WRITE_DATE"));
				bucket.setBucketLike(rs.getInt("likeCnt"));

				bucketList.add(bucket);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return bucketList;
	}

	/*
	 * public ArrayList<BucketDto> select(String column) { // TODO Auto-generated
	 * method stub ArrayList<BucketDto> bucketList = null; BucketDto bucket = null;
	 * String sql =
	 * "SELECT * FROM bucket_info_tb where bucket_type = ? order by bucket_like desc"
	 * ;
	 * 
	 * try { bucketList = new ArrayList<BucketDto>(); psmt =
	 * conn.prepareStatement(sql); psmt.setString(1, column); rs =
	 * psmt.executeQuery(); while(rs.next()) { bucket = new BucketDto();
	 * bucket.setBucketId(rs.getString("BUCKET_ID"));
	 * bucket.setBucketMemberId(rs.getString("BUCKET_MEMBER_ID"));
	 * bucket.setBucketTitle(rs.getString("BUCKET_TITLE"));
	 * bucket.setBucketContents(rs.getString("BUCKET_CONTENTS"));
	 * bucket.setBucketType(rs.getString("BUCKET_TYPE"));
	 * bucket.setBucketLike(rs.getInt("BUCKET_LIKE"));
	 * bucket.setBucketImagePath(rs.getString("BUCKET_IMAGE_PATH"));
	 * bucket.setBucketTag(rs.getString("BUCKET_TAG")); //
	 * bucket.setBucketWriteDate(rs.getString("BUCKET_WRITE_DATE"));
	 * 
	 * bucketList.add(bucket); }
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); } finally { close(); }
	 * 
	 * return bucketList; }
	 * 
	 * public ArrayList<HashMap<String, String>> getBucketInfo(String imageId,
	 * String userId) { // TODO Auto-generated method stub'
	 * ArrayList<HashMap<String, String>> bucketInfoList = null; HashMap<String,
	 * String> bucket = null; String likeYN = getLikeYN(imageId, userId);
	 * 
	 * String sql =
	 * "SELECT * FROM bucket_info_tb WHERE bucket_member_id = ? AND bucket_id = ?";
	 * 
	 * try { bucketInfoList = new ArrayList<HashMap<String, String>>(); psmt =
	 * conn.prepareStatement(sql); psmt.setString(1, userId); psmt.setString(2,
	 * imageId); rs = psmt.executeQuery();
	 * 
	 * while(rs.next()) { bucket = new HashMap<String, String>();
	 * 
	 * bucket.put("bucketId",rs.getString("BUCKET_ID"));
	 * bucket.put("bucketMemberId",rs.getString("BUCKET_MEMBER_ID"));
	 * bucket.put("bucket_title",rs.getString("BUCKET_TITLE"));
	 * bucket.put("bucket_contents",rs.getString("BUCKET_CONTENTS"));
	 * bucket.put("bucket_type",rs.getString("BUCKET_TYPE"));
	 * bucket.put("bucket_compliation",rs.getString("BUCKET_COMPLIATION"));
	 * bucket.put("bucket_like",rs.getString("BUCKET_LIKE"));
	 * bucket.put("bucketImagePath",rs.getString("BUCKET_IMAGE_PATH"));
	 * bucket.put("bucketTag",rs.getString("BUCKET_TAG"));
	 * bucket.put("bucketWriteDate",rs.getString("BUCKET_WRITE_DATE"));
	 * bucket.put("likeYN", likeYN);
	 * 
	 * bucketInfoList.add(bucket); }
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); } finally { close(); }
	 * 
	 * return bucketInfoList; }
	 * 
	 * private String getLikeYN(String imageId, String userId) { // TODO
	 * Auto-generated method stub String sql =
	 * "SELECT * FROM member_wish_list_tb WHERE mwl_bucket_id = ? AND mwl_bucket_id = ?"
	 * ; String likeYN = "N";
	 * 
	 * try { psmt = conn.prepareStatement(sql); psmt.setString(1, imageId);
	 * psmt.setString(2, userId);
	 * 
	 * rs = psmt.executeQuery(); if(rs.next()) { likeYN = "Y"; }else { likeYN = "N";
	 * } } catch (SQLException e) { // TODO: handle exception e.printStackTrace(); }
	 * 
	 * return likeYN; }
	 */
}
