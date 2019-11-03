package com.cbdts.mgrservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbdts.commons.DBManager;
import com.cbdts.commons.DataManager;
import com.cbdts.commons.IOManager;

/**
 * 轮播管理服务
 * Servlet implementation class Carousel
 */
public class Carousel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 轮播管理初始化
     * @see HttpServlet#HttpServlet()
     */
    public Carousel() {
        super();
    }

	/**
	 * 轮播管理服务GET
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 轮播管理服务POST
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String act = request.getParameter("act");
		String sql = "";
		int row = -1;
		String rel = "";
		
		if (act.equals("del")) {
			String cslid = request.getParameter("cslid");
			sql = "delete from CBT_CAROUSEL where CSL_ID = '" + cslid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Delete carousel" + cslid + " done.");
				rel = "success";
			} else {
				rel = "failed";
			}
			IOManager.write(rel, response);
			return;
		}
		
		if (act.equals("edit")) {
			String cslid = request.getParameter("cslid");
			String csltype = request.getParameter("csltype-edit");
			String cslsrc = request.getParameter("cslsrc-edit");
			String csltarget = request.getParameter("csltarget-edit");
			String cslnote = request.getParameter("cslnote-edit");
			sql = "update CBT_CAROUSEL c set c.csl_target = '" + csltarget + "', c.csl_type = '" + csltype + "', c.csl_src = '" + cslsrc
					+ "', c.csl_note = '" + cslnote + "' where c.csl_id = '" + cslid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Update carousel" + cslid + " done.");
			} else {
				System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] Update carousel" + cslid + " failed.");
			}
			response.sendRedirect(request.getContextPath() + "/mgr/base/carousel.jsp");
			return;
		}		
		
		if (act.equals("detail")) {
			String no = request.getParameter("cslid");
			sql = "select * from CBT_CAROUSEL where CSL_ID = '" + no + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
			return;
		}
		
		if (act.equals("load")) {
			sql = "select CSL_ID, CSL_SRC, CSL_TYPE, CSL_TARGET, CSL_NOTE from CBT_CAROUSEL order by CSL_ID";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
			return;
		}
		
		if (act.equals("loadnewid")) {
			sql = "select max(CSL_ID) + 1 as NEWID from CBT_CAROUSEL";
			rel = DBManager.queryCol(sql, "newid");
			IOManager.write(rel, response);
			return;
		}
		
		if (act.equals("search")) {
			String type = request.getParameter("type");
			sql = "select CSL_ID, CSL_SRC, CSL_TYPE, CSL_TARGET, CSL_NOTE from CBT_CAROUSEL ";
			if ("0".equals(type) != true) {
				sql += "where CSL_TYPE = '" + type + "' ";
			}
			sql += "order by CSL_ID";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
			return;
		}
		
		if (act.equals("add")) {
			String id = request.getParameter("cslid");
			String type = request.getParameter("csltype");
			String src = request.getParameter("cslsrc");
			String target = request.getParameter("csltarget");
			String note = request.getParameter("cslnote");
			sql = "insert into CBT_CAROUSEL values('" + id + "', '" + target + "', '" + type + "', '" + src + "', '" + note + "')";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/mgr/base/carousel.jsp");
			} else {
				IOManager.write("<script>alert('添加失败，请刷新后再试');window.location.href = '" + request.getContextPath() + "/mgr/base/carousel.jsp';</script>", response);
			}
			return;
		} 
	}

}
