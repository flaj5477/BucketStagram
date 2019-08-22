package co.bucketstargram.command.myBucket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import co.bucketstargram.common.Command;
import co.bucketstargram.dao.BucketDao;
import co.bucketstargram.dao.ReplyDao;

public class GetReply implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Ajax 호출");
		HttpSession session = request.getSession(true);
		String userId = (String) session.getAttribute("userid");
		String imageId = request.getParameter("imageId");
		System.out.println("GetReply.java | usersId = " + userId);
		System.out.println("GetReply.java | imageId = " + imageId);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(getJSON(imageId, userId));		
	}
	
	private String getJSON(String imageId, String userId) {
		System.out.println("getJSON 호출");
		BucketDao bDao = new BucketDao();
		ReplyDao reDao = new ReplyDao();

		HashMap<String, String> bucketInfo = bDao.getBucketInfo(imageId, userId);
		ArrayList<HashMap<String, String>> replyInfoList = reDao.getReplyInfo(imageId);	
		
		JSONObject json = new JSONObject();
		
//		json.put("bucket", JSONObject.toJSONString(bucketInfo)); 
//		json.put("reply", JSONArray.toJSONString(replyInfoList)); 이렇게 할 경우 제이슨 객체의 value값으로 배열이 담기는게 아니라 스틀링으로 담긴다 그래서 파싱을 두 번 해줘야됨
		json.put("bucket", bucketInfo);
		json.put("reply", replyInfoList);
		System.out.println("json.toString() = " + json.toString());
		
		return json.toString();
	}
}












//package co.bucketstargram.command.myBucket;
//
//import java.io.IOException;
//import java.util.ArrayList;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.json.simple.JSONObject;
//
//import co.bucketstargram.common.Command;
//import co.bucketstargram.dao.ReplyDao;
//import co.bucketstargram.dto.ReplyDto;
//
//public class GetReply implements Command {
//
//	@Override
//	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		HttpSession session = request.getSession(true);
//		String userId = (String) session.getAttribute("userid");
//		System.out.println("GetReply.java | usersId = " + userId);
//		response.setContentType("text/html;charset=UTF-8");
//		String imageId = request.getParameter("imageId");
//		System.out.println("GetReply.java | imageId = " + imageId);
//		response.getWriter().write(getJSON(imageId, userId));
//		
//		String data;
//		JSONObject key = new JSONObject();
//		JSONObject value = new JSONObject();
//		
//	}
//	
//	private String getJSON(String imageId, String userId) {
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		if(imageId == null) {
//			imageId="";
//		}
//		
//		StringBuffer result = new StringBuffer("");
////		result.append("{\"result\":[");
////		ReplyDao dao = new ReplyDao();
////		ArrayList<ReplyDto> replyList = dao.select(imageId, userId);
////		for(int i =0; i<replyList.size();i++) {
////			//System.out.println("replyList.get("+i+").getReMemberId() = " + replyList.get(i).getReMemberId());
////			result.append("[{\"value\": \"" + replyList.get(i).getReMemberId()+ "\"},");
////			//System.out.println("replyList.get("+i+").getReReplyContents() = " + replyList.get(i).getReReplyContents());
////			if((i+1)!=replyList.size()) {
////				result.append("{\"value\": \"" + replyList.get(i).getReReplyContents()+ "\"}],");
////			}else {
////				result.append("{\"value\": \"" + replyList.get(i).getReReplyContents()+ "\"}]");
////			}
////		}
////		result.append("]}");
//		
//		//result.append("{\"result\":[");
//		ReplyDao dao = new ReplyDao();
//		ArrayList<ReplyDto> replyList = dao.select(imageId, userId);
//		for(int i =0; i<replyList.size();i++) {
//			if((i+1)!=replyList.size()) {
//				if(i==0) {
//					//댓글이 두개 이상인데 처음 시작일 때
//					result.append("[{\"reMemberId\":\"" + replyList.get(i).getReMemberId() + "\", \"reReplyContent\":\"" + replyList.get(i).getReReplyContents() + "\", \"reWriteDate\":\"" + replyList.get(i).getReWriteDate() +"\"}, ");
//				}else {
//					//댓글이 두개 이상인데 두 번째 이상 시작일 때
//					result.append("{\"reMemberId\":\"" + replyList.get(i).getReMemberId() + "\", \"reReplyContent\":\"" + replyList.get(i).getReReplyContents() + "\", \"reWriteDate\":\"" + replyList.get(i).getReWriteDate() +"\"}, 	");
//				}
//				
//			}else if((i+1) == replyList.size()){
//				if(replyList.size() == 1) {
//					//댓글 하나만 달렸을 경우
//					result.append("[{\"reMemberId\":\"" + replyList.get(i).getReMemberId() + "\", \"reReplyContent\":\"" + replyList.get(i).getReReplyContents() + "\", \"reWriteDate\":\"" + replyList.get(i).getReWriteDate() +"\"}]");;
//				}else {
//					//댓글이 두개 이상 달렸는데 마지막 녀석일 때
//					result.append("{\"reMemberId\":\"" + replyList.get(i).getReMemberId() + "\", \"reReplyContent\":\"" + replyList.get(i).getReReplyContents() + "\", \"reWriteDate\":\"" + replyList.get(i).getReWriteDate() +"\"}]");;	
//				}				
//			}
//		}
//		//result.append("]}");
//		return result.toString();
//	}
//}
