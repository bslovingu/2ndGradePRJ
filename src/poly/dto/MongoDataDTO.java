package poly.dto;

public class MongoDataDTO {
	private String user_id;
	private double posPer;
	private String collect_time;
	private String keyword;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public double getPosPer() {
		return posPer;
	}
	public void setPosPer(double posPer) {
		this.posPer = posPer;
	}
	public String getCollect_time() {
		return collect_time;
	}
	public void setCollect_time(String collect_time) {
		this.collect_time = collect_time;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
}
