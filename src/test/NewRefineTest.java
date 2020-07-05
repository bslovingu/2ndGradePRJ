package test;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.Rserve.RConnection;

public class NewRefineTest {

	public static void main(String[] args) throws REngineException, REXPMismatchException {
		// TODO Auto-generated method stub

		RConnection c = new RConnection();

		/* String[] title = new String[rList.size()]; */
		/* for (int i = 0; i < rList.size(); i++) { */
		String info = "수학, 과목, 영어, 영어, 영어, 물리/화학 어려운 과목들 문과, 이과, 문과? 공대 군대, 군대! ";
		String[] sArr = new String[5];

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
		}

	}

}
