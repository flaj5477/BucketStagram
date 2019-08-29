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

public class MyBucket implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		BucketDao bucketDao = new BucketDao();
		LoginDao loginDao = new LoginDao();
		//ReplyDao replyDao = new ReplyDao();
		
		HttpSession session = request.getSession(true);
		String userId = (String)session.getAttribute("userid");
		ArrayList<BucketDto> bucketList = bucketDao.select(userId);
		String userImagePath = loginDao.getUserImagePath(userId);
		//ArrayList<HashMap<String, String>> myBucketList = bucketDao.getMyBucketInfo(userid);
//		for(BucketDto dto : bucketList) {
//			System.out.println("dto.getBucketId() = " + dto.getBucketId());
//			System.out.println("dto.getBucketImagePath() = " + dto.getBucketImagePath());
//			System.out.println("dto.getBucketLikeCnt() = " + dto.getBucketLike());
//		}
		
//		ArrayList<BucketDto> div1 = new ArrayList<BucketDto>();
//		ArrayList<BucketDto> div2 = new ArrayList<BucketDto>();
//		ArrayList<BucketDto> div3 = new ArrayList<BucketDto>();
//		ArrayList<BucketDto> div4 = new ArrayList<BucketDto>();
//		ArrayList<BucketDto> div5 = new ArrayList<BucketDto>();
//		int cnt = 1;
//		for(int i = 0 ; i<bucketList.size(); i++) {
//			if(cnt==1) {
//				cnt += 1;
//				div1.add(bucketList.get(i));
//			}else if(cnt==2) {
//				cnt += 1;
//				div2.add(bucketList.get(i));
//			}else if(cnt==3) {
//				cnt += 1;
//				div3.add(bucketList.get(i));
//			}else if(cnt==4){
//				cnt += 1;
//				div4.add(bucketList.get(i));
//			}else {
//				div5.add(bucketList.get(i));
//				cnt = 1;
//				
//			}
//		}
		
		
		
		session.setAttribute("ownerId", userId);
		request.setAttribute("bucketList", bucketList);
		request.setAttribute("userImagePath", userImagePath);
//		request.setAttribute("div1", div1);
//		request.setAttribute("div2", div2);
//		request.setAttribute("div3", div3);
//		request.setAttribute("div4", div4);
		//String viewPage = "jsp/mybucket/MyBucket.jsp";
		String viewPage = "jsp/mybucket/MyBucket2.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
