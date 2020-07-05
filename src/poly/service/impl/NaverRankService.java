package poly.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

import poly.dto.RankDTO;
import poly.dto.ValueDTO;
import poly.service.INaverRankService;

@Service("NaverRankService")
public class NaverRankService implements INaverRankService {

	private Logger log = Logger.getLogger(this.getClass());

	@Override
	public List<RankDTO> collectNaverRank(ValueDTO pDTO) throws Exception {
		log.info(this.getClass().getName() + "collectNaverRank Start!");

		String gr = (pDTO.getMyRange1() != null) ? pDTO.getMyRange1() : "2";
		String ma = (pDTO.getMyRange2() != null) ? pDTO.getMyRange2() : "0";
		String si = (pDTO.getMyRange3() != null) ? pDTO.getMyRange3() : "0";
		String en = (pDTO.getMyRange4() != null) ? pDTO.getMyRange4() : "0";
		String sp = (pDTO.getMyRange5() != null) ? pDTO.getMyRange5() : "0";
		String ag = (pDTO.getMyRange6() != null) ? pDTO.getMyRange6() : "all";
		if (Integer.parseInt(ag) == 0) {
			ag = "all";
		} else {
			ag = Integer.toString(Integer.parseInt(ag) * 10) + "s";
		}

		Document doc = Jsoup.connect("https://apis.naver.com/mobile_main/srchrank/srchrank?frm=main")
				// .header("origin", "http://www.naver.com").header("referer",
				// "https://www.naver.com/")
				.data("_callback", "")
				// .data("sm", "agallgr0ma0simenmsp0")

				.data("ag", ag).data("gr", gr).data("ma", ma).data("si", si).data("en", en).data("sp", sp)
				.ignoreContentType(true).get();

		// data 값 ag, gr, ma, si, en, sp 지정시
		// 분류별로 조회 가능 (현재는 ma 는 0인 상태)
		// gr은 예외적으로 0~4, 나머지는 -2~2

		JSONParser jParser = new JSONParser();

		// org.json 라이브러리를 사용해 결과를 파싱한다.

		// JSONObject jsonObject = new JSONObject();
		// Object 객체를 이용해서 캐스팅해야한다.

		Object obj = jParser.parse(doc.text());
		JSONObject jsonObj = (JSONObject) obj;

		JSONArray info = (JSONArray) ((JSONArray) jsonObj.get("data"));

		List<RankDTO> dlist = new ArrayList<RankDTO>();

		if (info != null) {
			for (int i = 0; i < info.size(); i++) {
				JSONObject tmp = (JSONObject) info.get(i);
				RankDTO dDTO = new RankDTO();
				Long rank = (Long) tmp.get("rank");
				String keyword = (String) tmp.get("keyword");
				JSONArray arr = (JSONArray) tmp.get("keyword_synonyms");
				dDTO.setKeyword(keyword);
				dDTO.setRank(rank);
				List<String> keyword_synonyms = new ArrayList<String>();
				if (arr.size() > 0) {
					for (int j = 0; j < arr.size(); j++) {
						keyword_synonyms.add(arr.get(j).toString());
					}
				}

				List<String> keyword1 = new ArrayList<String>();
				keyword1.add(keyword);

				dDTO.setKeyword_synonyms(keyword_synonyms);
				dlist.add(dDTO);
				dDTO = null;
			}
		}

		return dlist;

	}

	@Override
	public List<String> getRelKeyword(String keyword) throws Exception {
		Document doc = Jsoup.connect("https://ac.search.naver.com/nx/ac").header("origin", "http://www.naver.com")
				.header("referer", "https://www.naver.com/").header("accept-encoding", "gzip, deflate, sdch, br")
				.data("con", "1").data("_callback", "") // _callback 파라미터를 비우면 JSON이 리턴
				.data("rev", "4").data("r_enc", "UTF-8").data("q", keyword) // 임의로 몇개의 파라미터와 헤더를 생략

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
		for (int i = 0; i < (items).size(); i++) {
			String item = (String) (((JSONArray) items.get(i)).get(0));
			result.add(item);
		}

		return result;
	}
}
