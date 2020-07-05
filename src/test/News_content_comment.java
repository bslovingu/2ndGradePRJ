package test;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import poly.dto.NewsDTO;
import poly.util.CmmUtil;
import poly.util.UrlEncodeUtil;

public class News_content_comment {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		List<String> news_num = new ArrayList<String>();
		List<String> news_url = new ArrayList<String>();
		List<String> real_time = new ArrayList<String>();
		List<String> real_con = new ArrayList<String>();

		String tmp;
		String num;
		String onclick;
		String href;
		String urlEnc = UrlEncodeUtil.getEncode("코로나");
		String url = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=" + urlEnc;

		Document doc = null;

		doc = Jsoup.connect(url).get();

		Elements element = doc.select("dd.txt_inline a[href^=http]");

		for (Element a : element) {
			href = a.attr("href");
			onclick = a.attr("onclick");
			int i = onclick.indexOf("&");
			tmp = onclick.substring(i + 1);
			int j = tmp.indexOf("&");
			num = tmp.substring(2, j);
			news_num.add(num);
			news_url.add(href);
		}
		
		System.out.println("네이버 뉴스 번호 따오기 : " + news_num + "ㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍ");
		System.out.println("번호에 따른 네이버 뉴스 url : " + news_url + "ㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍ");

		/* 가끔씩 보도자료가 안 나오는 실시간 검색어가 있을 수 있음 Ex) 저라뎃/강만식 */
		/* new_num.size()가 0인 경우에는 사용자에게 모달 창에서 보도자료가 없다고 알려줄 수 있도록 만들어야함 */

