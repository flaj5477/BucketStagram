package co.bucketstargram.command.myBucket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

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

public class MyBucket implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		BucketDao bucketDao = new BucketDao();
		ReplyDao replyDao = new ReplyDao();
		
		HttpSession session = request.getSession(true);
		String userid = (String)session.getAttribute("userid");
		ArrayList<BucketDto> bucketList = bucketDao.select(userid);
		request.setAttribute("bucketList", bucketList);
		String viewPage = "jsp/mybucket/MyBucket.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
