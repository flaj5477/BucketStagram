package co.bucketstargram.command.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.LoginDao;

public class IdCheck implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginDao dao = new  LoginDao();
		boolean chk = dao.memberIdCheck(request.getParameter("id"));
		request.setAttribute("chk", chk);
		String viewPage = "jsp/signup/idcheck.jsp";
		HttpRes.forward(request, response, viewPage);

	}

}
