package co.bucketstargram.command.library;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.BucketDao;

public class LibraryUpdateForm implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("\n--- LibraryAddForm.java ---");
		BucketDao bucket = new BucketDao();
		
		//String bucketId = request.getParameter("bucketId");
		String imagePath = request.getParameter("imagePath");
		String libraryId = request.getParameter("Id");
		String libraryTitle = request.getParameter("Title");
		String libraryContent = request.getParameter("Content");
		String libraryType = request.getParameter("Type");
		
		//System.out.println("bucket아이디 = " + bucketId);
		System.out.println("library이미지 경로 = " + imagePath);
		System.out.println("library아이디 = " + libraryId);
		System.out.println("library제목 = " + libraryTitle);
		System.out.println("library내용 = " + libraryContent);
		System.out.println("library타입 = " + libraryType);
		
		//String imagePath1 = bucket.getImagePathbucketId(bucketId);
		
		request.setAttribute("imagePath", imagePath);
		request.setAttribute("libraryId", libraryId);
		request.setAttribute("libraryTitle", libraryTitle);
		request.setAttribute("libraryContent", libraryContent);
		request.setAttribute("libraryType", libraryType);
		
		String viewPage = "jsp/library/libraryUpdateForm.jsp"; //수정할 정보 가지로 수정 페이지로 간다.	
		HttpRes.forward(request, response, viewPage);

	}

}
