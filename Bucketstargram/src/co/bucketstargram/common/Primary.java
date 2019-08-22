package co.bucketstargram.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class Primary {
	public static String create() {
		Date now = new Date();
		String primaryKey = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.ENGLISH).format(now);
		
		return primaryKey;
	}
}
