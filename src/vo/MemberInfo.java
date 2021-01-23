package vo;

import java.util.*;

public class MemberInfo {
   private String mlid, mlpwd, mlname, mlgender, mlbirth, mlphone, mlemail, mldate, mllast, mlstatus;
//   private String mazip, maaddr1 ,maaddr2 ,mabasic;
   private String mpuse, mpdetail, mporder, mpdate;
   private int mlpoint, maidx, mppoint;
   
   private ArrayList<AddrInfo> addrList;
   
   public String getMlid() {
      return mlid;
   }
   public void setMlid(String mlid) {
      this.mlid = mlid;
   }
   public String getMlpwd() {
      return mlpwd;
   }
   public void setMlpwd(String mlpwd) {
      this.mlpwd = mlpwd;
   }
   public String getMlname() {
      return mlname;
   }
   public void setMlname(String mlname) {
      this.mlname = mlname;
   }
   public String getMlgender() {
      return mlgender;
   }
   public void setMlgender(String mlgender) {
      this.mlgender = mlgender;
   }
   public String getMlbirth() {
      return mlbirth;
   }
   public void setMlbirth(String mlbirth) {
      this.mlbirth = mlbirth;
   }
   public String getMlphone() {
      return mlphone;
   }
   public void setMlphone(String mlphone) {
      this.mlphone = mlphone;
   }
   public String getMlemail() {
      return mlemail;
   }
   public void setMlemail(String mlemail) {
      this.mlemail = mlemail;
   }
   public String getMldate() {
      return mldate;
   }
   public void setMldate(String mldate) {
      this.mldate = mldate;
   }
   public String getMllast() {
      return mllast;
   }
   public void setMllast(String mllast) {
      this.mllast = mllast;
   }
   public String getMlstatus() {
      return mlstatus;
   }
   public void setMlstatus(String mlstatus) {
      this.mlstatus = mlstatus;
   }
//   public String getMazip() {
//      return mazip;
//   }
//   public void setMazip(String mazip) {
//      this.mazip = mazip;
//   }
//   public String getMaaddr1() {
//      return maaddr1;
//   }
//   public void setMaaddr1(String maaddr1) {
//      this.maaddr1 = maaddr1;
//   }
//   public String getMaaddr2() {
//      return maaddr2;
//   }
//   public void setMaaddr2(String maaddr2) {
//      this.maaddr2 = maaddr2;
//   }
//   public String getMabasic() {
//      return mabasic;
//   }
//   public void setMabasic(String mabasic) {
//      this.mabasic = mabasic;
//   }
   public String getMpuse() {
      return mpuse;
   }
   public void setMpuse(String mpuse) {
      this.mpuse = mpuse;
   }
   public String getMpdetail() {
      return mpdetail;
   }
   public void setMpdetail(String mpdetail) {
      this.mpdetail = mpdetail;
   }
   public String getMporder() {
      return mporder;
   }
   public void setMporder(String mporder) {
      this.mporder = mporder;
   }
   public String getMpdate() {
      return mpdate;
   }
   public void setMpdate(String mpdate) {
      this.mpdate = mpdate;
   }
   public int getMlpoint() {
      return mlpoint;
   }
   public void setMlpoint(int mlpoint) {
      this.mlpoint = mlpoint;
   }
   public int getMaidx() {
      return maidx;
   }
   public void setMaidx(int maidx) {
      this.maidx = maidx;
   }
   public int getMppoint() {
      return mppoint;
   }
   public void setMppoint(int mppoint) {
      this.mppoint = mppoint;
   }
   public ArrayList<AddrInfo> getAddrList() {
      return addrList;
   }
   public void setAddrList(ArrayList<AddrInfo> addrList) {
      this.addrList = addrList;
   }
   
}