package admin.controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import admin.svc.*;

@WebServlet("/dupAID")
public class DupAID extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DupAID() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String aid = request.getParameter("aid");
		try {
			DupAIDSvc dupAIDSvc = new DupAIDSvc();
			int chkPoint = dupAIDSvc.chkDupAID(aid);
			out.println(chkPoint);
		} catch (Exception e) {
			e.printStackTrace();
			out.println(1);
		}
	}
}
