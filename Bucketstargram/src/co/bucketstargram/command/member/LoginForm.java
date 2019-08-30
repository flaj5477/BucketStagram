package co.bucketstargram.command.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;

public class LoginForm implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("\n--- LoginForm.java ---");
		String ownerId = request.getParameter("ownerId");
		String bucketId = request.getParameter("bucketId");
		
		request.setAttribute("ownerId", ownerId);
		request.setAttribute("bucketId", bucketId);
		String viewPage = "jsp/logon/LoginForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
