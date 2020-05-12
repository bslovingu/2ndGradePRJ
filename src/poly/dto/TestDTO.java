package poly.dto;

//RedisDB에 저장

public class TestDTO {

	private String movie_check_time;
	private String movie_seq;
	private String movie_title;
	private String movie_theater;
	private String movie_dimension;
	private String movie_time;
	private String movie_percent;
	private String reg_id;
	private String reg_dt;
	private String chg_id;
	private String chg_dt;
	
	public String getMovie_check_time() {
		return movie_check_time;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getChg_id() {
		return chg_id;
	}
	public void setChg_id(String chg_id) {
		this.chg_id = chg_id;
	}
	public String getChg_dt() {
		return chg_dt;
	}
	public void setChg_dt(String chg_dt) {
		this.chg_dt = chg_dt;
	}
	public void setMovie_check_time(String movie_check_time) {
		this.movie_check_time = movie_check_time;
	}
	public String getMovie_seq() {
		return movie_seq;
	}
	public void setMovie_seq(String movie_seq) {
		this.movie_seq = movie_seq;
	}
	public String getMovie_title() {
		return movie_title;
	}
	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}
	public String getMovie_theater() {
		return movie_theater;
	}
	public void setMovie_theater(String movie_theater) {
		this.movie_theater = movie_theater;
	}
	public String getMovie_dimension() {
		return movie_dimension;
	}
	public void setMovie_dimension(String movie_dimension) {
		this.movie_dimension = movie_dimension;
	}
	public String getMovie_time() {
		return movie_time;
	}
	public void setMovie_time(String movie_time) {
		this.movie_time = movie_time;
	}
	public String getMovie_percent() {
		return movie_percent;
	}
	public void setMovie_percent(String movie_percent) {
		this.movie_percent = movie_percent;
	}

	

}
