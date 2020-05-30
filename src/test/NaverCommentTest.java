package test;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class NaverCommentTest {

	private final String USER_AGENT = "Mozilla/5.0";

	public static void main(String[] args) throws Exception {

		NaverCommentTest http = new NaverCommentTest();

		System.out.println("\nTesting 2 - Send Http POST request");
		http.sendPost();

	}

	private void sendPost() throws Exception {

		String url = "https://news.naver.com/main/read.nhn?m_view=1&includeAllCount=true&mode=LSD&mid=sec&sid1=102&oid=028&aid=0002498741";

		int tmpIndex = url.lastIndexOf("&");
		/* System.out.println(tmpIndex); // 현재는 값이 100 */
		
		String oid = url.substring(tmpIndex-3, tmpIndex);
		String aid = url.substring(tmpIndex+5);
		
		System.out.println(oid);
		System.out.println(aid);
		
		String page = "2"; // 페이지 수를 댓글 개수 넘긴거로 ( /20)+1 설정, 크롤링 반복 

		String r_url = "https://apis.naver.com/commentBox/cbox/web_naver_list_jsonp.json?ticket=news&templateId=default_society&pool=cbox5&_callback=jQuery1706087132582402561_1534112016030&lang=ko&country=&objectId=news"
				+ oid + "%2C" + aid
				+ "&categoryId=&pageSize=20&indexSize=10&groupId=&listType=OBJECT&pageType=more&page=" + page;

		/*
		 * Connection.Response response =
		 * Jsoup.connect(url).method(Connection.Method.GET).execute(); Document doc =
		 * response.parse();
		 */

		URL obj = new URL(r_url);

		HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

		// add request header
		con.setRequestMethod("POST");
		con.setRequestProperty("User-Agent", USER_AGENT);
		con.setRequestProperty("Content-Type", "application/json");
		con.setRequestProperty("referer", url);

		// Send post request
		con.setDoOutput(true);

		System.out.println("con : " + con);
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.flush();
		wr.close();

		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'POST' request to URL : " + url);
		System.out.println("Response Code : " + responseCode);

		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		// print result

		String tmpStr = response.toString();
		int openIndex = tmpStr.indexOf("(");
		int closeIndex = tmpStr.lastIndexOf(")");

		System.out.println("--------------");

		System.out.println(openIndex);
		System.out.println(closeIndex);

		String str = tmpStr.substring(openIndex + 1, closeIndex);

		System.out.println(str);

		/*
		 * JsonParser parser = new JsonParser(); Object tmpObj = parser.parse(str);
		 * JsonObject jsonObj = (JsonObject) tmpObj;
		 */

		/*
		 * JSONParser jParser = new JSONParser();
		 * 
		 * JSONArray jobj0 = (JSONArray) jParser.parse(str);
		 * 
		 * for (int i = 0; i < jobj0.size(); i++) { JSONObject tmp = (JSONObject)
		 * jobj0.get(i); String comment = String.valueOf(tmp.get("result"));
		 * 
		 * }
		 */

		JsonParser jsonParser = new JsonParser();
		JsonElement jsonElement = jsonParser.parse(str);

		/*
		 * String result1 = jsonElement.getAsJsonObject().get("result").toString();
		 * System.out.println(result1);
		 * 
		 * System.out.println("-----------------------"); String result2 =
		 * jsonElement.getAsJsonObject().get("result").getAsJsonObject().toString();
		 * System.out.println(result2);
		 */

		System.out.println("-----------------------");
		String result3 = jsonElement.getAsJsonObject().get("result").getAsJsonObject().get("commentList").toString();
		System.out.println(result3);

		JsonElement finalElement = jsonParser.parse(result3);

		System.out.println("-----------------------");
		String result4 = finalElement.getAsJsonArray().get(0).getAsJsonObject().get("contents").toString();
		// Array 인덱스는 0~19로 가져오면 됨
		System.out.println(result4);

		System.out.println("-----------------------------------");
		String[] arr = new String[20];
		for (int i = 0; i < 20; i++) {
			arr[i] = jsonElement.getAsJsonObject().get("result").getAsJsonObject().get("commentList").getAsJsonArray()
					.get(i).getAsJsonObject().get("contents").toString();
			System.out.println(arr[i]);
		}

	}

}