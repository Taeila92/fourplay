package dao;

import static db.JdbcUtil.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;

public class OrdDao {
	private static OrdDao ordDao;
	private Connection conn;
	private OrdDao() {}
	public static OrdDao getInstance() {
		if (ordDao == null) {
			ordDao = new OrdDao();
		}
		return ordDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<CartInfo> getOrdFrmPdtList(String kind, String where) {
	// 장바구니나 바로구매를 통해 결제하려는 사용자에게 보여줄 상품목록을 리턴하는 메소드
		ArrayList<CartInfo> pdtList = new ArrayList<CartInfo>();
		Statement stmt = null;
		ResultSet rs = null;

		try {
			String sql = "";
			if (kind.equals("cart")) {	// 장바구니를 통한 구매일 경우
				sql = "select c.cl_idx, p.pl_id, p.pl_name, p.pl_img1, p.pl_opt, c.cl_opt, " + 
				" c.cl_cnt, p.pl_price, p.pl_discount from t_cart_list c, t_product_list p " + 
				" where c.pl_id = p.pl_id and p.pl_view = 'y' " + where + 
				" order by p.pl_id, c.cl_opt ";
				System.out.println(sql);
			} else {	// 바로 구매를 통한 구매일 경우
				
			}
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				CartInfo cart = new CartInfo();
				if (kind.equals("cart")) {	// 장바구니를 통한 구매일 경우
					cart.setCl_idx(rs.getInt("cl_idx"));
					cart.setCl_opt(rs.getString("cl_opt"));
					cart.setCl_cnt(rs.getInt("cl_cnt"));
				} else {	// 바로 구매를 통한 구매일 경우
					
				}
				cart.setPl_id(rs.getString("pl_id"));
				cart.setPl_name(rs.getString("pl_name"));
				cart.setPl_img1(rs.getString("pl_img1"));
				cart.setPl_opt(rs.getString("pl_opt"));
				cart.setPl_price(rs.getInt("pl_price"));
				int price = rs.getInt("pl_price");
				if (rs.getInt("pl_discount") > 0) {
					float rate = (float)rs.getInt("pl_discount") / 100;
					price = Math.round(price - (price * rate));
				}	// 상품가격은 할인율이 있을 경우 할인율을 적용한 가격으로 저장함
				cart.setPrice(price);
				pdtList.add(cart);
			}
		} catch(Exception e) {
			System.out.println("getOrdFrmPdtList() 오류");		e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return pdtList;
	}
	
//	public MemberInfo getaddr(String uid) {	//로그인한 회원의 기본 배송지가 있으면 가져오는 메소드
//		MemberInfo addrInfo = new MemberInfo();
//		Statement stmt = null;
//		ResultSet rs = null;
//		
//		try {
//			String sql = "select * from t_member_addr where ml_id = '" + uid + "' and ma_basic = 'y' ";
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(sql);
//			
//			if(rs.next()) {
//				addrInfo.setMaaddr1(rs.getString("ma_addr1"));
//				addrInfo.setMaaddr2(rs.getString("ma_addr2"));
//				addrInfo.setMazip(rs.getString("ma_zip"));
//				addrInfo.setMlid(rs.getString("ml_id"));
//			}
//		} catch(Exception e) {
//			System.out.println("getaddr() 오류");		e.printStackTrace();
//		} finally {
//			close(rs);	close(stmt);
//		}
//		return addrInfo;
//	}
	
	public int getOrdCount(String buyer) {	// 한 회원의 총 주문개수를 가져오는 메소드
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_order_list where ol_buyer = '" + buyer + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getOrdCount() 오류");			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return rcnt;
	}
	
	public ArrayList<OrdListInfo> getOrdList(String buyer, int cpage, int psize){	// 한 회원의 총 주문내역을 가져오는 메소드
		ArrayList<OrdListInfo> ordList = new ArrayList<OrdListInfo>();
		ArrayList<OrdDetailInfo> ordDetailList = new ArrayList<OrdDetailInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		OrdListInfo ordListInfo = null;
		int snum = (cpage -1) * psize; // 쿼리의 limit 명령에서 데이터를 가져올 시작 인덱스 번호
		
		try {
			String sql = "select * from t_order_list where ol_ismember = 'y' and ol_buyer = '" + buyer 
					+ "' group by ol_id order by ol_date desc limit "+ snum + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ordListInfo = new OrdListInfo();
				ordListInfo.setOl_id(rs.getString("ol_id"));
				ordListInfo.setOl_buyer(rs.getString("ol_buyer"));
				ordListInfo.setOl_bname(rs.getString("ol_bname"));
				ordListInfo.setOl_bname(rs.getString("ol_bname"));
				ordListInfo.setOl_bphone(rs.getString("ol_bphone"));
				ordListInfo.setOl_bmail(rs.getString("ol_bmail"));
				ordListInfo.setOl_rname(rs.getString("ol_rname"));
				ordListInfo.setOl_rphone(rs.getString("ol_rphone"));
				ordListInfo.setOl_rzip(rs.getString("ol_rzip"));
				ordListInfo.setOl_raddr1(rs.getString("ol_raddr1"));
				ordListInfo.setOl_raddr2(rs.getString("ol_raddr2"));
				ordListInfo.setOl_comment(rs.getString("ol_comment"));
				ordListInfo.setOl_payment(rs.getString("ol_payment"));
				ordListInfo.setOl_status(rs.getString("ol_status"));
				ordListInfo.setOl_date(rs.getString("ol_date"));
				ordListInfo.setOl_usepnt(rs.getInt("ol_usepnt"));
				ordListInfo.setOl_savepnt(rs.getInt("ol_savepnt"));
				ordListInfo.setOl_pay(rs.getInt("ol_pay"));
				
				ordDetailList = getOrdDetailList(rs.getString("ol_id"));
				
				ordListInfo.setOrdDetailList(ordDetailList);
				ordList.add(ordListInfo);
			}
		} catch(Exception e) {
			System.out.println("getOrdList() 오류");			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return ordList;
	}
	
	public ArrayList<OrdDetailInfo> getOrdDetailList(String olid){	//하나의 주문에 속한 여러 상세내역을 가져오는 메소드
		ArrayList<OrdDetailInfo> ordDetailList = new ArrayList<OrdDetailInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		OrdDetailInfo ordDetailInfo = null;
		
		try {
			String sql = "select * from t_order_detail a, t_product_list b where a.pl_id = b.pl_id and ol_id = '" + olid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ordDetailInfo = new OrdDetailInfo();
				ordDetailInfo.setOl_id(rs.getString("ol_id"));
				ordDetailInfo.setPl_id(rs.getString("pl_id"));
				ordDetailInfo.setPl_name(rs.getString("pl_name"));
				ordDetailInfo.setPl_img1(rs.getString("pl_img1"));
				ordDetailInfo.setOd_opt(rs.getString("od_opt"));
				ordDetailInfo.setOd_idx(rs.getInt("od_idx"));
				ordDetailInfo.setOd_cnt(rs.getInt("od_cnt"));
				ordDetailInfo.setOd_price(rs.getInt("od_price"));
				ordDetailInfo.setOd_status(rs.getString("od_status"));
				ordDetailList.add(ordDetailInfo);
			}
		} catch(Exception e) {
			System.out.println("getOrdDetailList() 오류");			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return ordDetailList;
	}
	
	public boolean chkNonOrd(String olid, String bname) {	// 입력한 정보에 해당하는 비회원 주문이 있는지를 검사하는 메소드
		boolean isSuccess = false;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_order_list where ol_ismember = 'n' and ol_bname = '" + bname 
					+ "' and ol_id = '" + olid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next())		isSuccess = true;
			System.out.println(isSuccess);
		} catch(Exception e) {
			System.out.println("chkNonOrd() 오류");			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return isSuccess;
	}
	
