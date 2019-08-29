package co.bucketstargram.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.bucketstargram.command.index.Index;
import co.bucketstargram.command.library.LibraryAdd;
import co.bucketstargram.command.library.LibraryAddForm;
import co.bucketstargram.command.library.DetailLibFrm;
import co.bucketstargram.command.library.LibraryForm;
import co.bucketstargram.command.member.IdCheck;
import co.bucketstargram.command.member.LogOut;
import co.bucketstargram.command.member.LoginForm;
import co.bucketstargram.command.member.LoginOK;
import co.bucketstargram.command.member.MemberInsert;
import co.bucketstargram.command.member.SignUp;
import co.bucketstargram.command.myBucket.AppendReplyAction;
import co.bucketstargram.command.myBucket.BucketAddAction;
import co.bucketstargram.command.myBucket.BucketAddForm;
import co.bucketstargram.command.myBucket.BucketPostAction;
import co.bucketstargram.command.myBucket.BucketPostForm;
import co.bucketstargram.command.myBucket.CompletionAction;
import co.bucketstargram.command.myBucket.DeleteAction;
import co.bucketstargram.command.myBucket.DetailMyBucket;
import co.bucketstargram.command.myBucket.MyBucketListAction;
import co.bucketstargram.command.myBucket.WishListAction;
import co.bucketstargram.command.myBucket.LikeAction;
import co.bucketstargram.command.myBucket.MyBucket;
import co.bucketstargram.command.myBucket.OtherBucket;
import co.bucketstargram.command.popular.Culture;
import co.bucketstargram.command.popular.Food;
import co.bucketstargram.command.popular.LifeStyle;
import co.bucketstargram.command.popular.NewSkill;
import co.bucketstargram.command.popular.Outdoor;
import co.bucketstargram.command.popular.PopMain;
import co.bucketstargram.command.popular.Shopping;
import co.bucketstargram.command.popular.Sport;
import co.bucketstargram.command.popular.Travel;
import co.bucketstargram.command.search.GetSearch;
import co.bucketstargram.common.Command;
import co.bucketstargram.common.Trace;

@WebServlet(name = "Controllerd", urlPatterns = { "/Controllerd" })
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HashMap<String, Command> map = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init(ServletConfig config) throws ServletException {
        map = new HashMap<String, Command>();
        map.put("/Index.do", new Index());
        map.put("/LoginForm.do", new LoginForm());
        map.put("/LoginOK.do", new LoginOK());
        map.put("/LogOut.do", new LogOut());
        map.put("/SignUp.do", new SignUp());
        map.put("/MemberInsert.do", new MemberInsert());
        map.put("/IdCheck.do", new IdCheck());
       
        //재문
        map.put("/MyBucket.do", new MyBucket());
        map.put("/DetailMyBucket.do", new DetailMyBucket());
        map.put("/BucketPostForm.do", new BucketPostForm());
        map.put("/BucketPostAction.do", new BucketPostAction());
        map.put("/MyBucketListAction.do", new MyBucketListAction());
        map.put("/AppendReplyAction.do", new AppendReplyAction());
        map.put("/LikeAction.do", new LikeAction());
        map.put("/WishListAction.do", new WishListAction());
        map.put("/DeleteAction.do", new DeleteAction());
        map.put("/CompletionAction.do", new CompletionAction());
        map.put("/OtherBucket.do", new OtherBucket());
        map.put("/BucketAddForm.do", new BucketAddForm());
        map.put("/BucketAddAction.do", new BucketAddAction());
        
        //화정
        map.put("/LibraryForm.do", new LibraryForm());
        map.put("/DetailLibFrm.do", new DetailLibFrm());
        map.put("/LibraryAddForm.do", new LibraryAddForm());

        //동규
        map.put("/GetSearch.do", new GetSearch());
        

        //지민
        map.put("/PopMain.do", new PopMain());
        map.put("/Travel.do", new Travel());
        map.put("/Sport.do", new Sport());
        map.put("/Food.do", new Food());
        map.put("/NewSkill.do", new NewSkill());
        map.put("/Culture.do", new Culture());
        map.put("/Outdoor.do", new Outdoor());
        map.put("/Shopping.do", new Shopping());
        map.put("/LifeStyle.do", new LifeStyle());
     }

     protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Trace.init();
  	  	request.setCharacterEncoding("UTF-8");
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length()); //최종path
        
//        System.out.println("contextPath = " + contextPath);
//        System.out.println("path = " + path);
//        System.out.println("map.size() = " + map.size());
//        System.out.println();
//        System.out.println(Integer.parseInt(request.getParameter("id")));
        Command command = map.get(path);   //map에서 path를 통해 인스턴스를 생성하고 
        command.execute(request, response);   //실행함
     }

}
