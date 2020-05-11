package poly.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import poly.dto.TestDTO;
import poly.dto.WeatherDTO;
import poly.persistance.redis.IRedisTestMapper;
import poly.persistance.mapper.ITestMapper;
import poly.service.ITestService;
import poly.util.CmmUtil;
import poly.util.DateUtil;

@Service("TestService")
public class TestService implements ITestService {
	// 로그사용
	private Logger log = Logger.getLogger(this.getClass());

	// mysql 접속 위한 맵퍼
	@Resource(name = "mysqlTestMapper")
	private ITestMapper mysqlTestMapper;

	@Resource(name = "TestService")
	private ITestService testService;

	@Resource(name = "redisTestMapper")
	private IRedisTestMapper testMapper;

	@Override
	public List<TestDTO> getTestInfo(TestDTO pDTO) throws Exception {
		log.info(this.getClass().getName() + ".getTestInfo start!");

		List<TestDTO> rList = null;

		String key = "TEST_INFO_" + DateUtil.getDateTime("yyyyMMdd");

		if (testMapper.getExists(key)) {
			rList = testMapper.getTestInfo(key);

			if (rList == null) {
				rList = new ArrayList<TestDTO>();
			}

			testMapper.setTimeOutHour(key, 1);
		} else {
			rList = mysqlTestMapper.getTestInfo(pDTO);

			if (rList == null) {
				rList = new ArrayList<TestDTO>();
			}

			if (rList.size() == 0) {
				testService.getTestInfoFromWEB();

				rList = mysqlTestMapper.getTestInfo(pDTO);

				if (rList == null) {
					rList = new ArrayList<TestDTO>();
				}
			}

			if (rList.size() > 0) {
				testMapper.setTestInfo(key, rList);
				testMapper.setTimeOutHour(key, 1);
			}
		}
		log.info(this.getClass().getName() + ".getTestInfo end!");
		return rList;
	}

	// 크롤링 하고 정보 넣기
	@Override
	public int getTestInfoFromWEB() throws Exception {
		log.info(this.getClass().getName() + ".getTestInfoFromWEB start!");
		int res = 0;

		/*
		 * cgv에서 iframe값 가지고 올 수 있는지 확인하기 url은 북마크에 저장됨
		 */
		String date = DateUtil.getDateTime("yyyyMMdd");
		String url = "http://www.cgv.co.kr/common/showtimes/iframeMovie.aspx?midx=83217&mcode=&areacode=09&date="
				+ date;
		Document doc = null;
		doc = Jsoup.connect(url).get();
		Elements divElement = doc.select("div.sect-showtimes");
		Elements hrefElement = doc.select("a[href]");
		Elements dimensionElement = doc.select("div.info-hall");
		Elements timeElement = doc.select("div.info-timetable");

		Iterator<Element> movie_title = divElement.select("div.col-theater").iterator();
		Iterator<Element> movie_theater = divElement.select("div.col-theater").iterator();
		/*
		 * 영화관 하나당 여러개의 시간대에 잡혀야되는데 1대1 매칭되는 것 해결법 찾기(형이 보내준 사이트 크롤링하면 해결)
		 * 영화 코드 알아내서 url로 지정하는 법 찾기
		 * iframe 이여서 url일일히 찍어서 크롤링 해야하는데 단순 반복문으로 해결법 찾기
		 */
		Iterator<Element> movie_dimension = dimensionElement.select("ul li:first-child").iterator();
		Iterator<Element> movie_time = timeElement.select("em").iterator();
		Iterator<Element> movie_percent = hrefElement.select("span.txt-lightblue").iterator();

		TestDTO pDTO = null;

		while (movie_title.hasNext()) {
			pDTO = new TestDTO();
			pDTO.setMovie_check_time(DateUtil.getDateTime("yyyyMMdd"));
			pDTO.setMovie_title(CmmUtil.nvl(movie_title.next().text()).trim());
			pDTO.setMovie_theater(CmmUtil.nvl(movie_theater.next().text()).trim());
			pDTO.setMovie_dimension(CmmUtil.nvl(movie_dimension.next().text()).trim());
			pDTO.setMovie_time(CmmUtil.nvl(movie_time.next().text()).trim());
			pDTO.setMovie_percent(CmmUtil.nvl(movie_percent.next().text()).trim());
			pDTO.setReg_id("admin");
			res += mysqlTestMapper.InsertTestInfo(pDTO);
		}
		log.info(this.getClass().getName() + ".getTestInfoFromWEB end!");

		return res;
	}

}
