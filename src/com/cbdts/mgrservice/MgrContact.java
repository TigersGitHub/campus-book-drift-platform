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
 * 管理员通讯录维护服务
 * Servlet implementation class MgrUpdateInfo
 * @author ShenHongtai
 */
public class MgrContact extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 管理员通讯录维护初始化
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public MgrContact() {
        super();
    }

	/**
	 * 管理员通讯录维护Get
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 管理员通讯录维护Post
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
		
		//添加员工
		if (act.equals("addemp")) {
			String userid = null;
			String uname = request.getParameter("uname");
			String uemail = request.getParameter("uemail");
			String utel = request.getParameter("utel");
			String upw = request.getParameter("upw");
			String usex = request.getParameter("usex");
			String uage = request.getParameter("uage");
			String uhometown = request.getParameter("uhometown");
			String unote = request.getParameter("unote");
			
			sql = "select CBS_EMP.nextval as userid from dual";	
			userid = DBManager.queryCol(sql, "userid");
			
			sql = "insert into CBT_USER values ('" + userid + "', '" + uemail + "', '" + utel + "', '" + uname + "', '" + upw 
					+ "', '" + usex + "', '0', '" + uage + "', '" + uhometown + "', to_date('" + DataManager.getCurrDateTime() 
					+ "', 'yyyy-mm-dd hh24:mi:ss'), 0, 'T', '";
			if (unote != null && unote != "") {
				sql += unote;
			}
			sql += "', '')";					
			row = DBManager.update(sql);
			if (row > 0) {
				sql = "insert into CBT_ROLE values ('" + userid + "', '" + userid + "', 'A')";
				row = DBManager.update(sql);
				if (row > 0) {
					//操作成功
					response.sendRedirect(request.getContextPath() + "/mgr/contact.jsp");
				} else {
					System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] Failed to insert role for new emp, we're trying to rollback...");
					rel = "<script>alert('员工信息添加失败，Code：" + row;
					
					sql = "delete from CBT_USER where U_ID = '" + userid + "'";
					row = DBManager.update(sql);
					if (row > 0) {
						System.out.println("[EMPMGR][S][" + DataManager.getCurrDateTime() + "] Delete emp " + userid + " succeed.");
						rel += "/" + row + "');</script>";
						IOManager.write(rel, response);
					} else {
						System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] Failed to delete emp " + userid + ", please delete it in DBMS.");
						rel += "/" + row + "');</script>";
						IOManager.write(rel, response);
					}
				}
			} else {
				System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] Failed to insert user for new emp.");
				rel = "<script>alert('员工信息添加失败，Code：" + row + "');</script>";
				IOManager.write(rel, response);
			}
		}
		
		//员工编辑
		if (act.equals("edit")) {
			String userid = request.getParameter("empid");
			String name = request.getParameter("empname");
			String email = request.getParameter("empemail");
			String tel = request.getParameter("emptel");
			String sex = request.getParameter("empsex");
			String age = request.getParameter("empage");
			String hometown = request.getParameter("emphome");
			String note = request.getParameter("empnote");
			
			sql = "update CBT_USER set U_EMAIL = '" + email + "', U_MOBILE = '" + tel + "', U_NAME = '" + name + "', U_SEX = '" 
					+ sex + "', U_AGE = '" + age + "', U_HOMETOWN = '" + hometown + "', U_LASTUPDATE = to_date('" 
					+ DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss'), U_NOTE = '" + note + "' where U_ID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				//操作成功，跳转至员工详情页
				request.getSession().setAttribute("empdetail", userid);
				response.sendRedirect(request.getContextPath() + "/mgr/base/mgrinfo.jsp");
			} else {
				System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] Failed to update emp info");
				rel = "<script>alert('员工信息保存失败，Code：" + row + "');</script>";
			}
		}
		
		//员工编辑跳转
		if (act.equals("editjump")) {
			String userid = request.getParameter("id");
			request.getSession().setAttribute("empedit", userid);
			response.sendRedirect(request.getContextPath() + "/mgr/base/empedit.jsp");
		}
		
		//员工详情加载
		if (act.equals("detailcontent")) {
			String no = null;
			try {
				if ((String)request.getSession().getAttribute("empedit") != null) {
					no = (String)request.getSession().getAttribute("empedit");
				} else {
					IOManager.write("back", response);
					return;
				}
			} catch (Exception e) {
				System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] User jump for empdetail without id");
			}
			sql = "select u_id, u_email, u_mobile, u_name, u_sex, u_age, u_hometown, to_char(u_regtime, 'yyyy-mm-dd') as u_enttime, "
					+ "u_enable, u_note from cbt_user where u_id = '" + no + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);			
		}
		
		//员工详情跳转
		if (act.equals("detail")) {
			String userid = request.getParameter("id");
			request.getSession().setAttribute("empdetail", userid);
			response.sendRedirect(request.getContextPath() + "/mgr/empdetail.jsp");
		}
		
		//员工禁用
		if (act.equals("disable")) {
			String userid = request.getParameter("id");
			sql = "update CBT_USER set U_ENABLE = 'F' where U_ID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/mgr/base/mgrinfo.jsp");
			} else {
				rel = "<script>alert('用户" + userid + "禁用失败')</script>";
			}
		}
		
		//员工启用
		if (act.equals("enable")) {
			String userid = request.getParameter("id");
			sql = "update CBT_USER set U_ENABLE = 'T' where U_ID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/mgr/base/mgrinfo.jsp");
			} else {
				rel = "<script>alert('用户" + userid + "启用失败')</script>";
			}
		}
		
		//员工搜索
		if (act.equals("search")) {
			String keyword = request.getParameter("keyword");
			sql = "select u.u_id, u.u_name, u.u_sex, to_char(u.u_regtime, 'yyyy-mm-dd') as u_enttime, u.u_mobile, u.u_email, u.u_enable "
					+ "from CBT_USER u left join CBT_ROLE r on u.u_id = r.r_uid where r.r_sign = 'A' and u.u_id != '9999' "
					+ "and u.u_name like '%" + keyword + "%' order by u.u_id";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//员工列表加载
		if (act.equals("loadlist")) {
			sql = "select u.u_id, u.u_name, u.u_sex, to_char(u.u_regtime, 'yyyy-mm-dd') as u_enttime, u.u_mobile, u.u_email, u.u_enable "
					+ "from CBT_USER u left join CBT_ROLE r on u.u_id = r.r_uid where r.r_sign = 'A' and u.u_id != '9999' order by u.u_id";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);			
		}
		
		//员工列表加载
		if (act.equals("loadrolelist")) {
			String uid = request.getParameter("uid");
			String uname = request.getParameter("uname");
			String stime = request.getParameter("stime");
			String etime = request.getParameter("etime");
			
			String searchitems = "";
			if (uid.length() > 0) {
				searchitems += " and u.U_ID = '" + uid + "'";
			}
			if (uname.length() > 0) {
				searchitems += " and u.U_NAME like '%" + uname + "%'";
			}
			if (stime.length() > 0) {
				searchitems += " and u.U_REGTIME >= to_date('" + stime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (etime.length() > 0) {
				searchitems += " and u.U_REGTIME <= to_date('" + etime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "SELECT u.u_id, u.u_name, u.u_sex, u.u_mobile, u.u_email, u.u_enable, r2.r_sign FROM CBT_USER u "
					+ "LEFT OUTER JOIN CBT_ROLE r1 ON r1.r_uid = u.u_id and r1.r_sign = 'A' "
					+ "LEFT OUTER JOIN CBT_ROLE r2 ON r2.r_uid = u.u_id and r2.r_sign = 'U' "
					+ "WHERE r1.r_sign = 'A' and u.u_id != '9999' " + searchitems + " ORDER BY U_ID";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//取消权限
		if (act.equals("removeuserrole")) {
			String id = request.getParameter("id");
			sql = "DELETE FROM CBT_ROLE WHERE R_UID = '" + id + "' and R_SIGN = 'U'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>window.location.href='" + request.getContextPath() + "/mgr/base/mgrinfo.jsp'</script>";
			} else {
				rel = "<script>alert('取消失败，请稍后再试');window.location.href='" + request.getContextPath() + "/mgr/base/mgrinfo.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//开通权限
		if (act.equals("adduserrole")) {
			String id = request.getParameter("id");
			sql = "INSERT INTO CBT_ROLE VALUES ('" + id + "_1', '" + id + "', 'U')";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>window.location.href='" + request.getContextPath() + "/mgr/base/mgrinfo.jsp'</script>";
			} else {
				rel = "<script>alert('开通失败，请稍后再试');window.location.href='" + request.getContextPath() + "/mgr/base/mgrinfo.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//订单总量
		if (act.equals("countorder")) {
			sql = "select ORD_STATUS, count(ORD_ID) as ORD_COUNT from CBT_ORDER group by ORD_STATUS";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//统计时间
		if (act.equals("counttime")) {
			IOManager.write(DataManager.getCurrDateTime(), response);
		}
		
		//按上架类型统计
		if (act.equals("countbyselltype")) {
			sql = "SELECT BOOK_ISSELL, COUNT(BOOK_ID) as BOOK_COUNT FROM CBT_BOOK b GROUP BY b.book_issell";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//近七天订单统计
		if (act.equals("count7days")) {
			sql = "SELECT ORD_TIME, count(*) as ORD_COUNT FROM ("
					+ "SELECT to_char(o.ord_ordtime, 'mm-dd') as ORD_TIME, o.* FROM CBT_ORDER o WHERE ORD_ORDTIME > to_date('"
					+ DataManager.getPastDateTime(7) + "', 'yyyy-mm-dd hh24:mi:ss') ORDER BY ORD_ORDTIME"
				+ ") GROUP BY ORD_TIME";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//合作商可计收入统计
		if (act.equals("countincome")) {
			sql = "SELECT CORP_NAME, trunc(sum(CORP_INCOME), 2) as CORP_INCOME FROM ("
					+ "SELECT CORP_SHORTNAME as CORP_NAME, (REC_CLICK/REC_PAYBALANCE)*REC_SPPRICE as CORP_INCOME FROM CBT_RECOMMEND "
					+ "INNER JOIN CBT_CORPORATION ON CORP_ID = REC_CORPID ORDER BY CORP_INCOME desc"
				+ ") WHERE rownum <= 3 GROUP BY CORP_NAME "
				+ "union "
				+ "SELECT CORP_NAME, trunc(sum(CORP_INCOME), 2) as CORP_INCOME FROM ("
					+ "select a2.* from (select a1.*, rownum rn from ("
						+ "SELECT '其他' as CORP_NAME, (REC_CLICK/REC_PAYBALANCE)*REC_SPPRICE as CORP_INCOME FROM CBT_RECOMMEND "
						+ "INNER JOIN CBT_CORPORATION ON CORP_ID = REC_CORPID ORDER BY CORP_INCOME desc"
					+ ") a1) a2 WHERE rn > 3"
				+ ") GROUP BY CORP_NAME";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);			
		}
		
		//首页大字合计
		if (act.equals("total")) {
			sql = "SELECT 'USER' as TOTAL_KEY, COUNT(U_ID) as TOTAL_VAL FROM CBT_USER INNER JOIN CBT_ROLE ON U_ID = R_UID AND "
					+ "R_SIGN = 'U' WHERE U_ID > 10000 UNION SELECT 'BOOK' as TOTAL_KEY, COUNT(BOOK_ID) as TOTAL_VAL FROM CBT_BOOK "
					+ "UNION SELECT 'ORDER' as TOTAL_KEY, COUNT(ORD_ID) as TOTAL_VAL FROM CBT_ORDER UNION SELECT 'INCOME' as "
					+ "TOTAL_KEY, TRUNC(SUM((REC_CLICK/REC_PAYBALANCE)*REC_SPPRICE), 2) as TOTAL_VAL FROM CBT_RECOMMEND";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);	
		}
		
	}
}
