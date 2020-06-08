package poly.dto;

import java.util.ArrayList;
import java.util.List;

public class SearchDTO {

	private List<String> keyword = new ArrayList<String>();

	public List<String> getKeyword() {
		return keyword;
	}

	public void setKeyword(List<String> keyword) {
		this.keyword = keyword;
	}

}
