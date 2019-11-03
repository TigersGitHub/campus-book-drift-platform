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
 * 用户管理通用服务
 * Servlet implementation class UserCommon
 * @author ShenHongtai
 */
public class UserCommon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 用户管理通用服务初始化
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public UserCommon() {
        super();
    }

	/**
	 * 用户管理通用服务GET
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 用户管理通用服务POST
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
		
		//注册页面加载院校
		if (act.equals("loadorg")) {
			String parentid = request.getParameter("parentid");
			sql = "select ORG_ID, ORG_NAME from CBT_ORG where ORG_PARENT = " + parentid + " order by abs(ORG_ID)";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		/*不提供删除操作
		if (act.equals("del")) {
			String tab = request.getParameter("tab");
			if (tab.equals("user")) {
				String userid = request.getParameter("userid");
				sql = "delete from CBT_USER where U_ID ='" + userid + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					sql = "delete from CBT_ROLE where r_uid = '" + userid + "'";
					row = DBManager.update(sql);
					if (row > 0) {
						System.out.println("[DATAMGR][F][" + FormatConvertor.getCurrDateTime() + "] Delete user" + userid + " and role done.");
						rel = request.getContextPath() + "/mgr/base/userinfo.jsp";
					} else {
						System.out.println("[DATAMGR][F][" + FormatConvertor.getCurrDateTime() + "] Delete user" + userid + " role failed.");
						rel = request.getContextPath() + "/mgr/base/userinfo.jsp";
					}
				} else {
					System.out.println("[DATAMGR][F][" + FormatConvertor.getCurrDateTime() + "] Delete user" + userid + " failed.");					
					rel = request.getContextPath() + "/mgr/base/useredit.jsp";
				}
			} else if (tab.equals("adr")) {
				
			}
			response.sendRedirect(rel);
		}*/
		
		//用户管理换页组件
		if (act.equals("usertotalpage")) {
			String scollege = request.getParameter("scollege");
			String suid = request.getParameter("suid");
			String suname = request.getParameter("suname");
			
			String searchitems = "where U_ID > 10000";
			if ("0".equals(scollege) == false) {
				searchitems += " and substr(u.U_DEPTID, 0, 2) = '" + scollege + "'";
			}
			if (suid.length() > 0) {
				searchitems += " and u.U_ID like '%" + suid + "%'";
			}
			if (suname.length() > 0) {
				searchitems += " and u.U_NAME like '%" + suname + "%'";
			}
			sql = "select ceil(count(U_ID)/10) as TOTALPAGE from CBT_USER u " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//地址管理换页组件
		if (act.equals("adrtotalpage")) {
			String suid = request.getParameter("suid");
			String sprov = request.getParameter("sprov");
			String scity = request.getParameter("scity");
			String sdist = request.getParameter("sdist");
			String sadr = request.getParameter("sadr");
			String searchitems = "where 1=1";
			if (suid.length() > 0) {
				searchitems += " and ADR_UID like '%" + suid + "%'";
			}
			if ("0".equals(sprov) == false) {
				searchitems += " and ADR_PROV = " + sprov;
				if ("0".equals(scity) == false) {
					searchitems += " and ADR_CITY = " + scity;
					if ("0".equals(sdist) == false) {
						searchitems += " and ADR_DIST = " + sdist;
					}
				}
			}
			if (sadr.length() > 0) {
				searchitems += " and ADR_ADDRESS like '%" + sadr + "%'";
			}
			
			sql = "select ceil(count(ADR_ID)/10) as TOTALPAGE from CBT_USERADR " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//加载
		else if (act.equals("load")) {
			String tab = request.getParameter("tab");			
			String page = request.getParameter("page");
			
			if (tab.equals("user")) {
				String searchitems = "where U_ID > 10000";
				String scollege = request.getParameter("scollege");
				String suid = request.getParameter("suid");
				String suname = request.getParameter("suname");
				
				if ("0".equals(scollege) == false) {
					searchitems += " and substr(u.U_DEPTID, 0, 2) = '" + scollege + "'";
				}
				if (suid.length() > 0) {
					searchitems += " and u.U_ID like '%" + suid + "%'";
				}
				if (suname.length() > 0) {
					searchitems += " and u.U_NAME like '%" + suname + "%'";
				}
				
				sql = "select a2.* from (select a1.*, rownum rn from ("
						+ "select U_ID, U_NAME, U_SEX, d.DEPT_NAME as U_COLLEGENAME, U_MOBILE, U_EMAIL, U_SCORE, U_ENABLE "
						+ "from CBT_USER u inner join CBT_DEPT d on d.DEPT_ID = (select dept_parent from CBT_DEPT "
						+ "where dept_id = (select dept_parent from CBT_DEPT where dept_id = u.u_deptid)) "
						+ searchitems + " order by U_ID"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			} else if (tab.equals("adr")) {
				String suid = request.getParameter("suid");
				String sprov = request.getParameter("sprov");
				String scity = request.getParameter("scity");
				String sdist = request.getParameter("sdist");
				String sadr = request.getParameter("sadr");
				String searchitems = "where 1=1";
				if (suid.length() > 0) {
					searchitems += " and ADR_UID like '%" + suid + "%'";
				}
				if ("0".equals(sprov) == false) {
					searchitems += " and ADR_PROV = " + sprov;
					if ("0".equals(scity) == false) {
						searchitems += " and ADR_CITY = " + scity;
						if ("0".equals(sdist) == false) {
							searchitems += " and ADR_DIST = " + sdist;
						}
					}
				}
				if (sadr.length() > 0) {
					searchitems += " and ADR_ADDRESS like '%" + sadr + "%'";
				}
				
				sql = "select a2.* from (select a1.*, rownum rn from ("
						+ "select ADR_ID, ADR_UID, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, o3.ORG_NAME as ADR_DIST, "
						+ "ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE from CBT_USERADR a inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID "
						+ "inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID "
						+ searchitems + " order by ADR_ID"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			}
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}

		//跳转
		else if (act.equals("jump")) {
			String tab = request.getParameter("tab");
			if (tab.equals("user")) {
				String userid = request.getParameter("userid");
				request.getSession().setAttribute("useredit", userid);
				response.sendRedirect(request.getContextPath() + "/mgr/base/useredit.jsp");
			} else if (tab.equals("adr")) {
				String adrid = request.getParameter("adrid");
				request.getSession().setAttribute("adredit", adrid);
				response.sendRedirect(request.getContextPath() + "/mgr/base/adredit.jsp");				
			}
		}

		//加载详情
		else if (act.equals("detail")) {
			String tab = request.getParameter("tab");
			String no = "";
			if (tab.equals("user")) {
				try {
					if ((String)request.getSession().getAttribute("useredit") != null) {
						no = (String)request.getSession().getAttribute("useredit");
					} else {
						IOManager.write("back", response);
						return;
					}
				} catch (Exception e) {
					System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] User jump for useredit without id");
				}
				sql = "select U_ID, U_NAME, U_SEX, U_AGE, U_HOMETOWN, U_EMAIL, U_MOBILE, U_DEPTID, d1.dept_name as U_DEPT1, "
						+ "d2.dept_name as U_DEPT2, d3.dept_name as U_DEPT3, to_char(U_REGTIME, 'yyyy-mm-dd') as U_REGTIME, "
						+ "U_SCORE, U_ENABLE, U_NOTE from CBT_USER inner join CBT_DEPT d1 on d1.dept_id = substr(U_DEPTID, 0, 2) "
						+ "inner join CBT_DEPT d2 on d2.dept_id = substr(U_DEPTID, 0, 4) inner join CBT_DEPT d3 on "
						+ "d3.dept_id = U_DEPTID where U_ID = '" + no + "'";
			} else if (tab.equals("adr")) {
				try {
					if ((String)request.getSession().getAttribute("adredit") != null) {
						no = (String)request.getSession().getAttribute("adredit");
					} else {
						IOManager.write("back", response);
						return;
					}
				} catch (Exception e) {
					System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] User jump for adredit without id");
				}
				sql = "select ADR_ID, u.U_NAME as ADR_USERNAME, ADR_UID, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, "
						+ "o3.ORG_NAME as ADR_DIST, ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE, ADR_NOTE from CBT_USERADR a "
						+ "inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID "
						+ "inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID "
						+ "inner join CBT_USER u on u.u_id = a.ADR_UID where ADR_ID = '" + no + "'";
			}
			
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//编辑保存
		else if (act.equals("edit")) {
			String tab = request.getParameter("tab");
			if (tab.equals("user")) {
				String user = request.getParameter("userid");
				String name = request.getParameter("username");
				String sex = request.getParameter("usersex");
				String age = request.getParameter("userage");
				String email = request.getParameter("useremail");
				String tel = request.getParameter("usertel");
				String home = request.getParameter("userhome");
				String note = request.getParameter("usernote");
				sql = "update CBT_USER set U_NAME = '" + name + "', U_SEX = '" + sex + "', U_AGE = " + age 
						+ ", U_EMAIL = '" + email + "', U_MOBILE = '" + tel + "', U_HOMETOWN = '" + home 
						+ "', U_NOTE = '" + note + "' where U_ID = '" + user + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Save " + tab + user + " done.");
				} else {
					System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] Save " + tab + user + " failed.");
				}
				response.sendRedirect(request.getContextPath() + "/mgr/base/userinfo.jsp");
			} else if (tab.equals("adr")) {
				String adrid = request.getParameter("adrid");
				String uname = request.getParameter("uname");
				String tel = request.getParameter("tel");
				String adr = request.getParameter("adr");
				String zipcode = request.getParameter("zipcode");		
				String note = request.getParameter("note");
				sql = "update CBT_USERADR set ADR_UNAME = '" + uname + "', ADR_PHONE = '" + tel + "', ADR_ADDRESS = '" + adr + 
						"', ADR_ZIPCODE = '" + zipcode + "', ADR_NOTE = '" + note + "' where ADR_ID = '" + adrid + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Save " + tab + adrid + " done.");
				} else {
					System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] Save " + tab + adrid + " failed.");
				}
				response.sendRedirect(request.getContextPath() + "/mgr/base/useradr.jsp");
			} else if (tab.equals("userdept")) {
				String user = request.getParameter("userid");
				String dept = request.getParameter("deptid");
				sql = "update CBT_USER set U_DEPTID = '" + dept + "' where U_ID = '" + user + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Save Dept for User" + user + " done.");
					rel = "s";
				} else {
					System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] Save Dept for User" + user + " failed.");
					rel = "f";
				}
				IOManager.write(rel, response);
			} else if (tab.equals("adrorg")) {
				String org1 = request.getParameter("org1");
				String org2 = request.getParameter("org2");
				String org3 = request.getParameter("org3");
				String adrid = request.getParameter("adrid");
				sql = "update CBT_USERADR set ADR_PROV = '" + org1 + "', ADR_CITY = '" + org2 + "', ADR_DIST = '" + org3 
						+ "' where ADR_ID = '" + adrid + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Save Org for Address" + adrid + " done.");
					rel = "s";
				} else {
					System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] Save Org for Address" + adrid + " failed.");
					rel = "f";
				}
				IOManager.write(rel, response);
			}
		}
		
		//用户表启用
		else if (act.equals("enable")) {
			String userid = request.getParameter("userid");			
			sql = "update CBT_USER set U_ENABLE = 'T' where U_ID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Enable user" + userid + " done.");
				response.sendRedirect(request.getContextPath() + "/mgr/base/userinfo.jsp");
			} else {
				System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] Enable user" + userid + " failed.");
				rel = "<script>alert('用户启用失败');window.location.href='" + request.getContextPath() + "/mgr/base/userinfo.jsp';</script>";
			}
		}
		
		//用户表禁用
		else if (act.equals("disable")) {
			String userid = request.getParameter("userid");
			sql = "update CBT_USER set U_ENABLE = 'F' where U_ID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				System.out.println("[DATAMGR][S][" + DataManager.getCurrDateTime() + "] Disable user" + userid + " done.");
				response.sendRedirect(request.getContextPath() + "/mgr/base/userinfo.jsp");
			} else {
				System.out.println("[DATAMGR][F][" + DataManager.getCurrDateTime() + "] Disable user" + userid + " failed.");
				rel = "<script>alert('用户禁用失败');window.location.href='" + request.getContextPath() + "/mgr/base/userinfo.jsp';</script>";
			}
		}
	}
	
}
