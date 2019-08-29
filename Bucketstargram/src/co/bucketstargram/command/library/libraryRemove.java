package co.bucketstargram.command.library;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.LibraryDao;

public class libraryRemove implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("\n--- Library삭제... ---");
		
		LibraryDao dao = new LibraryDao();
		boolean result = false;
		
		String libId = request.getParameter("deletelibId");
		System.out.println("라이브러리 아이디: " + libId);
		
		result = dao.delete(libId);

		//삭제 성공 후 이미지 파일도 삭제 해야함
		if(result == true) {	//성공했을 때
			System.out.println("DB삭제 성공");
			String serverPath = request.getServletContext().getRealPath("images");
			String deleteImagePath = serverPath + "\\library\\" + libId;
			
			System.out.println("삭제 이미지 경로 = " + deleteImagePath);
			File directory = new File(deleteImagePath);
			
			File[] deleteFolderList = directory.listFiles();	//하위파일 리스트 받기
			for (int j = 0; j < deleteFolderList.length; j++) {	//하위파일 삭제
				System.out.println(deleteFolderList[j]);
				deleteFolderList[j].delete();
			}
			
			directory.delete();	//빈 폴더 삭제
			
			String viewPage = "LibraryForm.do";
			HttpRes.forward(request, response, viewPage);			
		}
		else {
			System.out.println("DB삭제 실패~~");
		}
		
	}

}
