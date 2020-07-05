package poly.dto;

import java.util.List;

public class DataDTO {

	private String keyword;
	private List<String> real_com;
	private String[] real_time;
	private String word;
	private int cnt;
	private int posCnt;
	private int negCnt;
	private int total;
	private int part;
	private double stat;

	public double getStat() {
		return stat;
	}

	public void setStat(double stat) {
		this.stat = stat;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPart() {
		return part;
	}

	public void setPart(int part) {
		this.part = part;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
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

	public List<String> getReal_com() {
		return real_com;
	}

	public void setReal_com(List<String> real_com) {
		this.real_com = real_com;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String[] getReal_time() {
		return real_time;
	}

	public void setReal_time(String[] real_time) {
		this.real_time = real_time;
	}

	public int getPosCnt() {
		return posCnt;
	}

	public void setPosCnt(int posCnt) {
		this.posCnt = posCnt;
	}

	public int getNegCnt() {
		return negCnt;
	}

	public void setNegCnt(int negCnt) {
		this.negCnt = negCnt;
	}

}