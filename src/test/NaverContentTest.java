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

		char s = 's';
		char e = 'e';
		char n = 'n';

		String add = "m_view=1&includeAllCount=true&";
		// String url =
		// "https://news.naver.com/main/read.nhn?mode=LSD&mid=sec&sid1=102&oid=028&aid=0002498741";
		/*
		 * String url ="https://entertain.naver.com/read?oid=416&aid=0000258951"; // 연예
		 */

		String url = "https://entertain.naver.com/read?oid=109&aid=0004220414"; // 스포츠

		int tmp = url.indexOf("?");
		System.out.println(tmp);

		String url_1 = url.substring(0, tmp + 1);
		String url_2 = url.substring(tmp + 1);
		String commURL = url_1 + add + url_2;
		System.out.println(commURL);

		// 경주를 검색했을 때 가정, 첫 번째 뉴스를 예시로 연습
		// 한가지 키워드에 대해서 뉴스를 반복문으로 10개 크롤링
		// add를 ? 뒤에 추가해서 댓글 쪽 url NaverCommentTest로 넘기기

		Document doc = null;
		doc = Jsoup.connect(url).get();

		Iterator<Element> content = null;
		if (url.charAt(8) == n) {
			Elements conElement = doc.select("div#main_content");
			content = conElement.select("div#articleBodyContents").iterator();
			if (content == null) {
				content = conElement.select("div#newsEndContents").iterator();
			}
		}
		if (url.charAt(8) == e) {
			Elements conElement = doc.select("div.end_body_wrp");
			content = conElement.select("div#articeBody").iterator(); // 연예 뉴스
		}
		if (url.charAt(8) == s) {
			Elements conElement = doc.select("div.content_area");
			content = conElement.select("div#newsEndContents").iterator(); // 스포츠 뉴스
		}

		if (content.hasNext()) {
			String con = content.next().text();
			System.out.println(con);

		}

		System.out.println("------------------------");
		// 본문 내용
		/*
		 * while (content.hasNext()) { System.out.println(content.next()); }
		 */

		System.out.println("------------------------");

		// 댓글 갯수 구해서 넘겨야 하는데, 태그와 class명까지 같은거 추출하는 방법?
		/*
		 * Iterator<Element> count =
		 * countElement.select("span.u_cbox_info_txt").iterator();
		 * 
		 * while(count.hasNext()) { System.out.println(count.next()); }
		 */
	}

}
