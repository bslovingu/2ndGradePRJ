package poly.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class UrlEncodeUtil {

	public static String getEncode(String keyword) {

		String url = null;

		try {
			url = URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		return url;
	}

}
