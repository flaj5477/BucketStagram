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
import co.bucketstargram.dto.BucketDto;

public class OtherBucket implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- OtherBucket.java ---");
		String ownerId = request.getParameter("ownerId");
		System.out.println("ownerId = " + ownerId);
		
		BucketDao bucketDao = new BucketDao();
		//ReplyDao replyDao = new ReplyDao();
		ArrayList<BucketDto> bucketList = bucketDao.select(ownerId);
		//ArrayList<HashMap<String, String>> myBucketList = bucketDao.getMyBucketInfo(userid);
		
		HttpSession session = request.getSession(true);
		session.setAttribute("ownerId", ownerId);
		String idTest = (String)session.getAttribute("ownerId");
		System.out.println("ownerIdTest = " + idTest);
		request.setAttribute("bucketList", bucketList);
		String viewPage = "jsp/mybucket/MyBucket2.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
