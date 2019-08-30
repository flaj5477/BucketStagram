package co.bucketstargram.command.library;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.LibraryDao;
import co.bucketstargram.dto.LibraryDto;

public class LibraryUpdate implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//수정 페이지에서 가져온 정보 request.getParameter하고
		//dao.update하고
		LibraryDao dao = new LibraryDao();
		LibraryDto library = new LibraryDto();
		boolean result = false;
		
		//library.set~해서 정보 담고
		library.setLibId(request.getParameter("libraryId"));
		library.setLibTitle(request.getParameter("libraryTitle"));
		library.setLibContents(request.getParameter("libraryContent"));
		library.setLibImagePath(request.getParameter("imagePath"));
		library.setLibType(request.getParameter("libraryType"));
		
		System.out.println(library.getLibId());
		System.out.println(library.getLibTitle());
		System.out.println(library.getLibContents());
		System.out.println(library.getLibImagePath());
		//dao실행
		result = dao.update(library);
	
		String viewPage = "LibraryForm.do"; //수정할 정보 가지로 수정 페이지로 간다.	
		HttpRes.forward(request, response, viewPage);
	}

}
