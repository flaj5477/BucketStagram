package co.bucketstargram.command.library;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.common.Primary;
import co.bucketstargram.dao.LibraryDao;
import co.bucketstargram.dto.LibraryDto;

public class LibInsert implements Command {
	private File directory = null;
	private File[] deleteFolderList = null;

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("\n=============library입력.java==============");

		LibraryDto library = new LibraryDto();
		LibraryDao dao = new LibraryDao();
		boolean success = false;
		HttpSession session = request.getSession(true);
		String serverPath = request.getServletContext().getRealPath("images");
		System.out.println(serverPath);

		// 라이브러리 아이디 생성
		String libraryId = Primary.create();
		String libraryTitle = null;
		String libraryContent = null;
		String libraryType = null;
		String libraryImagePath = null;

		// 파일 사이즈 제한
		int sizeLimit = 1024 * 1024 * 15;
		String savePath = serverPath + "\\library\\" + libraryId ;
		System.out.println("이미지 저장경로: " + savePath);

		// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
		makeDrectory(savePath); 
		
		// 파일 업로드 완료
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8",
				new DefaultFileRenamePolicy());
		System.out.println("Image File 생성");
//				//업로드된 파일의 이름을 반환한다
		Enumeration files = multi.getFileNames();
		// while( files.hasMoreElements() ) {

		String file = (String) files.nextElement();
		String upFileName = multi.getFilesystemName(file);
		System.out.println("upFileName = " + upFileName);

		libraryTitle = multi.getParameter("libraryTitle");
		libraryContent = multi.getParameter("libraryContent");
		libraryType = multi.getParameter("libraryType");
		libraryImagePath = "images" + "\\library\\" + libraryId  + "\\" + upFileName;
		System.out.println("libraryTitle = " + libraryTitle);
		System.out.println("libraryContent = " + libraryContent);
		System.out.println("libraryImagePath = " + libraryImagePath);
		System.out.println("libraryType = " + libraryType);

		library.setLibId(libraryId);
		library.setLibTitle(libraryTitle);
		library.setLibContents(libraryContent);
		library.setLibType(libraryType);
		library.setLibImagePath(libraryImagePath);

		success = dao.libInsert(library);
		System.out.println("dao결과 : " + success);
		
		//DB에러 났을 경우 생성된 파일을 자동 삭제 해주는 로직
		if(success) {	//성공하면
			System.out.println("BucketPost.java |  DB저장 성공");
			
			//이동할 페이지
			String viewPage = "LibraryForm.do";
			HttpRes.forward(request, response, viewPage);
		}else {		//실패하면
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
			
			String viewPage = "LibInsertForm.do";
			HttpRes.forward(request, response, viewPage);
		}

	}

	private void makeDrectory(String libraryImagePath) {
		// TODO Auto-generated method stub
		directory = new File(libraryImagePath);
		deleteFolderList = directory.listFiles();
		if (directory.mkdirs()) {
			System.out.println("Bucket Id Folder 생성");
		} else {
			System.out.println("Bucket Id Folder 생성 실패");
		}
	}

}
