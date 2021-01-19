package vo;

public class PdtInfo {
	// 하나의 상품 정보를 저장할 클래스
	private String pl_id, pl_name, pl_opt, pl_img1, pl_img2, pl_img3, pl_desc, pl_view, pl_date, ps_size, ps_date, cb_name, cs_name;
	// 상품아이디, 상품명, 상품옵션, 상품이미지1, 상품이미지2, 상품이미지3, 상품설명이미지, 게시여부, 상품등록일, 사이즈, 사이즈 등록일
	private int cs_idx, pl_price, pl_cost, pl_discount, pl_review, al_idx, ps_stock, ps_salecnt;
	// 소분류번호, 가격, 원가, 할인율, 리뷰개수, 관리자번호, 재고량, 판매량
	public String getPl_id() {
		return pl_id;
	}
	public void setPl_id(String pl_id) {
		this.pl_id = pl_id;
	}
	public String getPl_name() {
		return pl_name;
	}
	public void setPl_name(String pl_name) {
		this.pl_name = pl_name;
	}
	public String getPl_opt() {
		return pl_opt;
	}
	public void setPl_opt(String pl_opt) {
		this.pl_opt = pl_opt;
	}
	public String getPl_img1() {
		return pl_img1;
	}
	public void setPl_img1(String pl_img1) {
		this.pl_img1 = pl_img1;
	}
	public String getPl_img2() {
		return pl_img2;
	}
	public void setPl_img2(String pl_img2) {
		this.pl_img2 = pl_img2;
	}
	public String getPl_img3() {
		return pl_img3;
	}
	public void setPl_img3(String pl_img3) {
		this.pl_img3 = pl_img3;
	}
	public String getPl_desc() {
		return pl_desc;
	}
	public void setPl_desc(String pl_desc) {
		this.pl_desc = pl_desc;
	}
	public String getPl_view() {
		return pl_view;
	}
	public void setPl_view(String pl_view) {
		this.pl_view = pl_view;
	}
	public String getPl_date() {
		return pl_date;
	}
	public void setPl_date(String pl_date) {
		this.pl_date = pl_date;
	}
	public String getPs_size() {
		return ps_size;
	}
	public void setPs_size(String ps_size) {
		this.ps_size = ps_size;
	}
	public String getPs_date() {
		return ps_date;
	}
	public void setPs_date(String ps_date) {
		this.ps_date = ps_date;
	}
	public String getCb_name() {
		return cb_name;
	}
	public void setCb_name(String cb_name) {
		this.cb_name = cb_name;
	}
	public String getCs_name() {
		return cs_name;
	}
	public void setCs_name(String cs_name) {
		this.cs_name = cs_name;
	}
	public int getCs_idx() {
		return cs_idx;
	}
	public void setCs_idx(int cs_idx) {
		this.cs_idx = cs_idx;
	}
	public int getPl_price() {
		return pl_price;
	}
	public void setPl_price(int pl_price) {
		this.pl_price = pl_price;
	}
	public int getPl_cost() {
		return pl_cost;
	}
	public void setPl_cost(int pl_cost) {
		this.pl_cost = pl_cost;
	}
	public int getPl_discount() {
		return pl_discount;
	}
	public void setPl_discount(int pl_discount) {
		this.pl_discount = pl_discount;
	}
	public int getPl_review() {
		return pl_review;
	}
	public void setPl_review(int pl_review) {
		this.pl_review = pl_review;
	}
	public int getAl_idx() {
		return al_idx;
	}
	public void setAl_idx(int al_idx) {
		this.al_idx = al_idx;
	}
	public int getPs_stock() {
		return ps_stock;
	}
	public void setPs_stock(int ps_stock) {
		this.ps_stock = ps_stock;
	}
	public int getPs_salecnt() {
		return ps_salecnt;
	}
	public void setPs_salecnt(int ps_salecnt) {
		this.ps_salecnt = ps_salecnt;
	}
	
}