	public OrdListInfo getOrd(String olid, String where) {		//하나의 주문내역을 가져오는 메소드
		OrdListInfo ordInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrdDetailInfo> ordDetailList = new ArrayList<OrdDetailInfo>();
		
		try {
			String sql = "select * from t_order_list where ol_id = '" + olid + "' " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				ordInfo = new OrdListInfo();
				ordInfo.setOl_id(olid);
				ordInfo.setOl_buyer(rs.getString("ol_buyer"));
				ordInfo.setOl_bname(rs.getString("ol_bname"));
				ordInfo.setOl_bname(rs.getString("ol_bname"));
				ordInfo.setOl_bphone(rs.getString("ol_bphone"));
				ordInfo.setOl_bmail(rs.getString("ol_bmail"));
				ordInfo.setOl_rname(rs.getString("ol_rname"));
				ordInfo.setOl_rphone(rs.getString("ol_rphone"));
				ordInfo.setOl_rzip(rs.getString("ol_rzip"));
				ordInfo.setOl_raddr1(rs.getString("ol_raddr1"));
				ordInfo.setOl_raddr2(rs.getString("ol_raddr2"));
				ordInfo.setOl_comment(rs.getString("ol_comment"));
				ordInfo.setOl_payment(rs.getString("ol_payment"));
				ordInfo.setOl_status(rs.getString("ol_status"));
				ordInfo.setOl_date(rs.getString("ol_date"));
				ordInfo.setOl_usepnt(rs.getInt("ol_usepnt"));
				ordInfo.setOl_savepnt(rs.getInt("ol_savepnt"));
				ordInfo.setOl_pay(rs.getInt("ol_pay"));
				
				ordDetailList = getOrdDetailList(olid);
				
				ordInfo.setOrdDetailList(ordDetailList);
			}
		} catch(Exception e) {
			System.out.println("getOrd() 오류");			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return ordInfo;
	}

