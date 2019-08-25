package co.bucketstargram.command.myBucket;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.common.Primary;
import co.bucketstargram.dao.BucketDao;
import co.bucketstargram.dto.BucketDto;

public class BucketAddAction implements Command {
	private File directory = null;
	private File[] deleteFolderList = null;

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- BucketAddAction.java ---");
		
		BucketDto bucket = new BucketDto();
		HttpSession session = request.getSession(true);
		//C:\Users\이재문\Desktop\자바\jsp\Bucketstargram\WebContent\images
		String serverPath = request.getServletContext().getRealPath("images");
		
		String oldImagePath = request.getParameter("imagePath");
		oldImagePath = oldImagePath.replace("\\", "\\\\");
		System.out.println("oldImagePath = " + oldImagePath);
		String oriOwnerId = request.getParameter("ownerId");
		
		//"이전사용자ID_copy_복사파일명"로 새로운 이미지 파일명 생성
		String oldImagePathArry[] = oldImagePath.split("\\\\");
		String oldImageName = oldImagePathArry[oldImagePathArry.length-1];
		String newImageName = oriOwnerId + "_copy_" + oldImageName ;
		
		String bucketId = Primary.create();
		String bucketMemberId = (String)session.getAttribute("userid");
		String bucketTitle = request.getParameter("bucketTitle");
		String bucketContents = request.getParameter("bucketContent");
		// 나중에 selection form 추가 되면 수정해야될 부분
		String bucketType = "여행";
		String bucketImagePath = null;
		
		//새로운 이미지가 들어갈 디렉토리 파일생성
		//C:\Users\이재문\Desktop\자바\jsp\Bucketstargram\WebContent\images\버킷ID\사용자아이디\
		String newImageDrectoy = serverPath + "\\" + bucketMemberId + "\\" + bucketId;
		makeDrectory(newImageDrectoy);
		//DB에 저장될 디렉토리 저장 변수
		//C:\Users\이재문\Desktop\자바\jsp\Bucketstargram\WebContent\images\버킷ID\사용자아이디\이미지파일이름
		bucketImagePath = newImageDrectoy + "\\" + newImageName;
		System.out.println("bucketImagePath = " + bucketImagePath);
		
		boolean imageCopySuccess = false;
		try {			
			// oldImagePath 경로에서 이전 사용자의 이미지를 복사
			System.out.println("request.getServletContext().getRealPath(\"\")+oldImagePath = " + request.getServletContext().getRealPath("")+oldImagePath);
			FileInputStream fin = new FileInputStream(request.getServletContext().getRealPath("")+oldImagePath);
			// bbb.txt 파일로 복사합니다.
			System.out.println("bucketImagePath = " + bucketImagePath);
			FileOutputStream fout = new FileOutputStream(bucketImagePath);
			
            int tmp = 0;
            while ((tmp = fin.read()) != -1) {
            	//복사 시작
                fout.write(tmp);
                imageCopySuccess = true;
            }
            
            fin.close();
            fout.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		bucket.setBucketId(bucketId);
		bucket.setBucketMemberId(bucketMemberId);
		bucket.setBucketTitle(bucketTitle);
		bucket.setBucketContents(bucketContents);
		bucket.setBucketType(bucketType);
		bucketImagePath = "images" + "\\" + bucketMemberId +  "\\" + bucketId + "\\" + newImageName;
		bucket.setBucketImagePath(bucketImagePath);
		
		BucketDao dao = new BucketDao();
		boolean insertSuccess = false;
		insertSuccess = dao.insert(bucket);
		
		//DB에러 났을 경우 생성된 파일을 자동 삭제 해주는 로직
		if(insertSuccess == true && imageCopySuccess == true) {
			System.out.println("insertSuccess = " + insertSuccess + " | imageCopySuccess = " + imageCopySuccess);
			
			String viewPage = "MyBucket.do";
			HttpRes.forward(request, response, viewPage);
		}else {
			System.out.println("insertSuccess = " + insertSuccess + " | imageCopySuccess = " + imageCopySuccess);
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
			
			String viewPage = "MyBucket.do";
			HttpRes.forward(request, response, viewPage);
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
