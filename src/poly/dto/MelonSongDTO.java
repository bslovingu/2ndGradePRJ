package poly.dto;

//MongoDB에 저장

public class MelonSongDTO {
	private String song;
	private String rank;

	public String getSong() {
		return song;
	}

	public void setSong(String song) {
		this.song = song;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}
}