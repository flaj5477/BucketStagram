package co.bucketstargram.command.library;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
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
		
		
		//dao실행
		result = dao.update(library);
	
		
	}

}
