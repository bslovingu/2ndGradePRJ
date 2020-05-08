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
		 * cgv에서 iframe값 가지고 올 수 있는지 확인하기 
		 * url은 북마크에 저장됨
		 */
		String url = "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=%EB%82%A0%EC%94%A8";
		Document doc = null;
		doc = Jsoup.connect(url).get();
		Elements element = doc.select("div._weeklyWeather");

		Iterator<Element> day_info = element.select("span.day_info").iterator();
		Iterator<Element> morning_rain = element.select("span.morning span.rain_rate span.num").iterator();
		Iterator<Element> afternoon_rain = element.select("span.afternoon span.rain_rate span.num").iterator();
		Iterator<Element> high_temp = element.select("dl dd span:first-child").iterator();
		Iterator<Element> low_temp = element.select("dl dd span:nth-child(3)").iterator();

		TestDTO pDTO = null;

		while (day_info.hasNext()) {
			pDTO = new TestDTO();
			pDTO.setMovie_check_time(DateUtil.getDateTime("yyyyMMdd"));
			pDTO.setMovie_title(CmmUtil.nvl(day_info.next().text()).trim());
			pDTO.setMovie_theater(CmmUtil.nvl(morning_rain.next().text()).trim());
			pDTO.setMovie_dimension(CmmUtil.nvl(afternoon_rain.next().text()).trim());
			pDTO.setMovie_time(CmmUtil.nvl(high_temp.next().text()).trim());
			pDTO.setMovie_percent(CmmUtil.nvl(low_temp.next().text()).trim());
			pDTO.setReg_id("admin");
			res += mysqlTestMapper.InsertTestInfo(pDTO);
		}
		log.info(this.getClass().getName() + ".getTestInfoFromWEB end!");

		return res;
	}

}
