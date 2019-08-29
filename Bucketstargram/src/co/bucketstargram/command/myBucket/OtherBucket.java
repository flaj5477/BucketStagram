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
import co.bucketstargram.dto.BucketDto;

public class OtherBucket implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- OtherBucket.java ---");
		LoginDao loginDao = new LoginDao();
		String ownerId = request.getParameter("ownerId");
		System.out.println("ownerId = " + ownerId);
		
		BucketDao bucketDao = new BucketDao();
		//ReplyDao replyDao = new ReplyDao();
		ArrayList<BucketDto> bucketList = bucketDao.select(ownerId);
		String userImagePath = loginDao.getUserImagePath(ownerId);
		//ArrayList<HashMap<String, String>> myBucketList = bucketDao.getMyBucketInfo(userid);
		
		HttpSession session = request.getSession(true);
		String idTest = (String)session.getAttribute("ownerId");
		System.out.println("ownerIdTest = " + idTest);
		
		session.setAttribute("ownerId", ownerId);
		request.setAttribute("bucketList", bucketList);
		request.setAttribute("userImagePath", userImagePath);
		String viewPage = "jsp/mybucket/MyBucket2.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
