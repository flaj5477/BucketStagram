package co.bucketstargram.command.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;


public class SignUp implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage="jsp/signup/memberInsert.jsp";  
//		String viewPage="jsp/signup/dasd.jsp";  
		HttpRes.forward(request, response, viewPage);

	}

}
