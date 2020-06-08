package poly.dto;

import java.util.ArrayList;
import java.util.List;

public class RankDTO {
	private List<String> keyword_synonyms = new ArrayList<String>();
	private Long rank;
	private String keyword;

	public List<String> getKeyword_synonyms() {
		return keyword_synonyms;
	}

	public void setKeyword_synonyms(List<String> keyword_synonyms) {
		this.keyword_synonyms = keyword_synonyms;
	}

	public Long getRank() {
		return rank;
	}

	public void setRank(Long rank) {
		this.rank = rank;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

}
