package co.bucketstargram.command.myBucket;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.common.Primary;
import co.bucketstargram.dao.BucketDao;
import co.bucketstargram.dto.BucketDto;

public class BucketPostAction implements Command {
	private File directory = null;
	private File[] deleteFolderList = null;
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean insertSuccess = false;
		
		BucketDto bucket = new BucketDto();
		HttpSession session = request.getSession(true);
		//C:\Users\이재문\Desktop\자바\jsp\Bucketstargram\WebContent\images
		String serverPath = request.getServletContext().getRealPath("images");
		
		String bucketId = Primary.create();
		String bucketMemberId = (String)session.getAttribute("userid");;
		String bucketTitle = null; // multi Form으로 받았기 때문에 request가 아니라 multi 인스턴스로 받아야됨
		String bucketContents = null;
		// 나중에 selection form 추가 되면 수정해야될 부분
		String bucketType = null;
		String bucketImagePath = null;
		
		// 파일 크기 15MB로 제한
		int sizeLimit = 1024 * 1024 * 15;
		String savePath = serverPath + "\\" + bucketMemberId + "\\" + bucketId;
		//System.out.println("savePath = " + savePath);
		/*
		 * String bucketImagePath 저장될 서버 경로
		 * int maxPostSize 파일 최대 크기
		 * String encoding 인코딩 방식 
		 * FileRenamePolicy policy 같은 이름의 파일명 방지 처리
		 */
		// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
		makeDrectory(savePath);
		//파일 업로드 완료
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		System.out.println("Image File 생성");
//		//업로드된 파일의 이름을 반환한다
		Enumeration files = multi.getFileNames();
		while( files.hasMoreElements() ) {
			

			String file = (String)files.nextElement();
			String upFileName = multi.getFilesystemName(file);
	//		System.out.println("upFileName = " + upFileName);
			
			bucketTitle = multi.getParameter("bucketTitle");
			bucketContents = multi.getParameter("bucketContent");
			bucketType = multi.getParameter("bucketType");
			bucketImagePath = "images" + "\\" + bucketMemberId + "\\" + bucketId + "\\" + upFileName;
			System.out.println("bucketImagePath = " + bucketImagePath);
			System.out.println("bucketType = " + bucketType);
			
			bucket.setBucketId(bucketId);
			bucket.setBucketMemberId(bucketMemberId);
			bucket.setBucketTitle(bucketTitle);
			bucket.setBucketContents(bucketContents);
			bucket.setBucketType(bucketType);
			bucket.setBucketImagePath(bucketImagePath);
			
			
			BucketDao dao = new BucketDao();
			insertSuccess = dao.insert(bucket);
			
			//DB에러 났을 경우 생성된 파일을 자동 삭제 해주는 로직
			if(insertSuccess) {
				System.out.println("BucketPost.java |  DB저장 성공");
				String viewPage = "MyBucket.do";
				HttpRes.forward(request, response, viewPage);
			}else {
				System.out.println("BucketPost.java |  DB저장 실패");
				deleteFolderList = directory.listFiles();
				
				boolean dirDelFlag = true;
				while(true) {
					if(dirDelFlag) {
						for (int i = 0; i < deleteFolderList.length; i++  ) {
							dirDelFlag = deleteFolderList[i].delete();
							System.out.println("Image File 삭제");
						}
					}else {
						directory.delete();
						System.out.println("BuckId Folder 삭제");
						break;
					}
				}
				
				String viewPage = "BucketPostForm.do";
				HttpRes.forward(request, response, viewPage);
			}
		}
	}
	
	private void makeDrectory(String bucketImagePath) {
		// TODO Auto-generated method stub
		directory = new File(bucketImagePath);
		deleteFolderList = directory.listFiles();
		if (directory.mkdirs()) {
			System.out.println("Bucket Id Folder 생성");
		} else {
			System.out.println("Bucket Id Folder 생성 실패");
		}
	}
}
