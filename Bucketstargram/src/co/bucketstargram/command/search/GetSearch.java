package co.bucketstargram.command.search;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.common.Command;
import co.bucketstargram.common.HttpRes;
import co.bucketstargram.dao.SearchDao;
import co.bucketstargram.dto.BucketDto;
import co.bucketstargram.dto.LibraryDto;

public class GetSearch implements Command {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SearchDao dao = new SearchDao();
		ArrayList<BucketDto> bucketResult = new ArrayList<BucketDto>();
		ArrayList<LibraryDto> libResult = new ArrayList<LibraryDto>();
		String word = request.getParameter("word");
		System.out.println(word+" (을)를 검색합니다.");
		libResult = dao.librarySearch(word);
		bucketResult = dao.bucketSearch(word);
		dao.close();
		request.setAttribute("word",word);
		request.setAttribute("getLibrarySearch",libResult);
		request.setAttribute("getBucketSearch",bucketResult);
		String viewPage = "jsp/search/GetSearch.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
