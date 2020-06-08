package test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.json.simple.parser.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import poly.util.UrlEncodeUtil;

public class NaverNewsTest {

	public static void main(String[] args) throws IOException, ParseException {

		String keyword = "홈플러스";
		String urlEnc = UrlEncodeUtil.getEncode(keyword);
		System.out.println(urlEnc);

		List<String> news_num = new ArrayList<String>();
		Elements element1;
		Iterator<Element> content = null;
		String tmp;
		String num;
		String onclick;
		String href;
		String url = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=" + urlEnc;
		// query 쪽 검색어 값을 url 인코더로 처리(encoding util 파일 하나 생성해서 구글 트렌드까지 해결하자)
		// 나이대 해결하기

		Document doc = null;
		doc = Jsoup.connect(url).get();
		Iterator<Element> time = null;
		// 위 페이지에서 기사 등록 시간 옆에 나오는 네이버뉴스 a태그 따라가면 네이버 뉴스로 통일된 기사에 접근가능
		// 본문(본문쪽 content태그는 둘 중 하나, 대성이한테 받은거로 처리)과 댓글 쪽까지 접근가능 (본문으로는 워드클라우드, 댓글로는
		// 오피니언 마이닝)

		// 아래에 a href = "#"과 같이 잡혔는데 a[href^=http]로 처음부터 지정해서 a href = "http~~~~ "인 부분만
		// 가져옴
		Elements element = doc.select("dd.txt_inline a[href^=http]");

		for (Element a : element) {
			href = a.attr("href");
			onclick = a.attr("onclick");
			int i = onclick.indexOf("&");
			tmp = onclick.substring(36);
			int j = tmp.indexOf("&");
			num = tmp.substring(2, j);
			news_num.add(num);
			System.out.println(href);
			/*
			 * System.out.println(onclick); System.out.println(i); System.out.println(j);
			 */
			System.out.println(num);
			System.out.println("--------------------");
		}

		System.out.println(news_num);
		System.out.println(news_num.size());
		System.out.println("------------------------");

		for (int i = 0; i < news_num.size(); i++) {
			element1 = doc.select("li#sp_nws" + news_num.get(i));
			content = element1.select("dd.txt_inline").iterator();
			String con = content.next().text();

			int j = con.lastIndexOf("전");
			String str_tmp = con.substring(0, j-1);
			int k = str_tmp.lastIndexOf(" ");
			String str_final = str_tmp.substring(k+1);
			System.out.println(str_final);

		}

		System.out.println("----------------");
	}

}
