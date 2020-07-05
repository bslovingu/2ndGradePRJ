package poly.dto;

import java.util.List;

public class NewsDTO {

	private String keyword;
	private List<String> real_time;
	private List<String> real_con;
	private List<String> real_com;
	private String refine_con;
	private String word;
	private int cnt;
	private int part_com;
	private List<Integer> total_com;

	public int getPart_com() {
		return part_com;
	}

	public void setPart_com(int part_com) {
		this.part_com = part_com;
	}

	public List<Integer> getTotal_com() {
		return total_com;
	}

	public void setTotal_com(List<Integer> total_com) {
		this.total_com = total_com;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public List<String> getReal_com() {
		return real_com;
	}

	public String getRefine_con() {
		return refine_con;
	}

	public void setRefine_con(String refine_con) {
		this.refine_con = refine_con;
	}

	public List<String> getReal_time() {
		return real_time;
	}

	public void setReal_time(List<String> real_time) {
		this.real_time = real_time;
	}

	public void setReal_com(List<String> real_com) {
		this.real_com = real_com;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public List<String> getReal_con() {
		return real_con;
	}

	public void setReal_con(List<String> real_con) {
		this.real_con = real_con;
	}

}
