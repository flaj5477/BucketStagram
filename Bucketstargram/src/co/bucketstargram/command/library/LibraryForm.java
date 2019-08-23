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
		LibraryDao dao = new LibraryDao();
		ArrayList<LibraryDto> libraryList = dao.getLibraryList();
		
		request.setAttribute("libraryList", libraryList);
		//System.out.println("첫번째 라이브러리의 아이디: " + libraryList.get(0).getLibId());
		//System.out.println("첫번째 라이브러리의 이미지경로: " + libraryList.get(0).getLibImagePath());
		
		String viewPage = "jsp/library/libraryForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
