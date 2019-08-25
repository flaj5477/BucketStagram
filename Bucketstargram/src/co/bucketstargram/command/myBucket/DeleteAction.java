package co.bucketstargram.command.myBucket;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.BucketDao;

public class DeleteAction implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("DeleteAction.java");
		BucketDao dao = new BucketDao();
		String bucketId = request.getParameter("bucketId");
		
		String deleteResult = dao.delete(bucketId); 
		System.out.println("deleteResult = " + deleteResult);
		
		if(deleteResult == "deleteSuccess") {
			System.out.println("\"" + bucketId + "\" 삭제 성공");
			String viewPage = "MyBucket.do";
			HttpRes.forward(request, response, viewPage);			
		}else {
			//실패 했을때는?? 어디로 가야되나??
		}
	}

}
