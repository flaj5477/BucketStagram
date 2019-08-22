package co.bucketstargram.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Trace {    
    public static void init() {
    	Calendar calendar = Calendar.getInstance();
    	StackTraceElement[] trace = new Throwable().getStackTrace();
    	Date date = calendar.getTime();
    	
//    	for(int i = 0 ; i < trace.length ; i ++) {
//    		System.out.println("trace[" + i + "] = " + trace[i]);
//    	}
    	
    	String currentTime = (new SimpleDateFormat("yyyy-MM-dd a HH:mm:ss.SSS").format(date));
    	String callClassName = trace[1].getFileName();
    	if(callClassName.contains("_jsp")) {
    		String str[] = callClassName.split("_");
    		callClassName = str[0] + ".jsp";
    	}
    	System.out.println(currentTime + " | " + callClassName);
    }
}
