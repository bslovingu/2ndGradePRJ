package poly.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.RankDTO;
import poly.dto.ValueDTO;
import poly.service.INaverRankService;
import poly.service.IWeatherService;
import poly.util.CmmUtil;

@Controller
public class MainController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "WeatherService")
	private IWeatherService weatherService;

	@Resource(name = "NaverRankService")
	private INaverRankService naverRankService;

	// TTS페이지
	@RequestMapping(value = "index")
	public String index(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		weatherService.getWeatherInfoFromWEB();
		return "/index";

	}

	// TTS페이지
	@RequestMapping(value = "TTS")
	public String TTS(HttpServletRequest request, Model model, HttpSession session) {

		return "/TTS";
	}

	@RequestMapping(value = "googleTest")
	public String result(HttpServletRequest request, Model model, HttpSession session) throws Exception {

		return "/googleTest";

	}

	@RequestMapping(value = "cssTestPage")
	public String cssTestPage(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + " cssTestPage start!");
		log.info(this.getClass().getName() + " cssTestPage end!");
		return "/test/naverMainTest";

	}

	@RequestMapping(value = "cssTest", method = RequestMethod.POST)
	@ResponseBody
	public List<RankDTO> css(@RequestBody ValueDTO valueDto, Model model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + " css start!");
		List<RankDTO> rList = naverRankService.collectNaverRank(valueDto);
		if(rList==null) {
			rList = new ArrayList<RankDTO>();
		}
		log.info(this.getClass().getName() + " css end!");
		return rList;

	}
	@RequestMapping(value = "relTest", method = RequestMethod.POST)
	@ResponseBody
	public List<String> relTest(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + " relTest start!");
		
		String keyword = CmmUtil.nvl(request.getParameter("keyword"));
		
		List<String> rList = new ArrayList<String>();
		rList = naverRankService.getRelKeyword(keyword);
		
		if(rList==null) {
			rList = new ArrayList<String>();
		}
		
		log.info(this.getClass().getName() + " relTest end!");
		return rList;

	}
}
