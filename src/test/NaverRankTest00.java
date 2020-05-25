package test;

import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class NaverRankTest00 {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub

		Document doc = Jsoup.connect("https://datalab.naver.com/keyword/realtimeList.naver?where=main")
				.header("origin", "http://www.naver.com").header("referer", "https://www.naver.com/")
				.header("accept-encoding", "gzip, deflate, sdch, br").get();
		Elements element = doc.select("div.ranking_box");
		System.out.println("제발!");

		Iterator<Element> num = element.select("span.item_num").iterator();
		Iterator<Element> title = element.select("span.item_title").iterator();

		while (title.hasNext()) {
			System.out.print(num.next() + ". ");
			System.out.println(title.next());
		}

	}

}
