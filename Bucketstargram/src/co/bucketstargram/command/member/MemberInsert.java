package co.bucketstargram.command.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.LoginDao;
import co.bucketstargram.dto.MemberDto;
 

public class MemberInsert implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginDao dao = new LoginDao();
		MemberDto dto = new MemberDto();
		
		dto.setmId(request.getParameter("id"));
		dto.setmPw(request.getParameter("password"));
		dto.setmName(request.getParameter("name"));
		dto.setmEmail(request.getParameter("email"));
		dto.setmPhone(request.getParameter("phone"));
		dto.setmImagePath(request.getParameter("imagePath"));
		int n = dao.insert(dto);
		request.setAttribute("n", n);
		String viewPage="jsp/signup/memberinsertok.jsp";
		HttpRes.forward(request, response, viewPage);

	}

}
