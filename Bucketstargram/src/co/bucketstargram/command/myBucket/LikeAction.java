package co.bucketstargram.command.myBucket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.dao.BucketDao;

public class LikeAction implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		BucketDao dao = new BucketDao();
		
		HttpSession session = request.getSession(true);
		String userId = (String) session.getAttribute("userid");
		String bucketId = (String)request.getParameter("bucketId");
		String likeYN = (String)request.getParameter("likeYN");
		String result = null;
		System.out.println("LikeAction.java | userId = " + userId);
		System.out.println("LikeAction.java | imageId = " + bucketId);
		System.out.println("LikeAction.java | likeYN = " + likeYN);
		
		if(likeYN.equals("Y")) {
			System.out.println("like delete 관련 DB작업 시작");
			result = dao.likeDelete(bucketId, userId);
			System.out.println("like DB작업 결과 = " + result);
		}else {
			System.out.println("like insert 관련 DB작업 시작");
			result = dao.likeInsert(bucketId, userId);
			System.out.println("like DB작업 결과 = " + result);
		}
		
		// insertSuccess, insertFail, deleteSuccess, deleteFail 받아옴
		System.out.println("LikeAction.java | result = " + result);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(String.valueOf(result));
		
	}

}
