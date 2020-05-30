package test;

import java.io.IOException;

import org.json.simple.parser.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import poly.util.UrlEncodeUtil;

public class NaverNewsTest {

	public static void main(String[] args) throws IOException, ParseException {

		String keyword = "경주";
		String urlEnc = UrlEncodeUtil.getEncode(keyword);
		System.out.println(urlEnc);
		
		String href;
		String url = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query="+urlEnc;
		// query 쪽 검색어 값을 url 인코더로 처리(encoding util 파일 하나 생성해서 구글 트렌드까지 해결하자)
		// 실시간 검색어 설정을 엔터와 스포츠는 -2로 고정, 상위 세개 항목과 연령대만 버튼으로 지정

		Document doc = null;
		doc = Jsoup.connect(url).get();

		// 위 페이지에서 기사 등록 시간 옆에 나오는 네이버뉴스 a태그 따라가면 네이버 뉴스로 통일된 기사에 접근가능
		// 본문(본문쪽 content태그는 둘 중 하나, 대성이한테 받은거로 처리)과 댓글 쪽까지 접근가능 (본문으로는 워드클라우드, 댓글로는
		// 오피니언 마이닝)

		// 아래에 a href = "#"과 같이 잡혔는데 a[href^=http]로 처음부터 지정해서 a href = "http~~~~ "인 부분만 가져옴
		Elements element = doc.select("dd.txt_inline a[href^=http]");
		
		
		for (Element a : element) {
			href = a.attr("href");
			System.out.println(href);
		}

		System.out.println("------------------------");

	}

}
