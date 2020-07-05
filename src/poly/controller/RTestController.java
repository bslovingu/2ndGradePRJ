package poly.controller;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.json.simple.JSONObject;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.DataDTO;
import poly.service.IUserService;

@Controller
public class RTestController {
	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name = "UserService")
	private IUserService userService;

	@RequestMapping(value = "rtestPg")
	@ResponseBody
	public String melonTOp100(HttpServletRequest request, HttpServletResponse response) throws Exception {
		RConnection c = new RConnection();
		REXP pos = c.eval("positive");
		String[] pArr = pos.asStrings();

		List<String> rList = new ArrayList<String>();
		String json;
		String seq;
		for (int i = 0; i < 472; i++) {
			if (!pArr[i].equals("")) {
				JSONObject wordInfo = new JSONObject();
				wordInfo.put("word_seq", i);
				wordInfo.put("word", pArr[i]);
				json=wordInfo.toJSONString();
				
				System.out.println(json + ", ");
			}
		}
		
		/*
		 * for (int i = 3000; i < pArr.length; i++) { if (!pArr[i].equals("")) { JSONObject
		 * wordInfo = new JSONObject(); wordInfo.put("word", pArr[i]);
		 * 
		 * json=wordInfo.toJSONString();
		 * 
		 * System.out.println(json+ ", "); } }
		 */
		
		return null;
	}

	// Rtest
	@RequestMapping(value = "rtest")
	@ResponseBody
	public List<DataDTO> rtest(HttpServletRequest request, Model model, HttpSession session)
			throws REXPMismatchException, REngineException {
		RConnection c = new RConnection();

		/* String[] title = new String[rList.size()]; */
		/* for (int i = 0; i < rList.size(); i++) { */
		String info = "수학, 과목, 영어, 물리/화학 어려운 과목들 문과, 이과? 공대 군대 ";
		String[] sArr = new String[5];
		List<DataDTO> rList = new ArrayList<DataDTO>();

		for (int i = 0; i < sArr.length; i++) {
			String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
			sArr[i] = info.replaceAll(match, " ").toLowerCase();
		}

		/* } */
		c.assign("title", sArr); // 형태소 분석
		c.eval("m_df <- title %>% SimplePos09 %>% melt %>% as_tibble %>% select(3,1)");
		c.eval("m_df <- m_df %>% mutate(noun=str_match(value, '([A-Z|a-z|0-9|가-힣]+)/N')[,2]) %>% na.omit");
		c.eval("m_df <- m_df %>% count(noun, sort = TRUE)");

		c.eval("m_df <- filter(m_df,nchar(noun)>=2)");
		c.eval("m_df <- filter(m_df,n>=2)");

		// 형태소 분석 결과 몽고DB에 넣기
		REXP x = c.eval("m_df$noun");
		REXP y = c.eval("m_df$n");
		String[] xArr = x.asStrings();
		String[] yArr = y.asStrings();
		for (int i = 0; i < xArr.length; i++) {
			System.out.println("noun : " + xArr[i] + " | cnt : " + yArr[i]);
			DataDTO pDTO = new DataDTO();
			pDTO.setWord(xArr[i]);
			pDTO.setCnt(Integer.parseInt(yArr[i]));
			rList.add(pDTO);
			pDTO = null;
		}
		return rList;
	}
}