package co.bucketstargram.command.library;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.common.Trace;
import co.bucketstargram.dao.LibraryDao;
import co.bucketstargram.dto.LibraryDto;

public class DetailLibFrm implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Trace.init();
		LibraryDao dao = new LibraryDao();
		
		String libId = request.getParameter("libId");
		System.out.println("라이브러리 아이디는?" + libId);
		
		//dao로 라이브러리 아이디로 세부라이브러리 정보(사진, 제목, 내용, 좋아요 갯수 가져오기)
		LibraryDto library = dao.getdetailLib(libId);
		
		request.setAttribute("library", library);
		
		
		String viewPage = "jsp/library/detail_libraryForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
