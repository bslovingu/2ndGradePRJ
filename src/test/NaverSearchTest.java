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

public class NaverSearchTest {

	public static void main(String[] args) throws IOException, ParseException {

		Document doc = Jsoup.connect("https://ac.search.naver.com/nx/ac").header("origin", "http://www.naver.com")
				.header("referer", "https://www.naver.com/").header("accept-encoding", "gzip, deflate, sdch, br")
				.data("con", "1").data("_callback", "") // _callback 파라미터를 비우면 JSON이 리턴
				.data("rev", "4").data("r_enc", "UTF-8").data("q", "폴리텍") // 임의로 몇개의 파라미터와 헤더를 생략

				.data("st", "100") // 각 파라미터가 무엇을 뜻하는지를 확인해 적절하게 사용하는 것도 좋지만
				.data("q_enc", "UTF-8") // 비정상적인 요청으로 감지해 아이디나 아이피가 밴 될 우려도 있으므로
				.data("r_format", "json").data("r_unicode", "0") // 특별한 이유가 없다면 모두 포함하는 것이 좋음

				.data("t_koreng", "1").data("ans", "2").data("run", "2").ignoreContentType(true) // HTML Document가 아니므로
																									// Response의 컨텐트 타입을
																									// 무시
				.get();

		List<String> result = new ArrayList<>();
		JSONParser parser = new JSONParser();

		// org.json 라이브러리를 사용해 결과를 파싱한다.

		// JSONObject jsonObject = new JSONObject();
		// Object 객체를 이용해서 캐스팅해야한다.

		Object obj = parser.parse(doc.text());
		JSONObject jsonObj = (JSONObject) obj;

		JSONArray items = (JSONArray) ((JSONArray) jsonObj.get("items")).get(0);
		System.out.println(items);
		for (int i = 0; i < (items).size(); i++) {
			String item = (String) (((JSONArray) items.get(i)).get(0));
			result.add(item);
		}

		// 얻어낸 추천 검색어 목록

		System.out.println(result);
		
		for (String item : result) {
			System.out.println(item);
		}

	}

}
