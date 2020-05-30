package test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class NaverRankTest02 {

	public static void main(String[] args) throws IOException, ParseException {

		Document doc = Jsoup.connect("https://apis.naver.com/mobile_main/srchrank/srchrank?frm=main")
				// .header("origin", "http://www.naver.com").header("referer", "https://www.naver.com/")
				.data("_callback", "")
				// .data("sm", "agallgr0ma0simenmsp0")
				
				.data("ag", "all").data("gr", "4").data("ma", "2").data("si", "2").data("en", "-2").data("sp", "-2")
				.ignoreContentType(true).get();

		// data 값 ag, gr, ma, si, en, sp 지정시
		// 분류별로 조회 가능 (현재는 ma 는 0인 상태)
		// gr은 예외적으로 0~4, 나머지는 -2~2 
		
		System.out.println(doc);

		JSONParser jParser = new JSONParser();

		// org.json 라이브러리를 사용해 결과를 파싱한다.

		// JSONObject jsonObject = new JSONObject();
		// Object 객체를 이용해서 캐스팅해야한다.

		Object obj = jParser.parse(doc.text());
		JSONObject jsonObj = (JSONObject) obj;
		System.out.println("-------------------------");
		System.out.println(jsonObj);

		JSONArray info = (JSONArray) ((JSONArray) jsonObj.get("data"));
		System.out.println("-------------------------");
		System.out.println(info);
		System.out.println("-------------------------");

		for (int i = 0; i < info.size(); i++) {
			JSONObject tmp = (JSONObject) info.get(i);

			Long rank = (Long) tmp.get("rank");
			String keyword = (String) tmp.get("keyword");
			JSONArray arr = (JSONArray) tmp.get("keyword_synonyms");

			System.out.println(rank + ". " + keyword + ": " + arr);
			// System.out.println(rank + ". " + keyword + ": " + arr);
		}

	}

}
