package vo;

public class ReviewPageInfo {
	private int rCpage, rPcnt, rSpage, rEpage, rCnt, rBsize, rPsize;
	// 현재 page번호, page수, 시작page, 종료page, 게시글수, 블록크기, page크기

	public int getrCpage() {
		return rCpage;
	}
	public void setrCpage(int rCpage) {
		this.rCpage = rCpage;
	}
	public int getrPcnt() {
		return rPcnt;
	}
	public void setrPcnt(int rPcnt) {
		this.rPcnt = rPcnt;
	}
	public int getrSpage() {
		return rSpage;
	}
	public void setrSpage(int rSpage) {
		this.rSpage = rSpage;
	}

	public int getrEpage() {
		return rEpage;
	}

	public void setrEpage(int rEpage) {
		this.rEpage = rEpage;
	}

	public int getrCnt() {
		return rCnt;
	}

	public void setrCnt(int rCnt) {
		this.rCnt = rCnt;
	}

	public int getrBsize() {
		return rBsize;
	}

	public void setrBsize(int rBsize) {
		this.rBsize = rBsize;
	}

	public int getrPsize() {
		return rPsize;
	}

	public void setrPsize(int rPsize) {
		this.rPsize = rPsize;
	}
	
	
}
