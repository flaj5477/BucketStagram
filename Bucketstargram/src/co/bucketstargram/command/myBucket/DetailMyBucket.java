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
import co.bucketstargram.dao.ReplyDao;
import co.bucketstargram.dto.BucketDto;
import co.bucketstargram.dto.ReplyDto;

public class DetailMyBucket implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("--- DetailMyBucket.java ---");
		HttpSession session = request.getSession(true);
		String userId = (String) session.getAttribute("userid");
		String bucketId = request.getParameter("bucketId");
		System.out.println("DetailMyBucket.java | usersId = " + userId);
		System.out.println("DetailMyBucket.java | bucketId = " + bucketId);
		
		BucketDao bucketDao = new BucketDao();
		ReplyDao replyDao = new ReplyDao();
		BucketDto bucket = bucketDao.getBucketInfo(userId, bucketId);
		ArrayList<ReplyDto> replyList = replyDao.getReplyInfo(bucketId);
		System.out.println(bucket.getBucketImagePath());
		session.setAttribute("ownerId", userId);
		request.setAttribute("bucket", bucket);
		request.setAttribute("replyList", replyList);
		
		String viewPage = "jsp/mybucket/DetailBucket.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
