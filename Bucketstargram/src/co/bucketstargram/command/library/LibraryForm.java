package co.bucketstargram.command.library;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.common.Trace;
import co.bucketstargram.dao.LibraryDao;
import co.bucketstargram.dto.LibraryDto;

public class LibraryForm implements Command {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Trace.init(); //위치 출력!
		String libType = request.getParameter("type");
		
		LibraryDao dao = new LibraryDao();
		
		ArrayList<LibraryDto> libraryList = dao.getLibPhotoList(libType);
		
		request.setAttribute("libraryList", libraryList);
		
		String viewPage = "jsp/library/libraryForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
