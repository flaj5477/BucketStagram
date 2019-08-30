package co.bucketstargram.command.library;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.BucketDao;

public class LibraryAddForm implements Command{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- LibraryAddForm.java ---");
		BucketDao bucket = new BucketDao();
		
		//String bucketId = request.getParameter("bucketId");
		String imagePath = request.getParameter("imagePath");
		String bucketTitle = request.getParameter("Title");
		String bucketContent = request.getParameter("Title");
		String bucketMemberId = request.getParameter("MemberId");
		String bucketType = request.getParameter("Type");
		
		//System.out.println("bucket아이디 = " + bucketId);
		System.out.println("bucket이미지 경로 = " + imagePath);
		System.out.println("bucket제목 = " + bucketTitle);
		System.out.println("bucket내용 = " + bucketContent);
		System.out.println("bucket작성자(로그인한 사람)아이디 = " + bucketMemberId);
		System.out.println("bucket타입 = " + bucketType);
		
		//String imagePath1 = bucket.getImagePathbucketId(bucketId);
		
		request.setAttribute("imagePath", imagePath);
		request.setAttribute("bucketTitle", bucketTitle);
		request.setAttribute("bucketContent", bucketContent);
		request.setAttribute("bucketMemberId", bucketMemberId);
		request.setAttribute("bucketType", bucketType);
		
		String viewPage = "jsp/library/libraryAddForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
