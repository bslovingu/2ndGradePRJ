package test;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class NaverRankTest01 {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		Document doc = Jsoup.connect("https://cc.naver.com/cc").header("User-Agent", "Mozilla/5.0 (Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36").header("origin", "http://www.naver.com")
				.header("referer", "https://www.naver.com/").header("Accept", "*/*").header("accept-encoding", "gzip, deflate, br").header("Accept-Language", "ko").header("Connection", "Keep-Alive")
				.data("r", "") // 각 파라미터가 무엇을 뜻하는지를 확인해 적절하게 사용하는 것도 좋지만
				.data("i", "") // 비정상적인 요청으로 감지해 아이디나 아이피가 밴 될 우려도 있으므로
				.data("m", "0") // 특별한 이유가 없다면 모두 포함하는 것이 좋음

				.data("ssc", "navertop.v4").data("u", "about:Ablank")
				.data("p","").data("px", "").data("py", "").data("sx", "").data("sy","")
				.ignoreContentType(true) // HTML Document가 아니므로 // Response의 컨텐트 타입을
											// 무시
				.get();
		Elements element = doc.select("div#NM_RTK_VIEW_list_wrap");
		System.out.println("제발!");

		Iterator<Element> num = element.select("strong.rank").iterator();
		Iterator<Element> title = element.select("span.keyword").iterator();

		while (title.hasNext()) {
			System.out.print(num.next() + ". ");
			System.out.println(title.next());
		}

	}

}
