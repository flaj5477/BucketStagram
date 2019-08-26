package co.bucketstargram.command.popular;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.PopularDao;

import co.bucketstargram.dto.BucketDto;

public class PopMain implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PopularDao popDao = new PopularDao();
//		ReplyDao replyDao = new ReplyDao();
		
//		HttpSession session = request.getSession(true);
//		String userid = (String)session.getAttribute("userid");
		
		ArrayList<BucketDto> list = new ArrayList<BucketDto>();
		list = popDao.select();
		request.setAttribute("isList", list.isEmpty());
		request.setAttribute("list", list);
		String viewPage = "jsp/popular/test.jsp";
		HttpRes.forward(request, response, viewPage);
	}

}