	public String orderProc(String kind, String[] clIdxs, OrdListInfo ord) {
		String result = "0:";
		Statement stmt = null, stmt2 = null, stmt3 = null, stmt4 = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null, rs2 = null, rs3 = null;

		try {
			stmt = conn.createStatement();
			String where = "";
			for (int i = 0 ; i < clIdxs.length ; i++)	where += " or c.cl_idx = " + clIdxs[i];
			where = " (" + where.substring(4) + ")";
			String sql = "select c.*, if(p.pl_discount > 0, p.pl_price - (p.pl_discount / 100) * p.pl_price, p.pl_price) price " + 
				" from t_cart_list c, t_product_list p where c.pl_id = p.pl_id and " + where + " group by c.cl_idx ";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);	// 쇼핑카트에서 구매하려는 상품의 아이디와 옵션, 수량 등을 추출함
			int tmp = 0;
			
			//주문ID(ex. yymmdd100001)
			
			if (rs.next()) {	//구매하려는 상품이 있으면
				Calendar today = Calendar.getInstance();
				String date = (today.get(Calendar.YEAR) + "").substring(2);
				int m = today.get(Calendar.MONTH) + 1;
				int d = today.get(Calendar.DATE);
				date += (m < 10) ? "0" + m : "" + m;
				sql = "select max(ol_id) from t_order_list where ol_id like '" + date + "%'";
				// 주문번호 생성을 위해 이번달 주문 아이디들 중 가장 나중에 주문한 주문 아이디를 가져옴
				System.out.println(sql);
				date += (d < 10) ? "0" + d : "" + d;
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(sql);
				String olId = date + "100001";
				if (rs2.next() && rs2.getString(1) != null) {	// 이번달 주문이 한 건이라도 있으면
					int id = Integer.parseInt(rs2.getString(1).substring(6)) + 1;
					olId = date + id;	// 새로운 주문번호를 만들어 냄
					System.out.println(olId);
				}
				System.out.println("1");
				sql = "insert into t_order_list (ol_id, ol_ismember, ol_buyer, ol_bname, ol_bphone, ol_bmail, ol_rname, ol_rphone, ol_rzip, ol_raddr1, " + 
					"ol_raddr2, ol_usepnt, ol_savepnt, ol_payment, ol_pay, ol_status) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
				System.out.println(sql);
				String payment = ord.getOl_payment();
				String status = "c";
				if(payment.equals("d"))						status = "a";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, olId);					pstmt.setString(2, ord.getOl_ismember());
				pstmt.setString(3, ord.getOl_buyer());		pstmt.setString(4, ord.getOl_bname());		
				pstmt.setString(5, ord.getOl_bphone());		pstmt.setString(6, ord.getOl_bmail());		
				pstmt.setString(7, ord.getOl_rname());		pstmt.setString(8, ord.getOl_rphone());		
				pstmt.setString(9, ord.getOl_rzip());		pstmt.setString(10, ord.getOl_raddr1());	
				pstmt.setString(11, ord.getOl_raddr2());	pstmt.setInt(12, ord.getOl_usepnt());		
				pstmt.setInt(13, ord.getOl_savepnt());		pstmt.setString(14, payment);	
				pstmt.setInt(15, ord.getOl_pay());			pstmt.setString(16, status);
				tmp = pstmt.executeUpdate();
				if (tmp == 0)	return result;
				// t_order_list에 insert가 정상적으로 동작하지 않았을 경우 롤백을 시키기 위해 강제로 메소드를 종료시킴
				
				stmt3 = conn.createStatement();
				do {	// 장바구니의 구매상품정보를 이용하여 t_product_list(up), t_order_detail(in)
					
					sql = "insert into t_order_detail (ol_id, pl_id, od_cnt, od_opt, od_price, od_status)" + 
							"values ('" + olId + "', '" + rs.getString("pl_id") + "', " + rs.getInt("cl_cnt") + 
							", '" + rs.getString("cl_opt") + "', " + rs.getInt("price") + ", '" + status + "') ";
					System.out.println(sql);
					tmp = stmt3.executeUpdate(sql);
					if (tmp == 0)	return result;
					// 주문 상세정보(상품관련) 추가 쿼리
					
					String size = "";	//옵션이 없으면
					if(!rs.getString("cl_opt").equals("")) {	//옵션이 있는 상품이면
						String[] opt = rs.getString("c.cl_opt").split(",");
						size = " and ps_size = '" + opt[0] + "' ";
					}
					
					sql = "select ps_stock from t_product_size where pl_id ='" + rs.getString("pl_id") + "' " + size;
					stmt4 = conn.createStatement();
					System.out.println(sql);
					rs3 = stmt4.executeQuery(sql);
					
					if(rs3.next()) {
						String stock = ", ps_stock = ps_stock - " + rs.getInt("cl_cnt");
						if (rs3.getInt("ps_stock") == -1)	stock = "";
						sql = "update t_product_size set ps_salecnt = ps_salecnt + " + rs.getInt("cl_cnt") + stock
								+ " where pl_id = '" + rs.getString("pl_id") + "' " + size;
						System.out.println(sql);
						tmp = stmt3.executeUpdate(sql);
						if (tmp == 0)	return result;
						// 주문 수량에 맞춰 판매량과 재고량을 변경하는 쿼리
					}
					
				} while(rs.next());

				if ((ord.getOl_usepnt() > 0 || ord.getOl_savepnt() > 0) && ord.getOl_ismember().equals("y")) {
				// 회원이면서 주문시 사용한 포인트가 있거나 주문에 의해 적립된 포인트가 있는 경우
					int pnt = 0;
					if (ord.getOl_usepnt() > 0) {	// 주문시 사용한 포인트가 있으면
						sql = "insert into t_member_point (ml_id, mp_use, mp_point, mp_detail, mp_order) " + 
						"values ('" + ord.getOl_buyer() + "', 'b', " + ord.getOl_usepnt() + ", '주문시 사용', '" + olId + "')";
						tmp = stmt3.executeUpdate(sql);
						pnt = ord.getOl_usepnt();
					}
					if (ord.getOl_savepnt() > 0) {	// 주문시 포인트가 적립되었다면
						sql = "insert into t_member_point (ml_id, mp_use, mp_point, mp_detail, mp_order) " + 
						"values ('" + ord.getOl_buyer() + "', 'a', " + ord.getOl_savepnt() + ", '주문시 적립', '" + olId + "')";
						tmp = stmt3.executeUpdate(sql);
						pnt = ord.getOl_savepnt();
					}
					System.out.println(sql);
					sql = "update t_member_list set ml_point = ml_point + " + pnt +	" where ml_id = '" + ord.getOl_buyer() + "' ";
					System.out.println(sql);
					tmp = stmt3.executeUpdate(sql);
				}

				sql = "delete from t_cart_list c where " + where;
				System.out.println(sql);
				tmp = stmt3.executeUpdate(sql);
				// 장바구니 내의 목록에서 구매하는 상품들을 삭제
				result = "1:" + olId;
			} else {	// 장바구니에 구매하려는 상품이 없을 경우
				return result;	// 구매를 멈춤
			}
		} catch(Exception e) {
			System.out.println("orderProc() 오류" + e);
		} finally {
			close(rs2);	close(rs);	close(pstmt);	close(stmt);
		}

		return result;
	}	
	 public int ordCancel(String olid) {
	// 사용자가 선택한 상품(들)을 장바구니에서 삭제하는 메소드
		int result = 0, finalResult = 0;;
		Statement stmt = null;

		try {
			String sql = "update t_order_list set ol_status = 'j' where ol_id = '" + olid + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
			if(result > 0) {
				sql = "update t_order_detail set od_status = 'j' where ol_id = '" + olid + "' ";
				finalResult = stmt.executeUpdate(sql);
			}
			
		} catch(Exception e) {
			System.out.println("ordCancel() 오류");		e.printStackTrace();
		} finally {
			close(stmt);
		}

		return finalResult;
	}
}
