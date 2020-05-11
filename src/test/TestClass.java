package test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.json.simple.parser.JSONParser;

public class TestClass {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		String q = "스칼라"; // 검색어

		Document doc = Jsoup.connect("https://ac.search.naver.com/nx/ac").header("origin", "http://www.naver.com")
				.header("referer", "https://www.naver.com/").header("accept-encoding", "gzip, deflate, sdch, br")
				.data("con", "1").data("_callback", "") // _callback 파라미터를 비우면 JSON이 리턴
				.data("rev", "4").data("r_enc", "UTF-8").data("q", q) // 임의로 몇개의 파라미터와 헤더를 생략

				.data("st", "100") // 각 파라미터가 무엇을 뜻하는지를 확인해 적절하게 사용하는 것도 좋지만
				.data("q_enc", "UTF-8") // 비정상적인 요청으로 감지해 아이디나 아이피가 밴 될 우려도 있으므로
				.data("r_format", "json") // 특별한 이유가 없다면 모두 포함하는 것이 좋음

				.data("t_koreng", "1").data("ans", "2").data("run", "2").ignoreContentType(true) // HTML Document가 아니므로
																									// Response의 컨텐트 타입을
																									// 무시
				.get();

		List<String> result = new ArrayList<>();
		JsonParser parser = new JsonParser();

		// org.json 라이브러리를 사용해 결과를 파싱한다.

		// JSONObject jsonObject = new JSONObject(doc.text()); --- String 받아들이기 위해서 (예외)
		JSONObject jsonObject = (JSONObejct) parser.parse(doc.text());

		// JSONObject jsonObject = new JSONObject();
		// Object obj = parser.parse(doc.text());
		// JSONObject jsonObj = (JSONObject) obj;

		JSONArray items = (JSONArray) ((JSONArray) jsonObject.get("items")).get(0);
		for (int i = 0; i < ((CharSequence) items).length(); i++) {
			String item = (String) (((JSONArray) items.get(i)).get(0));
			result.add(item);
		}

		// 얻어낸 추천 검색어 목록
		for (String item : result) {
			System.out.println(item);
		}

	}

}
