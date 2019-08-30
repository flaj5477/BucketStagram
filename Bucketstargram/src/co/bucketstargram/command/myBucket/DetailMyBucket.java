package co.bucketstargram.command.myBucket;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.BucketDao;
import co.bucketstargram.dao.LoginDao;
import co.bucketstargram.dao.ReplyDao;
import co.bucketstargram.dto.BucketDto;
import co.bucketstargram.dto.ReplyDto;

public class DetailMyBucket implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- DetailMyBucket.java ---");
		HttpSession session = request.getSession(true);
		String userId = (String) session.getAttribute("userid");
		String bucketId = request.getParameter("bucketId");
		String bucketMemberId = request.getParameter("bucketMemberId");
		
		System.out.println("usersId = " + userId);
		System.out.println("bucketId = " + bucketId);
		System.out.println("bucketMemberId = " + bucketMemberId);
		
		BucketDao bucketDao = new BucketDao();
		ReplyDao replyDao = new ReplyDao();
		LoginDao loginDao = new LoginDao();
		
		BucketDto bucket = bucketDao.getBucketInfo(userId, bucketId);
		ArrayList<ReplyDto> replyList = replyDao.getReplyInfo(bucketId);
		String userImagePath = loginDao.getUserImagePath(bucketMemberId);
		//ArrayList reUserImagePath = loginDao.getReUserImagePath()
		System.out.println("userImagePath = " + userImagePath);
		
		session.setAttribute("ownerId", userId);
		request.setAttribute("bucket", bucket);
		request.setAttribute("replyList", replyList);
		request.setAttribute("userImagePath", userImagePath);
		
		String viewPage = "jsp/mybucket/DetailBucket.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
