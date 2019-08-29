package co.bucketstargram.command.member;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.LoginDao;
import co.bucketstargram.dto.MemberDto;
 

public class MemberInsert implements Command {

	
	  private File directory = null; 
	  private File[] deleteFolderList = null;
	 
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		LoginDao dao = new LoginDao();
		MemberDto dto = new MemberDto();
		 
		 String serverPath = request.getServletContext().getRealPath("images"); 
		 String mImagePath =null;
		
	//  ↓ request 객체,               ↓ 저장될 서버 경로,       ↓ 파일 최대 크기,    ↓ 인코딩 방식,       ↓ 같은 이름의 파일명 방지 처리
		// (HttpServletRequest request, String saveDirectory, int maxPostSize, String encoding, FileRenamePolicy policy)
		// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
		
		 int sizeLimit = 1024*1024*15;
		 
		 
		 String savePath = serverPath + "\\profile"; 
		 makeDrectory(savePath); 
		 MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,
				  "utf-8", new DefaultFileRenamePolicy());
//		 String id = multi.getParameter("id");
		Enumeration files = multi.getFileNames();
		
		while(files.hasMoreElements() ) {
		 String file = (String)files.nextElement();
		 String upFileName = multi.getFilesystemName(file);
	//	 mImagePath = "images" + "\\profile"  + "\\" +id+ "\\" + upFileName;
		
		 
		 if(upFileName != null) {
		 mImagePath = "images" + "\\profile" +"\\"  + upFileName;
		 System.out.println("ImagePath = " + mImagePath);
			/*
			 * String savePath2 = serverPath + "\\profile" + "\\" + id;
			 * makeDrectory(savePath2);
			 */
	
	 
			
		 
		dto.setmId(multi.getParameter("id"));
		dto.setmPw(multi.getParameter("password"));
		dto.setmName(multi.getParameter("name"));
		dto.setmEmail(multi.getParameter("email"));
		dto.setmPhone(multi.getParameter("phone"));
	//	dto.setmImagePath(request.getParameter("imagePath"));
		dto.setmImagePath(mImagePath);
		int n = dao.insert(dto);
		request.setAttribute("n", n);
		String viewPage="jsp/signup/memberinsertok.jsp";
		HttpRes.forward(request, response, viewPage);
		 }else {
			 mImagePath = "images" + "\\profile" +"\\"  + "temp.jpg";
			 System.out.println("ImagePath = " + mImagePath);
			 
		 
				
			 
			dto.setmId(multi.getParameter("id"));
			dto.setmPw(multi.getParameter("password"));
			dto.setmName(multi.getParameter("name"));
			dto.setmEmail(multi.getParameter("email"));
			dto.setmPhone(multi.getParameter("phone"));
		//	dto.setmImagePath(request.getParameter("imagePath"));
			dto.setmImagePath(mImagePath);
			int n = dao.insert(dto);
			request.setAttribute("n", n);
			String viewPage="jsp/signup/memberinsertok.jsp";
			HttpRes.forward(request, response, viewPage);
		 }
	}
	
	}
	
 
	 
	private void makeDrectory(String mImagePath) {
		// TODO Auto-generated method stub
		directory = new File(mImagePath);
		deleteFolderList = directory.listFiles();
		if (directory.mkdirs()) {
			System.out.println("Bucket Id Folder 생성");
		} else {
			System.out.println("Bucket Id Folder 생성 실패");
		}
}
	
}


