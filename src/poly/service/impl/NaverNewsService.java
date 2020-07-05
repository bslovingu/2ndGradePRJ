package poly.service.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import poly.dto.DataDTO;
import poly.dto.MongoDataDTO;
import poly.dto.NewsDTO;
import poly.persistance.mapper.IUserMapper;
import poly.persistance.mongo.IMongoTestMapper;
import poly.service.INaverNewsService;
import poly.util.CmmUtil;
import poly.util.DateUtil;
import poly.util.UrlEncodeUtil;

@Service("NaverNewsService")
public class NaverNewsService implements INaverNewsService {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserMapper")
	private IUserMapper userMapper;

	@Resource(name = "MongoTestMapper")
	private IMongoTestMapper mongoMapper;

	@Override
	public List<NewsDTO> collectNaverNews(String keyword) throws Exception {
		log.info(this.getClass().getName() + "collectNaverNews Start!");
		List<String> news_num = new ArrayList<String>();
		List<String> news_url = new ArrayList<String>();
		List<String> real_time = new ArrayList<String>();
		List<String> real_con = new ArrayList<String>();
		List<String> strList1 = new ArrayList<String>();
		List<Integer> each_cnt = new ArrayList<Integer>();
		Iterator<Element> news_time = null;
		Iterator<Element> news_content = null;
		String tmp;
		String num = null;
		String onclick;
		String href;
		/*
		 * keyword = "파티게임즈"; // 실검 지나간 검색어로 설정하려면 여기서
		 */

		String urlEnc = UrlEncodeUtil.getEncode(keyword);
		String url = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=" + urlEnc;

		Document doc = null;
		doc = Jsoup.connect(url).get();

		Elements element = doc.select("dd.txt_inline a[href^=http]");

		List<NewsDTO> dlist = new ArrayList<NewsDTO>();

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

		if (num != null) {
			log.info("네이버 뉴스 추출 시작");
			/* 가끔씩 보도자료가 안 나오는 실시간 검색어가 있을 수 있음 Ex) 저라뎃/강만식 */
			/* new_num.size()가 0인 경우에는 사용자에게 모달 창에서 보도자료가 없다고 알려줄 수 있도록 만들어야함 */
			for (int i = 0; i < news_num.size(); i++) {
				NewsDTO dDTO = new NewsDTO();

				String real_url = news_url.get(i); // 네이버 뉴스가 달려있는 것만 url가져옴 (위에 for문 있음)

				Document doc1 = null;
				doc1 = Jsoup.connect(real_url).get();

				int tmpIndex = real_url.lastIndexOf("&");
				/* System.out.println(tmpIndex); // 현재는 값이 100 */

				String oid = real_url.substring(tmpIndex - 3, tmpIndex);
				String aid = real_url.substring(tmpIndex + 5);
				/*
				 * System.out.println("oid : " + oid); System.out.println("aid : " + aid);
				 */
				log.info("네이버 뉴스 시간/본문 가져오기 시작");
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
						int k1 = news_date.lastIndexOf(" ");
						news_date = news_date.substring(0, k1 + 1) + "0" + news_date.substring(k1 + 1);
						real_time.add(news_date);
					}

				}
				log.info("네이버 뉴스 시간 가져오기 끝");

				if (news_content.hasNext()) {
					String news_con = news_content.next().text();
					real_con.add(news_con);

				}

				log.info("네이버 뉴스 본문 가져오기 끝");
				Collections.sort(real_time);

				/* System.out.println("뉴스 본문 : " + real_con); */
				dDTO.setReal_time(real_time);
				dDTO.setReal_con(real_con);

				int tmp_ques = real_url.indexOf("?"); // 댓글 url 페이지 만들기 시작
				String add = "m_view=1&includeAllCount=true&";

				List<String> false_com = new ArrayList<String>();
				String url_1 = real_url.substring(0, tmp_ques + 1);
				String url_2 = real_url.substring(tmp_ques + 1);
				String commURL = url_1 + add + url_2; // 댓글 url 페이지 만들기 끝
				if (real_url.charAt(8) == 'n' || real_url.charAt(7) == 'n') {
					false_com.add(" ");
					dDTO.setReal_com(false_com);
				}
				if (commURL.charAt(8) == 's') {
					false_com.add(" ");
					dDTO.setReal_com(false_com);
				}
				if (commURL.charAt(8) == 'n') {

					String test_url = "https://apis.naver.com/commentBox/cbox/web_naver_list_jsonp.json?ticket=news&templateId=default_society&pool=cbox5&_callback=jQuery1706087132582402561_1534112016030&lang=ko&country=&objectId=news"
							+ oid + "%2C" + aid
							+ "&categoryId=&pageSize=20&indexSize=10&groupId=&listType=OBJECT&pageType=more&page=";
					int cnt = 1;
					boolean testb = true;

					log.info("네이버 댓글 가져오기 시작");

					while (testb) {

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

						each_cnt.add(k1);

						String[] arr = new String[k1];

						if (k1 == 0) {
							strList1.add(" ");
							testb = false;
							wr.close();
						} else {
							for (int i1 = 0; i1 < k1; i1++) {
								if (cnt < 3) {
									arr[i1] = CmmUtil.nvl(jsonElement.getAsJsonObject().get("result").getAsJsonObject()
											.get("commentList").getAsJsonArray().get(i1).getAsJsonObject()
											.get("contents").toString());
									/* System.out.println("댓글 출력 예시 : " + (arr[i1])); */
									strList1.add(arr[i1]);
								}
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

					log.info("네이버 댓글 가져오기 끝");
					if (strList1.size() == 0) {
						strList1.add("뉴스 댓글 : 최근에 등록된 댓글이 없습니다.");
					}
					dDTO.setReal_com(strList1);

					dDTO.setTotal_com(each_cnt);
				}
				dlist.add(dDTO);
				dDTO = null;
			}
		} else {
			NewsDTO dDTO = new NewsDTO();
			real_time.add("뉴스 시간 : 최근에 등록된 뉴스가 없습니다.");
			real_con.add("뉴스 본문 : 최근에 등록된 뉴스가 없습니다.");
			strList1.add("뉴스 댓글 : 최근에 등록된 뉴스가 없습니다.");

			dDTO.setReal_time(real_time);
			dDTO.setReal_con(real_con);
			dDTO.setReal_com(strList1);
			dlist.add(dDTO);
			dDTO = null;
		}

		return dlist;
	}

	@Override
	public List<DataDTO> analysisData(List<NewsDTO> rList, String user_id, String keyword) throws Exception {
		List<DataDTO> pList = new ArrayList<DataDTO>();
		if (rList == null) {
			log.info("rList가 엄씀니다");
			rList = new ArrayList<NewsDTO>();
			return pList;
		}
		if (rList.get(0).getReal_con().contains("뉴스 본문 : 최근에")) {
			log.info("뉴스 본문");
			return pList;
		}

		double k = 0;
		for (int i = 0; i < rList.get(0).getTotal_com().size(); i++) {
			k += rList.get(0).getTotal_com().get(i);
		}
		double l = rList.get(0).getReal_com().size();

		log.info(k + "해당 키워드의 전체 댓글 수");
		log.info(l + "40개씩 택했을 때의 댓글 수");
		double m;
		if (k > 10) {
			double p = 0.5;
			m = 1.96 * (Math.sqrt((p * (1 - p) * (k - l)) / (l * (k - 1)))) * 100;
			log.info(m + "오차범위 계산값");
		} else {
			m = 0.0;
		}
		log.info("모든 기사 내용 리스트 만들기 시작");
		// 모든 기사 내용 들어간 리스트
		List<String> strList_con = new ArrayList<String>();
		List<String> strList_com = new ArrayList<String>();

		for (int i = 0; i < rList.size(); i++) {
			for (int j = 0; j < rList.get(i).getReal_con().size(); j++) {
				strList_con.add(rList.get(i).getReal_con().get(j));
			}
			if (rList.get(i).getReal_com() == null) {
				List<String> nArr = new ArrayList<String>();
				rList.get(i).setReal_com(nArr);
			}
			for (int j = 0; j < rList.get(i).getReal_com().size(); j++) {
				strList_com.add(rList.get(i).getReal_com().get(j));
			}
		}

		log.info("모든 기사 내용 리스트 만들기 끝");

		String[] sArr_con = new String[strList_con.size()];
		String[] sArr_com = new String[strList_com.size()];

		if (strList_con.size() == 1) {
			sArr_con = new String[2];
		}

		DataDTO pDTO = new DataDTO();
		pDTO.setKeyword(keyword);
		pDTO.setStat(m);
		pDTO.setPart((int) l);
		String[] timeList = new String[2];

		/*
		 * System.out.println("------------" + rList.get(0).getReal_time().get(0));
		 * System.out.println("++++++++++++" +
		 * rList.get(0).getReal_time().get(rList.get(0).getReal_time().size()-1));
		 */

		if (rList.get(0).getReal_time().get(0) != "뉴스 시간 : 최근에 등록된 뉴스가 없습니다.") {
			timeList[0] = rList.get(0).getReal_time().get(0);
			timeList[1] = rList.get(0).getReal_time().get(rList.get(0).getReal_time().size() - 1);
		} else {
			timeList[0] = rList.get(0).getReal_time().get(0);
			timeList[1] = " ";
		}

		pDTO.setReal_time(timeList);

		log.info("모든 기사 내용 배열 만들기 시작");

		for (int i = 0; i < strList_con.size(); i++) {
			String match_con = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
			sArr_con[i] = strList_con.get(i).replaceAll(match_con, " ").toLowerCase();
		}

		for (int i = 0; i < strList_com.size(); i++) {
			String match_com = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
			sArr_com[i] = strList_com.get(i).replaceAll(match_com, " ").toLowerCase();
		}

		if (strList_con.size() == 1) {
			sArr_con[1] = "         ";
		}

		log.info("모든 기사 내용 배열 만들기 끝");

		/* } */
		log.info("모든 기사 내용 분석 시작");

		RConnection c = new RConnection();
		c.eval("negative <- readLines('C:\\emoDic\\negDic.txt', encoding='UTF-8')");
		c.eval("positive <- readLines('C:\\emoDic\\posDic.txt', encoding='UTF-8')");

		c.assign("rc_con", sArr_con); // 형태소 분석
		c.assign("rc_com", sArr_com);

		log.info("형태소분석 시작");
		// c.eval("m_df <- rc_con %>% SimplePos09 %>% melt %>% as_tibble");
		c.eval("m_df <- as_tibble(melt(SimplePos09(rc_con,autoSpacing=T)))");
		// c.eval("m_df_1 <- rc_com %>% SimplePos09 %>% melt %>% as_tibble");
		c.eval("m_df_1 <- as_tibble(melt(SimplePos09(rc_com,autoSpacing=T)))");

		// ---------------------------------------
		// c.eval("wordList <- m_df_1 %>% select(2)");
		c.eval("wordList <- select(m_df_1,2)");
		// ---------------------------------------
		// c.eval("m_df <- m_df %>% select(3,1)");
		c.eval("m_df <- select(m_df,3,1)");
		// c.eval("m_df <- m_df %>% mutate(noun=str_match(value,
		// '([A-Z|a-z|0-9|가-힣]+)/N')[,2]) %>% na.omit");
		c.eval("m_df <- na.omit(mutate(m_df,noun=str_match(value, '([A-Z|a-z|0-9|가-힣]+)/N')[,2]))");
		// c.eval("m_df <- m_df %>% count(noun, sort = TRUE)");
		c.eval("m_df <- count(m_df,noun, sort=TRUE)");
		c.eval("m_df <- filter(m_df,nchar(noun)>=2)");
		c.eval("m_df <- filter(m_df,n>=2)");
		log.info("형태소분석 끝");

		// ---------------------------------------
		log.info("오피니언마이닝 시작");
		c.eval("wordList <- unlist(wordList)");
		c.eval("posM = match(wordList,positive)");
		c.eval("posM = !is.na(posM)");
		c.eval("negM = match(wordList,negative)");
		c.eval("negM = !is.na(negM)");
		log.info("오피니언마이닝 끝");

		REXP pos = c.eval("sum(posM)");
		REXP neg = c.eval("sum(negM)");
		// ---------------------------------------

		REXP x = c.eval("m_df$noun");
		REXP y = c.eval("m_df$n");

		log.info("모든 기사 내용 분석 끝");

		String[] xArr = x.asStrings();
		String[] yArr = y.asStrings();

		int posCnt = pos.asInteger();
		int negCnt = neg.asInteger();

		pDTO.setNegCnt(negCnt);
		pDTO.setPosCnt(posCnt);
		pList.add(pDTO);
		pDTO = null;

		log.info("-----posCnt : " + posCnt);
		log.info("-----negCnt : " + negCnt);

		for (int i = 0; i < xArr.length; i++) {
			/* System.out.println("noun : " + xArr[i] + " | cnt : " + yArr[i]); */
			pDTO = new DataDTO();
			pDTO.setWord(xArr[i]);
			pDTO.setCnt(Integer.parseInt(yArr[i]));
			pList.add(pDTO);
			pDTO = null;
		}
		c.close();
		/**
		 * 이곳에서 몽고DB에 값집어넣기 user_id값 받아온것, 긍정정도 퍼센트 0~100사잇값 posCnt/(negCnt+posCnt)*100
		 * 부정정도 퍼센트는 100에서 긍정정도 빼기 시간 DateUtil사용 yyyy-MM-dd HH:mm:ss, 키워드 새로 함수에서 받아와야
		 * 할것 : 키워드, user_id
		 */
		if (posCnt == 0) {
			posCnt = 1;
		}
		if (negCnt == 0) {
			negCnt = 1;
		}
		Double posPer = ((double) posCnt / (posCnt + negCnt)) * 100;
		MongoDataDTO mDTO = new MongoDataDTO();
		mDTO.setCollect_time(DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss"));
		mDTO.setKeyword(keyword);
		mDTO.setPosPer(posPer);
		log.info("user_id : " + user_id);
		mDTO.setUser_id(user_id);

		mongoMapper.insertData(mDTO, "newsKeywordPosper");

		return pList;
	}

}