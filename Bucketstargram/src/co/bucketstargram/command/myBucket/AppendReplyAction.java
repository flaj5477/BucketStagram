package co.bucketstargram.command.myBucket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.Primary;
import co.bucketstargram.dao.LoginDao;
import co.bucketstargram.dao.ReplyDao;

public class AppendReplyAction implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- AppendReplyAction.java ---");
		String memberId = (String)request.getParameter("ownerId");
		String bucketId = (String)request.getParameter("bucketId");
		String replyCotents = (String)request.getParameter("replyCotent");
		String replyId = Primary.create(); 
		
		System.out.println("imageId = " + bucketId);
		System.out.println("content = " + replyCotents); 
		System.out.println("usersId = " + memberId);
		System.out.println("replyId = " + replyId );
		
		boolean insertSuccess = false;
		
		response.setContentType("text/html;charset=UTF-8");
		ReplyDao dao = new ReplyDao();
		insertSuccess = dao.insert(replyId, bucketId, memberId, replyCotents);
		System.out.println("insertSuccess = " + insertSuccess);
		LoginDao loginDao = new LoginDao();
		String userImagePath = loginDao.getUserImagePath(memberId);
		
		System.out.println("userImagePath = " + userImagePath);
		if(insertSuccess) {
			System.out.println("String.valueOf(insertSuccess) = " + String.valueOf(insertSuccess));
			response.getWriter().write(String.valueOf(insertSuccess+"/"));
			response.getWriter().write(userImagePath);
		}
	}
}
