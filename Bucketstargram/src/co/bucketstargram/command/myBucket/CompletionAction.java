package co.bucketstargram.command.myBucket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.dao.BucketDao;

public class CompletionAction implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("--- CompletionAction.java ---");
		BucketDao dao = new BucketDao();
		
		String completionYN = request.getParameter("completionYN");
		String bucketId = request.getParameter("imageId");
		System.out.println("completionYN = " + completionYN);
		System.out.println("imageId = " + bucketId);
		
		//completion, challenging, deleteFail
		completionYN = dao.completionUpdate(bucketId, completionYN);
		System.out.println("DB작업 후 completionYN = " + completionYN);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().write(String.valueOf(completionYN));
	
	}
}
