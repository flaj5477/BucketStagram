package co.bucketstargram.command.myBucket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;

public class BucketAddForm implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- BucketAddForm.java ---");
		
		String imagePath = request.getParameter("imagePath");
		String bucketTitle = request.getParameter("bucketTitle");
		String bucketContent = request.getParameter("bucketContent");
		String bucketMemberId = request.getParameter("bucketMemberId");
		
//		System.out.println("imagePath = " + imagePath);
//		System.out.println("bucketTitle = " + bucketTitle);
//		System.out.println("bucketContent = " + bucketContent);
//		System.out.println("bucketMemberId = " + bucketMemberId);
		
		request.setAttribute("imagePath", imagePath);
		request.setAttribute("bucketTitle", bucketTitle);
		request.setAttribute("bucketContent", bucketContent);
		request.setAttribute("bucketMemberId", bucketMemberId);
		
		String viewPage = "jsp/mybucket/BucketAddForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
