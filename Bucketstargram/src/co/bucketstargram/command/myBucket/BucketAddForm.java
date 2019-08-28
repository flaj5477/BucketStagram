package co.bucketstargram.command.myBucket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.BucketDao;
import co.bucketstargram.dto.BucketDto;

public class BucketAddForm implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- BucketAddForm.java ---");
		BucketDao bucket = new BucketDao();
		
		String bucketId = request.getParameter("bucketId");
		String bucketTitle = request.getParameter("bucketTitle");
		String bucketContent = request.getParameter("bucketContent");
		String bucketMemberId = request.getParameter("bucketMemberId");
		
		System.out.println("bucketId = " + bucketId);
		System.out.println("bucketTitle = " + bucketTitle);
		System.out.println("bucketContent = " + bucketContent);
		System.out.println("bucketMemberId = " + bucketMemberId);
		
		String imagePath = bucket.getImagePathbucketId(bucketId);
		request.setAttribute("imagePath", imagePath);
		request.setAttribute("bucketTitle", bucketTitle);
		request.setAttribute("bucketContent", bucketContent);
		request.setAttribute("bucketMemberId", bucketMemberId);
		
		String viewPage = "jsp/mybucket/BucketAddForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
