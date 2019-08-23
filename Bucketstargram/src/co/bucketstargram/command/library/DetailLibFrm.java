package co.bucketstargram.command.library;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.common.Trace;

public class DetailLibFrm implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Trace.init();
		
		String libId = request.getParameter("libId");
		System.out.println("라이브러리 아이디는?" + libId);
		request.setAttribute("libId", libId);
		
		String viewPage = "jsp/library/detail_libraryForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
