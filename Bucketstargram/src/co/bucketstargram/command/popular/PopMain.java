package co.bucketstargram.command.popular;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.common.Trace;
import co.bucketstargram.dao.PopularDao;

import co.bucketstargram.dto.BucketDto;

public class PopMain implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
//		ReplyDao replyDao = new ReplyDao();	
//		HttpSession session = request.getSession(true);
//		String userid = (String)session.getAttribute("userid");
		
		String popType = request.getParameter("type");
		String sPage = request.getParameter("page");
		int page = 1;	//기본페이지는 1페이지
		
		if(sPage != null)
			page = Integer.parseInt(sPage);
		
		PopularDao popDao = new PopularDao();
		
		ArrayList<BucketDto> list = popDao.getPopList(popType, page);
	//	list = popDao.select();
		request.setAttribute("list", list);
		 String viewPage = "jsp/popular/popularForm.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
