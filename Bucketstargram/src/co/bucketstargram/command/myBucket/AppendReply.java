package co.bucketstargram.command.myBucket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.PrimaryKey;
import co.bucketstargram.dao.ReplyDao;

public class AppendReply implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		String memberId = (String) session.getAttribute("userid");
		String bucketId = (String)request.getParameter("imageId");
		String replyCotents = (String)request.getParameter("replyCotent");
		String replyId = PrimaryKey.create(); 
		System.out.println("AppendReply.java | imageId = " + bucketId);
		System.out.println("AppendReply.java | content = " + replyCotents); 
		System.out.println("AppendReply.java | usersId = " + memberId);
		System.out.println("AppendReply.java | replyId = " + replyId );
		
		boolean insertSuccess = false;
		
		response.setContentType("text/html;charset=UTF-8");
		ReplyDao dao = new ReplyDao();
		insertSuccess = dao.insert(replyId, bucketId, memberId, replyCotents);
		if(insertSuccess) {
			System.out.println("AppendReply.java | String.valueOf(insertSuccess) = " + String.valueOf(insertSuccess));
			response.getWriter().write(String.valueOf(insertSuccess));
		}
	}
}
