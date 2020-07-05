package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.DataDTO;
import poly.dto.NewsDTO;
import poly.dto.RankDTO;
import poly.dto.ValueDTO;
import poly.service.INaverNewsService;
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

	@Resource(name = "NaverNewsService")
	private INaverNewsService naverNewsService;

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

	@RequestMapping(value = "test/testingPage")
	public String result1(HttpServletRequest request, Model model, HttpSession session) throws Exception {

		return "/test/testingPage";

	}

	@RequestMapping(value = "test/finalPage")
	public String result2(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		String userId = CmmUtil.nvl((String)session.getAttribute("userId"));
		if(userId.equals("")) {
			model.addAttribute("msg","로그인이 필요한 서비스입니다.");
			model.addAttribute("url", "/main_login.do");
			return "/redirect";
		}
		return "/test/finalPage";

	}
	
	// r 라이브러리 호출
	@RequestMapping(value = "rConnection")
	@ResponseBody
	public String rConnection(HttpServletRequest request, HttpServletResponse response) throws Exception {

		log.info(this.getClass().getName() + "rConnection start!");
		RConnection c = new RConnection();
		c.eval("library(tidyverse)");
		c.eval("library(KoNLP)");
		c.eval("useNIADic()");
		c.eval("library(stringr)");
		c.eval("library(reshape2)");
		c.eval("library(dplyr)");
		c.eval("negative <- readLines('C:\\\\emoDic\\\\negDic.txt', encoding='UTF-8')");
		c.eval("positive <- readLines('C:\\\\emoDic\\\\posDic.txt', encoding='UTF-8')");

		c.close();

		log.info(this.getClass().getName() + "rConnection end!");

		return "success";
	}

	@RequestMapping(value = "cssTestPage")
	public String cssTestPage(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + " cssTestPage start!");
		log.info(this.getClass().getName() + " cssTestPage end!");
		return "/test/finalPage";

	}

	@RequestMapping(value = "cssTest", method = RequestMethod.POST)
	@ResponseBody
	public List<RankDTO> css(@RequestBody ValueDTO valueDto, Model model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + " css start!");
		List<RankDTO> rList = naverRankService.collectNaverRank(valueDto);
		if (rList == null) {
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

		if (rList == null) {
			rList = new ArrayList<String>();
		}

		log.info(this.getClass().getName() + " relTest end!");
		return rList;

	}

	@RequestMapping(value = "infoTest", method = RequestMethod.POST)
	@ResponseBody
	public List<DataDTO> infoTest(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + " infoTest start!");

		String keyword = CmmUtil.nvl(request.getParameter("keyword"));
		
		//session 에서 Id값 받기
		String user_id = CmmUtil.nvl((String)session.getAttribute("userId"));
		
		log.info("뉴스 정보 가져오기 시작 CCCCCCCCCCCCCCCC");
		List<NewsDTO> rList = new ArrayList<NewsDTO>();
		rList = naverNewsService.collectNaverNews(keyword);
		log.info("뉴스 정보 가져오기 끝 CCCCCCCCCCCCCCCC");
		if (rList == null) {
			rList = new ArrayList<NewsDTO>();
		}
		log.info("뉴스 정보 분석 시작 AAAAAAAAAAAAAAAAAA");
		List<DataDTO> pList = new ArrayList<DataDTO>();
		pList = naverNewsService.analysisData(rList,user_id,keyword);
		log.info("뉴스 정보 분석 끝 AAAAAAAAAAAAAAAAAA");
		log.info(this.getClass().getName() + " infoTest end!");
		return pList;

	}
}
