package vo;

import vo.*;
import java.util.*;

public class OrdListInfo {
	private String ol_id, ol_buyer, ol_bname, ol_bphone, ol_bmail, ol_rname, ol_rphone, ol_rzip, ol_raddr1, ol_raddr2, 
	ol_comment, ol_payment, ol_status, ol_date;
	private int ol_usepnt, ol_savepnt, ol_pay;
	
	private ArrayList<OrdDetailInfo> ordDetailList = new ArrayList<OrdDetailInfo>();

	public String getOl_id() {
		return ol_id;
	}

	public void setOl_id(String ol_id) {
		this.ol_id = ol_id;
	}

	public String getOl_buyer() {
		return ol_buyer;
	}

	public void setOl_buyer(String ol_buyer) {
		this.ol_buyer = ol_buyer;
	}

	public String getOl_bname() {
		return ol_bname;
	}

	public void setOl_bname(String ol_bname) {
		this.ol_bname = ol_bname;
	}

	public String getOl_bphone() {
		return ol_bphone;
	}

	public void setOl_bphone(String ol_bphone) {
		this.ol_bphone = ol_bphone;
	}

	public String getOl_bmail() {
		return ol_bmail;
	}

	public void setOl_bmail(String ol_bmail) {
		this.ol_bmail = ol_bmail;
	}

	public String getOl_rname() {
		return ol_rname;
	}

	public void setOl_rname(String ol_rname) {
		this.ol_rname = ol_rname;
	}

	public String getOl_rphone() {
		return ol_rphone;
	}

	public void setOl_rphone(String ol_rphone) {
		this.ol_rphone = ol_rphone;
	}

	public String getOl_rzip() {
		return ol_rzip;
	}

	public void setOl_rzip(String ol_rzip) {
		this.ol_rzip = ol_rzip;
	}

	public String getOl_raddr1() {
		return ol_raddr1;
	}

	public void setOl_raddr1(String ol_raddr1) {
		this.ol_raddr1 = ol_raddr1;
	}

	public String getOl_raddr2() {
		return ol_raddr2;
	}

	public void setOl_raddr2(String ol_raddr2) {
		this.ol_raddr2 = ol_raddr2;
	}

	public String getOl_comment() {
		return ol_comment;
	}

	public void setOl_comment(String ol_comment) {
		this.ol_comment = ol_comment;
	}

	public String getOl_payment() {
		return ol_payment;
	}

	public void setOl_payment(String ol_payment) {
		this.ol_payment = ol_payment;
	}

	public String getOl_status() {
		return ol_status;
	}

	public void setOl_status(String ol_status) {
		this.ol_status = ol_status;
	}

	public String getOl_date() {
		return ol_date;
	}

	public void setOl_date(String ol_date) {
		this.ol_date = ol_date;
	}

	public int getOl_usepnt() {
		return ol_usepnt;
	}

	public void setOl_usepnt(int ol_usepnt) {
		this.ol_usepnt = ol_usepnt;
	}

	public int getOl_savepnt() {
		return ol_savepnt;
	}

	public void setOl_savepnt(int ol_savepnt) {
		this.ol_savepnt = ol_savepnt;
	}

	public int getOl_pay() {
		return ol_pay;
	}

	public void setOl_pay(int ol_pay) {
		this.ol_pay = ol_pay;
	}

	public ArrayList<OrdDetailInfo> getOrdDetailList() {
		return ordDetailList;
	}

	public void setOrdDetailList(ArrayList<OrdDetailInfo> ordDetailList) {
		this.ordDetailList = ordDetailList;
	}
	
}

