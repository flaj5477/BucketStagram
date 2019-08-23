package co.bucketstargram.command.myBucket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import co.bucketstargram.common.Command;
import co.bucketstargram.dao.BucketDao;
import co.bucketstargram.dao.ReplyDao;

public class GetWishInfo implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Get WishList Ajax 호출");
		HttpSession session = request.getSession(true);
		String userId = (String) session.getAttribute("userid");
		System.out.println("GetWishInfo.java | usersId = " + userId);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(getJSON(userId));		
	}
	
	private String getJSON(String userId) {
		System.out.println("getJSON 호출");
		BucketDao bDao = new BucketDao();
		ReplyDao reDao = new ReplyDao();

		ArrayList<HashMap<String, String>> bucketInfo = bDao.getWishInfo(userId);
		ArrayList<HashMap<String, String>> replyInfoList = reDao.getWishReplyInfo(userId);	
		
		JSONObject json = new JSONObject();
		
//		json.put("bucket", JSONObject.toJSONString(bucketInfo)); 
//		json.put("reply", JSONArray.toJSONString(replyInfoList)); 이렇게 할 경우 제이슨 객체의 value값으로 배열이 담기는게 아니라 스틀링으로 담긴다 그래서 파싱을 두 번 해줘야됨
		json.put("bucket", bucketInfo);
		json.put("reply", replyInfoList);
		System.out.println("json.toString() = " + json.toString());
		
		return json.toString();
	}
}
