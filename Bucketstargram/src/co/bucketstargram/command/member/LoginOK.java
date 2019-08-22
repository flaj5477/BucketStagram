package co.bucketstargram.command.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.LoginDao;

public class LoginOK implements Command {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		boolean loginSuccess = false;
		LoginDao dao = new LoginDao();

		String formID = request.getParameter("formID");
		String formPW = request.getParameter("formPW");

		loginSuccess = dao.select(formID, formPW);
		if(loginSuccess) {
			session.setAttribute("userid", formID);
			session.setAttribute("userpw", formPW);	
		}
		
		String viewPage = "jsp/LoginOK.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
