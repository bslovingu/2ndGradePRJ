package test;

import java.io.IOException;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class NaverContentTest {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		String add = "m_view=1&includeAllCount=ture&";
		String url = "https://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=102&oid=028&aid=0002498741";
		// 경주를 검색했을 때 가정, 첫 번째 뉴스를 예시로 연습
		// 한가지 키워드에 대해서 뉴스를 반복문으로 10개 크롤링

		Document doc = null;
		doc = Jsoup.connect(url).get();

		Elements conElement = doc.select("div#main_content");

		Iterator<Element> content = conElement.select("div#articleBodyContents").iterator();
		if (content == null) {
			content = conElement.select("div#newsEndContents").iterator();
		}

		
		
		while (content.hasNext()) {
			System.out.println(content.next());
		}

		System.out.println("------------------------");

	}

}
