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
 * 文章管理服务
 * Servlet implementation class Article
 * @author ShenHongtai
 */
public class Article extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 文章管理服务初始化
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public Article() {
        super();
    }

	/**
	 * 文章管理服务GET
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 文章管理服务POST
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
		
		if (act.equals("dispadvice")) {
			String advid = request.getParameter("advid");
			sql = "select n.ADV_TITLE, n.ADV_CONTENT, u.U_NAME as ADV_AUTHOR, to_char(n.ADV_ADDTIME, 'yyyy-mm-dd') as ADV_ADDTIME, "
					+ "ADV_REPLY, u1.U_NAME as ADV_REAUTHOR, to_char(n.ADV_RETIME, 'yyyy-mm-dd') as ADV_RETIME "
					+ "FROM CBT_ADVICE n INNER JOIN CBT_USER u ON u.U_ID = n.ADV_AUTHOR "
					+ "INNER JOIN CBT_USER u1 ON u1.u_id = n.ADV_REAUTHOR WHERE n.ADV_ID = '" + advid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("enable")) {
			String advid = request.getParameter("advid");
			sql = "update CBT_ADVICE set ADV_ENABLE = 'T' where ADV_ID = '" + advid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Enable " + advid + " done.");
				response.sendRedirect(request.getContextPath() + "/mgr/base/advice.jsp");
			}
		}
		
		else if (act.equals("disable")) {
			String advid = request.getParameter("advid");
			sql = "update CBT_ADVICE set ADV_ENABLE = 'F' where ADV_ID = '" + advid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Disable " + advid + " done.");
				response.sendRedirect(request.getContextPath() + "/mgr/base/advice.jsp");
			}			
		}
		
		else if (act.equals("add")) {
			String tab = request.getParameter("tab");
			String id = "";
			if (tab.equals("news")) {
				sql = "SELECT trim(TO_CHAR(CBS_NOTICE.Nextval,'0000')) NTCID FROM DUAL";
				id = "NTC" + DataManager.getCurrDateNosplit();
				id += DBManager.queryCol(sql, "NTCID");
				String title = request.getParameter("article-title");
				String type = request.getParameter("article-type");
				String author = (String)request.getSession().getAttribute("userid");
				String addtime = DataManager.getCurrDateTime();
				String content = request.getParameter("article-content");
				String note = request.getParameter("article-note");
				sql = "INSERT INTO CBT_NOTICE VALUES ('" + id + "', '" + title + "', '" + type + "', '" + author + 
						"', to_date('" + addtime + "', 'yyyy-mm-dd hh24:mi:ss'), '', '', '" + content + "', '" + note + "')";
				rel = "<script>alert('保存成功！');window.location.href='" + request.getContextPath() + "/mgr/base/news.jsp'</script>";
			}
			if (tab.equals("help")) {
				sql = "SELECT trim(TO_CHAR(CBS_HELP.NEXTVAL,'0000')) HELPID FROM DUAL";
				id = "HELP" + DataManager.getCurrDateNosplit();
				id += DBManager.queryCol(sql, "HELPID");
				String title = request.getParameter("article-title");
				String author = (String)request.getSession().getAttribute("userid");
				String addtime = DataManager.getCurrDateTime();
				String content = request.getParameter("article-content");
				String note = request.getParameter("article-note");
				sql = "INSERT INTO CBT_HELP VALUES ('" + id + "', '" + title + "', '" + author + 
						"', to_date('" + addtime + "', 'yyyy-mm-dd hh24:mi:ss'), '', '', '" + content + "', '" + note + "')";
				rel = "<script>alert('保存成功！');window.location.href='" + request.getContextPath() + "/mgr/base/help.jsp'</script>";
			}
			
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Insert " + id + " done.");
				IOManager.write(rel, response);
			}
		}
		
		else if (act.equals("edit")) {
			String tab = request.getParameter("tab");
			String id = "";
			if (tab.equals("news")) {
				id = request.getParameter("article-id");
				String title = request.getParameter("article-title-edit");
				String type = request.getParameter("article-type-edit");
				String editor = (String)request.getSession().getAttribute("userid");
				String edittime = DataManager.getCurrDateTime();
				String content = request.getParameter("article-content-edit");
				String note = request.getParameter("article-note-edit");
				sql = "UPDATE CBT_NOTICE n SET n.ntc_title = '" + title + "', n.ntc_type = '" + type + "', n.ntc_mdfperson = '" 
						+ editor + "', n.ntc_lastmdf = to_date('" + edittime + "', 'yyyy-mm-dd hh24:mi:ss'), n.ntc_content = '" 
						+ content + "', n.ntc_note = '" + note + "' WHERE n.ntc_id = '" + id + "'";
				rel = "<script>alert('保存成功！');window.location.href='" + request.getContextPath() + "/mgr/base/news.jsp'</script>";
			}
			if (tab.equals("help")) {
				id = request.getParameter("article-id");
				String title = request.getParameter("article-title-edit");
				String editor = (String)request.getSession().getAttribute("userid");
				String edittime = DataManager.getCurrDateTime();
				String content = request.getParameter("article-content-edit");
				String note = request.getParameter("article-note-edit");
				sql = "update CBT_HELP h set HELP_TITLE = '" + title + "', HELP_CONTENT = '" + content 
						+ "', h.help_mdfperson = '" + editor + "', h.help_lastmdf = to_date('" + edittime 
						+ "', 'yyyy-mm-dd hh24:mi:ss'), h.help_note = '" + note + "' WHERE h.help_id = '" + id + "'";
				rel = "<script>alert('保存成功！');window.location.href='" + request.getContextPath() + "/mgr/base/help.jsp'</script>";
			}
			if (tab.equals("advice")) {
				id = request.getParameter("article-id");
				String reply = request.getParameter("article-reply");
				String editor = (String)request.getSession().getAttribute("userid");
				String edittime = DataManager.getCurrDateTime();
				String note = request.getParameter("article-note-edit");
				sql = "update CBT_ADVICE set ADV_REPLY = '" + reply + "', ADV_REAUTHOR = '" + editor + 
						"', ADV_RETIME = to_date('" + edittime + "', 'yyyy-mm-dd hh24:mi:ss'), ADV_NOTE = '" + note + 
						"' WHERE ADV_ID = '" + id + "'";
				rel = "<script>alert('审阅成功！');window.location.href='" + request.getContextPath() + "/mgr/base/advice.jsp'</script>";
			}
			
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Update " + id + " done.");
				IOManager.write(rel, response);
			}
		}
		
		else if (act.equals("del")) {
			String tab = request.getParameter("tab");
			String articleid = "";
			if (tab.equals("news")) {
				articleid = request.getParameter("ntcid");
				sql = "delete from CBT_NOTICE where NTC_ID = '" + articleid + "'";
				rel = "<script>alert('删除成功！');window.location.href='" + request.getContextPath() + "/mgr/base/news.jsp';</script>";
			}
			if (tab.equals("help")) {
				articleid = request.getParameter("helpid");
				sql = "delete from CBT_HELP where HELP_ID = '" + articleid + "'";				
				rel = "<script>alert('删除成功！');window.location.href='" + request.getContextPath() + "/mgr/base/help.jsp';</script>";
			}
			
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[ArticleMgr][S][" + DataManager.getCurrDateTime() + "] Delete " + articleid + " done.");
			}
			IOManager.write(rel, response);
		}
		
		else if (act.equals("noticetotalpage")) {
			String type = request.getParameter("type");
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			String title = request.getParameter("title");
			
			String searchitems = "where 1=1";
			if (title.length() > 0) {
				searchitems += " and n.NTC_TITLE like '%" + title + "%'";
			}
			if ("0".equals(type) == false) {
				searchitems += " and n.NTC_TYPE = '" + type + "'";
			}
			if (starttime.length() > 0){
				searchitems += " and n.NTC_ADDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0){
				searchitems += " and n.NTC_ADDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			sql = "select ceil(count(NTC_ID)/10) as TOTALPAGE from CBT_NOTICE n " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("helptotalpage")) {
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			String title = request.getParameter("title");
			
			String searchitems = "where 1=1";
			if (title.length() > 0) {
				searchitems += " and n.HELP_TITLE like '%" + title + "%'";
			}
			if (starttime.length() > 0) {
				searchitems += " and n.HELP_ADDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and n.HELP_ADDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			sql = "select ceil(count(HELP_ID)/10) as TOTALPAGE from CBT_HELP n " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("advtotalpage")) {
			int type = Integer.parseInt(request.getParameter("type"));
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			String title = request.getParameter("title");
			
			String searchitems = "where 1=1";
			if (title.length() > 0) {
				searchitems += " and n.ADV_TITLE like '%" + title + "%'";
			}
			switch (type) {
			case 1:
				searchitems += " and n.ADV_RETIME is null";
				break;
			case 2:
				searchitems += " and n.ADV_RETIME is not null";
				break;
			case 0:
				break;
			}
			if (starttime.length() > 0) {
				searchitems += " and n.ADV_ADDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and n.ADV_ADDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "select ceil(count(ADV_ID)/10) as TOTALPAGE from CBT_ADVICE n " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("load")) {
			String tab = request.getParameter("tab");
			if (tab.equals("news")) {
				String type = request.getParameter("type");
				String starttime = request.getParameter("starttime");
				String endtime = request.getParameter("endtime");
				String page = request.getParameter("page");
				String title = request.getParameter("title");
				
				String searchitems = "where 1=1";
				if (title.length() > 0) {
					searchitems += " and n.NTC_TITLE like '%" + title + "%'";
				}
				if ("0".equals(type) == false) {
					searchitems += " and n.NTC_TYPE = '" + type + "'";
				}
				if (starttime.length() > 0) {
					searchitems += " and n.NTC_ADDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
				}
				if (endtime.length() > 0) {
					searchitems += " and n.NTC_ADDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
				}
				
				sql = "select a2.* from (select a1.*, rownum rn from ("
						+ "select decode(n.ntc_type,'A','公告','N','新闻') as ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, "
						+ "u.u_name as ntc_author, to_char(n.ntc_addtime, 'yyyy-mm-dd') as ntc_addtime from CBT_NOTICE n "
						+ "inner join CBT_USER u on u.u_id = n.ntc_author " + searchitems + " order by n.NTC_ADDTIME desc"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			}
			if (tab.equals("help")) {
				String starttime = request.getParameter("starttime");
				String endtime = request.getParameter("endtime");
				String page = request.getParameter("page");
				String title = request.getParameter("title");
				
				String searchitems = "where 1=1";
				if (title.length() > 0) {
					searchitems += " and n.HELP_TITLE like '%" + title + "%'";
				}
				if (starttime.length() > 0) {
					searchitems += " and n.HELP_ADDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
				}
				if (endtime.length() > 0) {
					searchitems += " and n.HELP_ADDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
				}
				
				sql = "select a2.* from (select a1.*, rownum rn from ("
						+ "select n.HELP_ID, n.HELP_TITLE, n.HELP_CONTENT, u.U_NAME as HELP_AUTHOR, "
						+ "to_char(n.help_addtime, 'yyyy-mm-dd') as help_addtime from CBT_HELP n "
						+ "inner join CBT_USER u on u.u_id = n.help_author " + searchitems + " order by n.HELP_ADDTIME desc"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			}
			if (tab.equals("advice")) {
				int type = Integer.parseInt(request.getParameter("type"));
				String starttime = request.getParameter("starttime");
				String endtime = request.getParameter("endtime");
				String page = request.getParameter("page");
				String title = request.getParameter("title");
				
				String searchitems = "where 1=1";
				if (title.length() > 0) {
					searchitems += " and n.ADV_TITLE like '%" + title + "%'";
				}
				switch (type) {
				case 1:
					searchitems += " and n.ADV_RETIME is null";
					break;
				case 2:
					searchitems += " and n.ADV_RETIME is not null";
					break;
				case 0:
					break;
				}
				if (starttime.length() > 0) {
					searchitems += " and n.ADV_ADDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
				}
				if (endtime.length() > 0) {
					searchitems += " and n.ADV_ADDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
				}
				
				sql = "select a2.* from (select a1.*, rownum rn from ("
						+ "select n.ADV_ID, n.ADV_TITLE, n.ADV_CONTENT, u.U_NAME as ADV_AUTHOR, to_char(n.ADV_ADDTIME, "
						+ "'yyyy-mm-dd') as ADV_ADDTIME, to_char(n.ADV_RETIME, 'yyyy-mm-dd') as ADV_RETIME, ADV_ENABLE "
						+ "from CBT_ADVICE n inner join CBT_USER u on u.u_id = n.adv_author " + searchitems 
						+ " order by n.ADV_ADDTIME desc"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			}
			
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
			return;
		}
		
		else if (act.equals("editload")) {
			String tab = request.getParameter("tab");
			if (tab.equals("news")) {
				String ntcid = request.getParameter("ntcid");
				sql = "select n.ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, u.u_name as ntc_author, "
						+ "to_char(n.ntc_addtime, 'yyyy-mm-dd hh24:mi:ss') as ntc_addtime, n.ntc_note from CBT_NOTICE n "
						+ "inner join CBT_USER u on u.u_id = n.ntc_author where n.ntc_id = '" + ntcid + "'";
			}
			if (tab.equals("help")) {
				String helpid = request.getParameter("helpid");
				sql = "select n.help_id, n.help_title, n.help_content, u.u_name as help_author, "
						+ "to_char(n.help_addtime, 'yyyy-mm-dd hh24:mi:ss') as help_addtime, n.help_note from CBT_HELP n "
						+ "inner join CBT_USER u on u.u_id = n.help_author where n.help_id = '" + helpid + "'";
			}
			if (tab.equals("advice")) {
				String advid = request.getParameter("advid");
				sql = "SELECT ad.ADV_ID, ad.adv_title, ad.adv_content, u.U_NAME as ADV_AUTHOR, to_char(ad.ADV_ADDTIME, "
						+ "'yyyy-mm-dd') as ADV_ADDTIME from CBT_ADVICE ad inner join CBT_USER u on u.u_id = ad.ADV_AUTHOR "
						+ "where ad.ADV_ID = '" + advid + "'";
			}
			
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
			return;
		}
	}

}
