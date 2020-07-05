package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.TestDTO;
import poly.service.ITestService;
import poly.service.impl.TestService;
import poly.util.CmmUtil;
import poly.util.DateUtil;

@Controller
public class TestController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "TestService")
	private ITestService testService;

	// 영화순위 가져오기
	@RequestMapping(value = "test/info")
	@ResponseBody
	public List<TestDTO> test(HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info(this.getClass().getName() + ".test start!");

		List<TestDTO> rList = null;

		TestDTO pDTO = new TestDTO();
		pDTO.setMovie_check_time(DateUtil.getDateTime("yyyyMMdd"));
		rList = testService.getTestInfo(pDTO);

		if (rList == null) {
			rList = new ArrayList<TestDTO>();
		}

		log.info(this.getClass().getName() + ".test end!");
		return rList;
	}

}