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

public class WishListAction implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("--- WishListAction.java ---");
		HttpSession session = request.getSession(true);
		String userId = (String)session.getAttribute("userid");
		String ownerId = (String)session.getAttribute("ownerId");
		System.out.println("WishListAction.java | usersId = " + userId);
		System.out.println("WishListAction.java | ownerId = " + ownerId);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(getWishJSON(ownerId));	

	}
	
	private String getWishJSON(String id) {
		System.out.println("--- WishInfo getJSON 호출 ---");
		BucketDao bDao = new BucketDao();
		ReplyDao reDao = new ReplyDao();

		ArrayList<HashMap<String, String>> wBucketInfoList = bDao.getWishBucketInfo(id);
		ArrayList<HashMap<String, String>> wReplyInfoList = reDao.getWishReplyInfo(id);	
		
		JSONObject wishJson = new JSONObject();
		
//		json.put("bucket", JSONObject.toJSONString(wBucketInfoList)); 
//		json.put("reply", JSONArray.toJSONString(wReplyInfoList)); 이렇게 할 경우 제이슨 객체의 value값으로 배열이 담기는게 아니라 스틀링으로 담긴다 그래서 파싱을 두 번 해줘야됨
		wishJson.put("bucket", wBucketInfoList);
		wishJson.put("reply", wReplyInfoList);
		System.out.println("json.toString() = " + wishJson.toString());
		
		return wishJson.toString();
	}
}
