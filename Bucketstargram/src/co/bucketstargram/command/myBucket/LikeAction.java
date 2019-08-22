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
		String bucketId = (String)request.getParameter("imageId");
		System.out.println("LikeAction.java | userId = " + userId);
		System.out.println("LikeAction.java | imageId = " + bucketId);
		
		// InsertSuccess, InsertFail 받아옴
		String result = dao.insert(bucketId, userId); 
		System.out.println("LikeAction.java | result = " + result);
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(String.valueOf(result));
		
	}

}
