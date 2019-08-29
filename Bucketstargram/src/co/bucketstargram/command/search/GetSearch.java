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
	SearchDao dao = new SearchDao();
	ArrayList<BucketDto> bucketResult = new ArrayList<BucketDto>();
	ArrayList<LibraryDto> libResult = new ArrayList<LibraryDto>();
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SearchDao dao = new SearchDao();
		ArrayList<BucketDto> bucketResult = new ArrayList<BucketDto>();
		ArrayList<LibraryDto> libResult = new ArrayList<LibraryDto>();
		String word = request.getParameter("word");
		int libCount = 0;
		int bucketCount = 0;
		boolean exist = true;
		System.out.println(word+"(을)를 검색합니다.");
		libResult = dao.librarySearch(word);
		bucketResult = dao.bucketSearch(word);
		libCount = dao.libCount(word);
		bucketCount = dao.bucketCount(word);	
		// 슬라이더 공백이미지 처리
		if(libCount%5!=0) { 
			int remainder = 5-libCount%5;
			for(int i=0;i<remainder;i++) {	
				libResult.add(new LibraryDto());
			}
		}//s
		if(bucketCount%5!=0) { 
			int remainder = 5-bucketCount%5;
			for(int i=0;i<remainder;i++) {	
				bucketResult.add(new BucketDto());
			}
		}
		dao.close();
		// library 검색 유틸리티
		if(libCount != 0) {
			request.setAttribute("libCount",libCount);
		}
		else {
			exist=false;
			String noSearch = "검색 결과가 없네요!";
			request.setAttribute("libCount",noSearch);
			request.setAttribute("exist_Lib",exist);
		}
		// Bucket 검색 유틸리티
		if(bucketCount != 0) {
			request.setAttribute("bucketCount",bucketCount);
		}
		else {
			exist=false;
			String noSearch = "검색 결과가 없네요!";
			request.setAttribute("bucketCount",noSearch);
			request.setAttribute("exist_Bucket",exist);
		}
		request.setAttribute("word",word);
		request.setAttribute("getLibrarySearch",libResult);
		request.setAttribute("getBucketSearch",bucketResult);
		String viewPage = "jsp/search/GetSearch.jsp";
		HttpRes.forward(request, response, viewPage);
	}
}
