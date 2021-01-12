package vo;

public class CataSmallInfo {
	// 소분류 정보를 저장할 클래스
	private String cs_name, cs_date, cs_view;
	private int cs_idx, cb_idx, al_idx;
	public String getCs_name() {
		return cs_name;
	}
	public void setCs_name(String cs_name) {
		this.cs_name = cs_name;
	}
	public String getCs_date() {
		return cs_date;
	}
	public void setCs_date(String cs_date) {
		this.cs_date = cs_date;
	}
	public String getCs_view() {
		return cs_view;
	}
	public void setCs_view(String cs_view) {
		this.cs_view = cs_view;
	}
	public int getCs_idx() {
		return cs_idx;
	}
	public void setCs_idx(int cs_idx) {
		this.cs_idx = cs_idx;
	}
	public int getCb_idx() {
		return cb_idx;
	}
	public void setCb_idx(int cb_idx) {
		this.cb_idx = cb_idx;
	}
	public int getAl_idx() {
		return al_idx;
	}
	public void setAl_idx(int al_idx) {
		this.al_idx = al_idx;
	}
}
