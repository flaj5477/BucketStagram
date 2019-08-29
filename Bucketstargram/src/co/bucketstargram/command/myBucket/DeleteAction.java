package co.bucketstargram.command.myBucket;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.BucketDao;

public class DeleteAction implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n-- DeleteAction.java ---");
		HttpSession session = request.getSession(true);
		BucketDao dao = new BucketDao();
		String userId = (String)session.getAttribute("userid");
		String bucketId = request.getParameter("bucketId");
		System.out.println("bucketId = " + bucketId);
		System.out.println("userId = " + userId);
		
		String deleteResult = dao.delete(bucketId); 
		System.out.println("deleteResult = " + deleteResult);
		
		if(deleteResult == "deleteSuccess") {
			System.out.println("DB삭제 성공");
			String serverPath = request.getServletContext().getRealPath("images");
			String deleteImagePath = serverPath + "\\" + userId + "\\" + bucketId;
			System.out.println("deleteImagePath = " + deleteImagePath);
			File directory = new File(deleteImagePath);
			File[] deleteFolderList = directory.listFiles();
			
			boolean dirDelFlag = true;
			while(true) {
				if(dirDelFlag) {
					for (int i = 0; i < deleteFolderList.length; i++  ) {
						dirDelFlag = deleteFolderList[i].delete();
						System.out.println(i + "번째 = " + dirDelFlag);
						System.out.println("Image File 삭제");
					}
				}else {
					directory.delete();
					System.out.println("BuckId Folder 삭제");
					break;
				}
			}
			String viewPage = "MyBucket.do";
			HttpRes.forward(request, response, viewPage);			
		}else {
			//실패 했을때는?? 어디로 가야되나??
		}
	}

}
