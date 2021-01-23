package vo;

import java.util.*;

public class AdminInfo {
	private String al_id, al_pwd, al_name, al_phone, al_email, al_date, al_status, ap_date;
	// ap_date: 관리자 권한 부여일
	private int al_idx, ap_idx, am_idx, ap_pms;
	// 관리자 번호, 관리자 권한 번호, 어드민 메뉴 번호, 권한(1:접근불가,2:읽기전용,3:입력가능,4:수정가능,5:삭제가능)
	private ArrayList<HistoryInfo> htryList = new ArrayList<HistoryInfo>();
	
	public String getAl_id() {
		return al_id;
	}
	public void setAl_id(String al_id) {
		this.al_id = al_id;
	}
	public String getAl_pwd() {
		return al_pwd;
	}
	public void setAl_pwd(String al_pwd) {
		this.al_pwd = al_pwd;
	}
	public String getAl_name() {
		return al_name;
	}
	public void setAl_name(String al_name) {
		this.al_name = al_name;
	}
	public String getAl_phone() {
		return al_phone;
	}
	public void setAl_phone(String al_phone) {
		this.al_phone = al_phone;
	}
	public String getAl_email() {
		return al_email;
	}
	public void setAl_email(String al_email) {
		this.al_email = al_email;
	}
	public String getAl_date() {
		return al_date;
	}
	public void setAl_date(String al_date) {
		this.al_date = al_date;
	}
	public String getAl_status() {
		return al_status;
	}
	public void setAl_status(String al_status) {
		this.al_status = al_status;
	}
	public String getAp_date() {
		return ap_date;
	}
	public void setAp_date(String ap_date) {
		this.ap_date = ap_date;
	}
	public int getAl_idx() {
		return al_idx;
	}
	public void setAl_idx(int al_idx) {
		this.al_idx = al_idx;
	}
	public int getAp_idx() {
		return ap_idx;
	}
	public void setAp_idx(int ap_idx) {
		this.ap_idx = ap_idx;
	}
	public int getAm_idx() {
		return am_idx;
	}
	public void setAm_idx(int am_idx) {
		this.am_idx = am_idx;
	}
	public int getAp_pms() {
		return ap_pms;
	}
	public void setAp_pms(int ap_pms) {
		this.ap_pms = ap_pms;
	}
	public ArrayList<HistoryInfo> getHtryList() {
		return htryList;
	}
	public void setHtryList(ArrayList<HistoryInfo> htryList) {
		this.htryList = htryList;
	}
	
}
