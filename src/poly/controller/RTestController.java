package poly.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RTestController {
	// Rtest
	@RequestMapping(value = "rtest")
	@ResponseBody
	public String rtest(HttpServletRequest request, Model model, HttpSession session)
			throws RserveException, REXPMismatchException {
		RConnection connection = new RConnection();
		connection.eval("library(devtools)");
		connection.eval("library(RCurl)");
		connection.eval("library(d3Network)");
		connection.eval(
				"name <- c('한글','Jessica Lange','Winona Ryder','Michelle Pfeiffer','Whoopi Goldberg','Emma Thompson',"
						+ "'Julia Roberts','Sharon Stone','Meryl Streep', 'Susan Sarandon','Nicole Kidman')");
		connection.eval(
				"pemp <- c('한글','한글','Jessica Lange','Winona Ryder','Winona Ryder','Angela Bassett','Emma Thompson', "
						+ "'Julia Roberts','Angela Bassett', 'Meryl Streep','Susan Sarandon')");
		connection.eval("emp <- data.frame(이름=name,상사이름=pemp)");
		connection.eval("d3SimpleNetwork(emp,width=600,height=600,file='test02.jsp')");
		connection.close();

		/*
		 * model.addAttribute("msg", "R파일 생성, 호출."); model.addAttribute("url",
		 * "/result.do");
		 */

		return null;
	}
}