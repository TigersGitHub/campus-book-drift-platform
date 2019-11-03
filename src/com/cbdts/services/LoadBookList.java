package com.cbdts.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbdts.commons.DBManager;
import com.cbdts.commons.DataManager;
import com.cbdts.commons.IOManager;

/**
 * ͼ���б���ط���
 * Servlet implementation class LoadBookList
 * @author ShenHongtai
 */
public class LoadBookList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * ͼ���б���س�ʼ������
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public LoadBookList() {
        super();
    }

	/**
	 * ͼ���б����GET����
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * ͼ���б����POST����
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String act = request.getParameter("act");
		String sql = "";
		int row = -1;
		String rel = "";
		
		if (act.equals("getUserid")) {
			rel = (String)request.getSession().getAttribute("userid");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("collect")) {
			//�ղ�
			String bookid = request.getParameter("bookid");
			String userid = (String)request.getSession().getAttribute("userid");
			String favid = "FAV" + DataManager.getCurrDateNosplit();
			sql = "select trim(to_char(CBS_FAVORITE.Nextval, '0000')) as FAVID from dual";
			favid += DBManager.queryCol(sql, "FAVID");
			sql = "INSERT INTO CBT_FAVORITE values ('" + favid + "', '" + bookid + "', '" + userid + "', to_date('" 
					+ DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss'), 'T', '')";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "success";
			} else {
				rel = "failed";
			}
			IOManager.write(rel, response);
		}
		
		else if (act.equals("latestbook")) {
			//������ҳ����ͼ��
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, BOOK_ISSELL, fav.fav_enable as "
					+ "FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and fav.fav_userid = '"
					+ userid + "' WHERE b.book_enable = 'T' and b.book_isexist = 'Y' ORDER BY BOOK_ADDTIME DESC"
				+ ") a1) a2 where rn <= 8";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("hotdrift")) {
			//������ҳ����Ư��
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, fav.fav_enable as FAVORITE FROM CBT_BOOK b "
					+ "LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and fav.fav_userid = '" + userid + "' "
					+ "WHERE b.book_enable = 'T' and b.book_issell = 'N' and b.book_isexist = 'Y' ORDER BY BOOK_CLICK DESC"
				+ ") a1) a2 where rn <= 4";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("hotsell")) {
			//������ҳ���Ŷ���
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, fav.fav_enable as "
					+ "FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and "
					+ "fav.fav_userid = '" + userid + "' WHERE b.book_enable = 'T' and b.book_issell = 'Y' and b.book_isexist = 'Y' "
					+ "ORDER BY BOOK_CLICK DESC"
				+ ") a1) a2 where rn <= 4";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);			
		}
		
		else if (act.equals("recbook")) {
			//������ҳ�Ƽ�ͼ��
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT r.rec_id, r.rec_name_ch, r.rec_press, r.rec_image, r.rec_price, r.rec_sellprice FROM CBT_RECOMMEND r "
					+ "WHERE r.rec_enable = 'T' ORDER BY REC_CLICK DESC"
				+ ") a1) a2 where rn <= 4";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);	
		}
		
		else if (act.equals("recbookaddon")) {
			//�Ƽ�ͼ������
			String bookid = (String)request.getSession().getAttribute("book_detail");
			if (bookid == null) {
				response.sendRedirect(request.getContextPath() + "/books");
				return;
			}
			String addon = request.getParameter("addon");
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT r.rec_id, r.rec_name_ch, r.rec_press, r.rec_image, r.rec_price, r.rec_sellprice FROM CBT_RECOMMEND r "
					+ "WHERE r.rec_enable = 'T' and REC_TYPE != (SELECT BOOK_TYPE FROM CBT_BOOK WHERE BOOK_ID = '" + bookid + "') "
					+ "ORDER BY REC_CLICK DESC"
				+ ") a1) a2 where rn <= " + addon;
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);	
		}
		
		else if (act.equals("recbookbytype")) {
			//����������Ƽ�ͼ��
			String bookid = (String)request.getSession().getAttribute("book_detail");
			if (bookid == null) {
				response.sendRedirect(request.getContextPath() + "/books");
				return;
			}
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT r.rec_id, r.rec_name_ch, r.rec_press, r.rec_image, r.rec_price, r.rec_sellprice FROM CBT_RECOMMEND r "
					+ "WHERE REC_TYPE = (SELECT BOOK_TYPE FROM CBT_BOOK WHERE BOOK_ID = '" + bookid + "') and r.rec_enable = 'T' "
					+ "ORDER BY REC_CLICK DESC"
				+ ") a1) a2 where rn <= 3";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("countprivateorder")) {
			//ͳ�Ƹ��˶���
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT '1' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '" + userid 
					+ "' and ord_status = '1' union SELECT '3' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER "
					+ "WHERE ord_customer = '" + userid + "' and ord_status in ('2', '3') union SELECT '4' as STATUS, "
					+ "COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '" + userid + "' and ord_status = '4'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("loadsession")) {
			//����session��תʱ�洢�Ĺ�������
			String name = (String)request.getSession().getAttribute("BOOK_NAME_CH");
			String type = (String)request.getSession().getAttribute("BOOK_TYPE");
			String issell = (String)request.getSession().getAttribute("BOOK_ISSELL");
			rel = "[{'BOOK_NAME_CH':'" + name + "','BOOK_TYPE':'" + type + "','BOOK_ISSELL':'" + issell + "'}]";
			IOManager.write(rel, response);
		}
		
		else if (act.equals("searchbyname")) {
			//��ת������������
			String key = request.getParameter("key");
			request.getSession().setAttribute("BOOK_NAME_CH", key);
			request.getSession().setAttribute("BOOK_TYPE", "");
			request.getSession().setAttribute("BOOK_ISSELL", "");
			response.sendRedirect(request.getContextPath() + "/books/");
		}
		
		else if (act.equals("loadbytype")) {
			//��ת��Ĭ��ɸѡͼ������
			String type = request.getParameter("type");
			request.getSession().setAttribute("BOOK_NAME_CH", "");
			request.getSession().setAttribute("BOOK_TYPE", type);
			request.getSession().setAttribute("BOOK_ISSELL", "");
			response.sendRedirect(request.getContextPath() + "/books/");
		}
		
		else if (act.equals("loadall")) {
			//��ת����ʾȫ��
			request.getSession().setAttribute("BOOK_NAME_CH", "");
			request.getSession().setAttribute("BOOK_TYPE", "");
			request.getSession().setAttribute("BOOK_ISSELL", "");
			response.sendRedirect(request.getContextPath() + "/books/");
		}
		
		else if (act.equals("loaddrift")) {
			//��ת��Ĭ��ɸѡͼ��Ư��
			request.getSession().setAttribute("BOOK_NAME_CH", "");
			request.getSession().setAttribute("BOOK_TYPE", "");
			request.getSession().setAttribute("BOOK_ISSELL", "N");
			response.sendRedirect(request.getContextPath() + "/books/");
		}
		
		else if (act.equals("loadsell")) {
			//��ת��Ĭ��ɸѡ����ͼ��
			request.getSession().setAttribute("BOOK_TYPE", "");
			request.getSession().setAttribute("BOOK_ISSELL", "Y");
			response.sendRedirect(request.getContextPath() + "/books/");
		}
		
		else if (act.equals("search")) {
			//����ͼ���б���ɸѡ��
			String page = request.getParameter("page");
			String btype = request.getParameter("btype");
			String session_btype = (String)request.getSession().getAttribute("BOOK_TYPE");
			if (session_btype != "" && session_btype != null) {
				btype = session_btype;
				request.getSession().setAttribute("BOOK_TYPE", "");
			}
			String bname = request.getParameter("bname");
			String session_bname = (String)request.getSession().getAttribute("BOOK_NAME_CH");
			if (session_bname != "" && session_bname != null) {
				bname = session_bname;
				request.getSession().setAttribute("BOOK_NAME_CH", "");
			}
			String issell = request.getParameter("issell");
			String session_issell = (String)request.getSession().getAttribute("BOOK_ISSELL");
			if (session_issell != "" && session_issell != null) {
				issell = session_issell;
				request.getSession().setAttribute("BOOK_ISSELL", "");
			}
			String minprice = request.getParameter("minprice");
			String maxprice = request.getParameter("maxprice");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if ("0".equals(btype) == false) {
				searchitems += " and BOOK_TYPE = '" + btype + "'";
			}
			if (minprice.length() > 0){
				searchitems += " and BOOK_SELLPRICE >= " + minprice;
			}
			if (maxprice.length() > 0){
				searchitems += " and BOOK_SELLPRICE <= " + maxprice;
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, BOOK_ISSELL, "
					+ "fav.fav_enable as FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id "
					+ "WHERE b.book_enable = 'T' and b.book_isexist = 'Y' " + searchitems + " ORDER BY BOOK_ADDTIME DESC"
				+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);	
		}
		
		else if (act.equals("booktotalpage")) {
			//����ͼ���ҳ�ؼ�
			String btype = request.getParameter("btype");
			String bname = request.getParameter("bname");
			String issell = request.getParameter("issell");
			String minprice = request.getParameter("minprice");
			String maxprice = request.getParameter("maxprice");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and n.BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and n.BOOK_ISSELL = '" + issell + "'";
			}
			if ("0".equals(btype) == false) {
				searchitems += " and n.BOOK_TYPE = '" + btype + "'";
			}
			if (minprice.length() > 0){
				searchitems += " and n.BOOK_SELLPRICE >= " + minprice;
			}
			if (maxprice.length() > 0){
				searchitems += " and n.BOOK_SELLPRICE <= " + maxprice;
			}
			
			sql = "select ceil(count(BOOK_ID)/10) as TOTALPAGE from CBT_BOOK n WHERE BOOK_ENABLE = 'T' and BOOK_ISEXIST = 'Y' " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("searchrec")) {
			//�����Ƽ��б���ɸѡ��
			String page = request.getParameter("page");
			String btype = request.getParameter("btype");
			String bname = request.getParameter("bname");
			String minprice = request.getParameter("minprice");
			String maxprice = request.getParameter("maxprice");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and REC_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(btype) == false) {
				searchitems += " and REC_TYPE = '" + btype + "'";
			}
			if (minprice.length() > 0){
				searchitems += " and REC_SELLPRICE >= " + minprice;
			}
			if (maxprice.length() > 0){
				searchitems += " and REC_SELLPRICE <= " + maxprice;
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT REC_ID, REC_NAME_CH, REC_PRESS, REC_IMAGE, REC_PRICE, REC_SELLPRICE FROM CBT_RECOMMEND "
					+ "WHERE REC_ENABLE = 'T' " + searchitems + " ORDER BY REC_CLICK DESC"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);	
		}
		
		else if (act.equals("rectotalpage")) {
			//�����Ƽ���ҳ�ؼ�
			String btype = request.getParameter("btype");
			String bname = request.getParameter("bname");
			String minprice = request.getParameter("minprice");
			String maxprice = request.getParameter("maxprice");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and REC_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(btype) == false) {
				searchitems += " and REC_TYPE = '" + btype + "'";
			}
			if (minprice.length() > 0){
				searchitems += " and REC_SELLPRICE >= " + minprice;
			}
			if (maxprice.length() > 0){
				searchitems += " and REC_SELLPRICE <= " + maxprice;
			}
			
			sql = "select ceil(count(REC_ID)/10) as TOTALPAGE from CBT_RECOMMEND n WHERE REC_ENABLE = 'T' " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("jump")) {
			//ͼ���¼����ת
			String bookid = request.getParameter("bookid");
			request.getSession().setAttribute("book_detail", bookid);
			sql = "UPDATE CBT_BOOK b SET b.book_click = b.book_click + 1 WHERE b.book_id = '" + bookid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/books/detail.jsp");	
			} else {
				rel = "<script>alert('ϵͳ������ˢ�º�����');window.location.href='" + request.getContextPath() + "/books'</script>";
				IOManager.write(rel, response);
			}
		}
		
		else if (act.equals("detail")) {
			String bookid = (String)request.getSession().getAttribute("book_detail");
			if (bookid == null) {
				response.sendRedirect(request.getContextPath() + "/books");
				return;
			}
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT b.BOOK_ID, b.BOOK_ISBN, t.typ_name as BOOK_TYPE, b.book_name_ch, b.book_name_en, b.book_author_ch, "
					+ "b.book_author_en, b.book_press, to_char(b.book_pressdate, 'yyyy-mm-dd') as book_pressdate, l.lan_name "
					+ "as book_language, f.fmt_name as book_format, b.book_page, decode(b.book_cover, 'P', 'ƽװ', 'R', '��װ') "
					+ "as BOOK_COVER, b.book_version, b.book_issell, b.book_price, b.book_sellprice, b.book_isexist, b.book_seller, "
					+ "b.book_image, b.book_detail, b.book_note, b.book_click, fav.fav_enable as FAVORITE FROM CBT_BOOK b "
					+ "LEFT OUTER JOIN CBT_BTYPE t ON t.typ_id = b.book_type "
					+ "LEFT OUTER JOIN CBT_BLANG l ON l.lan_id = b.book_language "
					+ "LEFT OUTER JOIN CBT_BFMT f ON f.fmt_id = b.book_format "
					+ "LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and fav.fav_userid = '" + userid + "' "
					+ "WHERE b.BOOK_ID = '" + bookid + "' and b.book_enable = 'T'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("recjump")) {
			//�Ƽ�ͼ���¼����ת
			String recid = request.getParameter("recid");
			sql = "UPDATE CBT_RECOMMEND r SET r.rec_click = r.rec_click + 1 WHERE r.rec_id = '" + recid + "'";
			row = DBManager.update(sql);
			sql = "SELECT r.rec_url FROM CBT_RECOMMEND r WHERE r.rec_id = '" + recid + "'";
			rel = DBManager.queryCol(sql, "REC_URL");
			if (row > 0) {
				response.sendRedirect(rel);	
			} else {
				rel = "<script>alert('ϵͳ������ˢ�º�����');window.location.href='" + request.getContextPath() + "/recommend'</script>";
				IOManager.write(rel, response);
			}
		}
		
	}

}