		System.out.println("-----------------------------------");
		System.out.println("뉴스 갯수 : " + news_num.size());
		for (int i = 0; i < news_num.size(); i++) {
			NewsDTO dDTO = new NewsDTO();

			Iterator<Element> news_content = null;
			Iterator<Element> news_time = null;

			String real_url = news_url.get(i); // 네이버 뉴스가 달려있는 것만 url가져옴 (위에 for문 있음)
			Document doc1 = null;
			doc1 = Jsoup.connect(real_url).get(); // 여기서 뉴스 본문 위에 있는 기사입력시간 크롤링하기
			int tmpIndex = real_url.lastIndexOf("&");
			/* System.out.println(tmpIndex); // 현재는 값이 100 */

			String oid = real_url.substring(tmpIndex - 3, tmpIndex);
			String aid = real_url.substring(tmpIndex + 5);
			/*
			 * System.out.println("oid : " + oid);
			 * System.out.println("aid : " + aid);
			 */
			if (real_url.charAt(8) == 'n' || real_url.charAt(7) == 'n') {
				Elements conElement = doc1.select("div#main_content");
				Elements timeElement = doc1.select("div.sponsor");
				news_content = conElement.select("div#articleBodyContents").iterator();
				news_time = timeElement.select("span.t11").eq(0).iterator();
				if (news_content.hasNext() == false) {
					news_content = conElement.select("div#newsEndContents").iterator();
				}
				if (news_content.hasNext() == false) {
					String new_url = "https://entertain.naver.com/read?oid=" + oid + "&aid=" + aid;
					doc1 = Jsoup.connect(new_url).get();
					conElement = doc1.select("div.end_body_wrp");
					timeElement = doc1.select("div.article_info");
					news_content = conElement.select("div#articeBody").iterator(); // 연예 뉴스
					news_time = timeElement.select("span.author").eq(0).select("em").iterator();
				}

			}

			if (real_url.charAt(8) == 's' || real_url.charAt(7) == 's') {
				Elements conElement = doc1.select("div.content_area");
				Elements timeElement = doc1.select("div.info");
				news_content = conElement.select("div#newsEndContents").iterator(); // 스포츠 뉴스
				news_time = timeElement.select("span:first-child").iterator();
				if (news_content.hasNext() == false) {
					String new_url = "https://entertain.naver.com/read?oid=" + oid + "&aid=" + aid;
					doc1 = Jsoup.connect(new_url).get();
					conElement = doc1.select("div.end_body_wrp");
					timeElement = doc1.select("div.article_info");
					news_content = conElement.select("div#articeBody").iterator(); // 연예 뉴스
					news_time = timeElement.select("span.author").eq(0).select("em").iterator();
				}
			}

			if (real_url.charAt(8) == 'e' || real_url.charAt(7) == 'e') {
				Elements conElement = doc1.select("div.end_body_wrp");
				Elements timeElement = doc1.select("div.article_info");
				news_content = conElement.select("div#articeBody").iterator(); // 연예 뉴스
				news_time = timeElement.select("span.author").eq(0).select("em").iterator();
			}

			if (news_time.hasNext()) {
				String news_date = news_time.next().text();
				if (news_date.length() == 20) {
					real_time.add(news_date);
				} else {
					int k = news_date.lastIndexOf(" ");
					news_date = news_date.substring(0, k + 1) + "0" + news_date.substring(k + 1);
					real_time.add(news_date);
				}
				
			}
			if (news_content.hasNext()) {
				String news_con = news_content.next().text();
				real_con.add(news_con);
				
			}

			
			Collections.sort(real_time);
			
			/* System.out.println("뉴스 본문 : " + real_con); */
			dDTO.setReal_time(real_time);
			dDTO.setReal_con(real_con);

			int tmp_ques = real_url.indexOf("?"); // 댓글 url 페이지 만들기 시작
			String add = "m_view=1&includeAllCount=true&";

			String url_1 = real_url.substring(0, tmp_ques + 1);
			String url_2 = real_url.substring(tmp_ques + 1);
			String commURL = url_1 + add + url_2; // 댓글 url 페이지 만들기 끝
			System.out.println("댓글 referer url : " + commURL);
			if (real_url.charAt(8) == 'n' || real_url.charAt(7) == 'n') {
				dDTO.setReal_com(null);
			}
			if (commURL.charAt(8) == 's') {
				dDTO.setReal_com(null);
			}
			if (commURL.charAt(8) == 'n') {

				List<String> counting = new ArrayList<String>();
				Document doc_cnt = Jsoup.connect(commURL).get();
				Elements element_cnt = doc_cnt.select("td.content");
				System.out.println("---------! ---" + element_cnt);
				Iterator<Element> content_cnt = element_cnt.select("span.u_cbox_info_txt").iterator();
				if(content_cnt.hasNext()) {
					String comm_cnt = content_cnt.next().text();
					counting.add(comm_cnt);
				}
				System.out.println(counting);
				
				String test_url = "https://apis.naver.com/commentBox/cbox/web_naver_list_jsonp.json?ticket=news&templateId=default_society&pool=cbox5&_callback=jQuery1706087132582402561_1534112016030&lang=ko&country=&objectId=news"
						+ oid + "%2C" + aid
						+ "&categoryId=&pageSize=20&indexSize=10&groupId=&listType=OBJECT&pageType=more&page=";
				int cnt = 1;
				boolean testb = true;
				List<String> strList = new ArrayList<String>();
			
				while (testb) {
					/*
					 * System.out.println( System.nanoTime() / 1000000000.0 +
					 * "-------------- 하나씩연결~~~~~~~~~~~~~~~~~~~~~~~~시작");
					 */
					String t_url = test_url + Integer.toString(cnt);
					URL obj = new URL(t_url);

					HttpsURLConnection con1 = (HttpsURLConnection) obj.openConnection();

					// add request header
					con1.setRequestMethod("POST");
					con1.setRequestProperty("User-Agent", "Mozilla/5.0");
					con1.setRequestProperty("Content-Type", "application/json");
					con1.setRequestProperty("referer", commURL);

					// Send post request
					con1.setDoOutput(true);

					DataOutputStream wr = new DataOutputStream(con1.getOutputStream());
					wr.flush();

					/*
					 * int responseCode = con1.getResponseCode(); System.out.println(responseCode);
					 */

					BufferedReader in = new BufferedReader(new InputStreamReader(con1.getInputStream()));
					String inputLine;
					StringBuffer response = new StringBuffer();

					while ((inputLine = in.readLine()) != null) {
						response.append(inputLine);
					}
					in.close();

					// print result

					String tmpStr = response.toString();
					int openIndex = tmpStr.indexOf("(");
					int closeIndex = tmpStr.lastIndexOf(")");

					String str = tmpStr.substring(openIndex + 1, closeIndex);

					JsonParser jsonParser = new JsonParser();
					JsonElement jsonElement = jsonParser.parse(str);

					int k1 = 0;
					Iterator<JsonElement> iter = jsonElement.getAsJsonObject().get("result").getAsJsonObject()
							.get("commentList").getAsJsonArray().iterator();
					while (iter.hasNext()) {
						k1++;
						iter.next();
					}
					String[] arr = new String[k1];

					if (k1 == 0) {
						strList.add(" ");
						testb = false;
						wr.close();
					} else {
						for (int i1 = 0; i1 < k1; i1++) {
							arr[i1] = CmmUtil.nvl(
									jsonElement.getAsJsonObject().get("result").getAsJsonObject().get("commentList")
											.getAsJsonArray().get(i1).getAsJsonObject().get("contents").toString());
							/* System.out.println("댓글 출력 예시 : " + (arr[i1])); */
							strList.add(arr[i1]);
							if (k1 != 20 && i1 == k1 - 1) {
								testb = false;
								wr.close();
							}
						}
					}
					/*
					 * System.out.println( System.nanoTime() / 1000000000.0 +
					 * "-------------- 하나씩연결~~~~~~~~~~~~~~~~~~~~~~~~끝" + cnt);
					 */
					cnt++;
				}
				System.out.println("댓글 개수 : " + strList.size());
				dDTO.setReal_com(strList);
			}
			/*
			 * dlist.add(dDTO); dDTO = null;
			 */
		}
	}

}
