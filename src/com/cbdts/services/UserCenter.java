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
 * 用户中心通用服务
 * Servlet implementation class UserCenter
 * @author ShenHongtai
 */
public class UserCenter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 用户中心服务初始化
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public UserCenter() {
        super();
    }

	/**
	 * 用户中心GET方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 用户中心POST方法
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
		
		//发布图书
		if (act.equals("addbook")) {
			sql = "SELECT trim(to_char(CBS_BOOK.NEXTVAL, '0000')) as BOOKID FROM DUAL";
			String book_id = "BOOK" + DataManager.getCurrDateNosplit() + DBManager.queryCol(sql, "BOOKID");
			String book_isbn = request.getParameter("book_isbn");
			String book_type = request.getParameter("book_type");
			String book_name_ch = request.getParameter("book_name_ch");
			String book_name_en = request.getParameter("book_name_en");
			String book_auth_ch = request.getParameter("book_auth_ch");
			String book_auth_en = request.getParameter("book_auth_en");
			String book_press = request.getParameter("book_press");
			String book_pressdate = request.getParameter("book_pressdate");
			String book_language = request.getParameter("book_language");
			String book_format = request.getParameter("book_format");
			String book_page = request.getParameter("book_page");
			String book_cover = request.getParameter("book_cover");
			String book_version = request.getParameter("book_version");
			String book_issell = request.getParameter("book_issell");
			String book_price = request.getParameter("book_price");
			String book_sellprice = request.getParameter("book_sellprice");
			//String book_image = request.getParameter("book_image");
			String book_detail = request.getParameter("book_detail");
			String seller = (String)request.getSession().getAttribute("userid");
			
			sql = "INSERT INTO CBT_BOOK values ('" + book_id + "', '" + book_isbn + "', '" + book_type + "', '" + book_name_ch 
					+ "', '" + book_name_en + "', '" + book_auth_ch + "', '" + book_auth_en + "', '" + book_press + "', to_date('" 
					+ book_pressdate + "', 'yyyy-mm-dd'), '" + book_language + "', '" + book_format + "', " + book_page + ", '" 
					+ book_cover + "', '" + book_version + "', '" + book_issell + "', '" + book_price + "', '" + book_sellprice 
					+ "', to_date('" + DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss'), '', 'Y', 'T', '', '" 
					+ book_detail + "', '', 0, '" + seller + "')";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('发布成功！');window.location.href='" + request.getContextPath() + "/user/mybook.jsp'</script>";
			} else {
				rel = "<script>alert('发布失败！请稍后再试');window.location.href='" + request.getContextPath() + "/user/sell.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//收藏夹分页组件
		else if (act.equals("favtotalpage")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bname = request.getParameter("bname");
			String btype = request.getParameter("btype");
			String issell = request.getParameter("issell");
			
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
			
			sql = "SELECT ceil(count(FAV_ID)/10) as TOTALPAGE FROM CBT_FAVORITE INNER JOIN CBT_BOOK ON BOOK_ID = FAV_BOOKID "
					+ "WHERE FAV_USERID = '" + userid + "' and FAV_ENABLE = 'T' " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//取消收藏
		else if (act.equals("removecollect")) {
			String favid = request.getParameter("favid");
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "DELETE FROM CBT_FAVORITE WHERE FAV_ID = '" + favid + "' and FAV_USERID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "success";
			} else {
				rel = "failed";
			}
			IOManager.write(rel, response);
		}
		
		//加载左边栏提示数字
		else if (act.equals("countuser")) {
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT 'CURRENT' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '" + userid 
					+ "' and ord_status in ('1','2','3','4') union SELECT 'ALL' as STATUS, COUNT(*) as ORDCOUNT "
					+ "FROM CBT_ORDER WHERE ord_customer = '" + userid + "' and ord_status in ('5', '6') union "
					+ "SELECT 'FAVORITE' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_FAVORITE WHERE FAV_USERID = '" + userid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//过滤并加载
		else if (act.equals("load")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bname = request.getParameter("bname");
			String btype = request.getParameter("btype");
			String issell = request.getParameter("issell");
			String page = request.getParameter("page");
			
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
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT FAV_ID, BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, BOOK_ISSELL "
					+ "FROM CBT_BOOK b INNER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id WHERE b.book_enable = 'T' "
					+ "and fav.fav_enable = 'T' and fav.fav_userid = '" + userid + "'" + searchitems + " ORDER BY fav.fav_addtime DESC"
				+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 8) + " and rn > " + (Integer.parseInt(page) * 8 - 8);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//已发布页面换页加载
		else if (act.equals("mybooktotalpage")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bname = request.getParameter("bname");
			String btype = request.getParameter("btype");
			String issell = request.getParameter("issell");
			
			String searchitems = "WHERE b.book_seller = '" + userid + "'";
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if ("0".equals(btype) == false) {
				searchitems += " and BOOK_TYPE = '" + btype + "'";
			}
			
			sql = "SELECT ceil(count(BOOK_ID)/10) as TOTALPAGE FROM CBT_BOOK b " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//加载已发布列表
		else if (act.equals("loadmybook")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String page = request.getParameter("page");
			String bname = request.getParameter("bname");
			String btype = request.getParameter("btype");
			String issell = request.getParameter("issell");
			
			String searchitems = "WHERE book_seller = '" + userid + "'";
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if ("0".equals(btype) == false) {
				searchitems += " and BOOK_TYPE = '" + btype + "'";
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT BOOK_ID, substr(BOOK_NAME_CH, 0, 6) AS BOOK_NAME_CH, length(BOOK_NAME_CH) AS BOOK_NAME_LEN, "
					+ "substr(BOOK_DETAIL, 0, 46) AS BOOK_DETAIL, length(BOOK_DETAIL) AS BOOK_DETAIL_LEN, BOOK_SELLPRICE, "
					+ "BOOK_IMAGE, BOOK_ISSELL, BOOK_ISEXIST, BOOK_ENABLE FROM CBT_BOOK " + searchitems 
					+ " and book_enable = 'T' ORDER BY BOOK_ADDTIME desc"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 8) + " and rn > " + (Integer.parseInt(page) * 8 - 8);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//已发布图书编辑框加载
		else if (act.equals("editbookload")) { 
			String bookid = request.getParameter("bookid");
			sql = "SELECT b.BOOK_ID, b.BOOK_ISBN, b.BOOK_TYPE, b.book_name_ch, b.book_name_en, b.book_author_ch, "
					+ "b.book_author_en, b.book_press, to_char(b.book_pressdate, 'yyyy-mm-dd') as book_pressdate, "
					+ "b.book_language, b.book_format, b.book_page, b.book_cover, b.book_version, b.book_issell, "
					+ "b.book_price, b.book_sellprice, b.book_isexist, b.book_image, b.book_detail FROM CBT_BOOK b "
					+ "WHERE b.BOOK_ID = '" + bookid + "' and b.book_enable = 'T'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//已发布图书编辑提交
		else if (act.equals("editbook")) {
			String bookid = request.getParameter("bookid_edit");
			String isbn = request.getParameter("isbn_edit");
			String type = request.getParameter("btype_edit");
			String namech = request.getParameter("bname_ch_edit");
			String nameen = request.getParameter("bname_en_edit");
			String authch = request.getParameter("bauth_ch_edit");
			String authen = request.getParameter("bauth_en_edit");
			String press = request.getParameter("press_edit");
			String pressdate = request.getParameter("pressdate_edit");
			String lang = request.getParameter("blang_edit");
			String fmt = request.getParameter("bfmt_edit");
			String page = request.getParameter("page_edit");
			String cover = request.getParameter("cover_edit");
			String version = request.getParameter("version_edit");
			String issell = request.getParameter("issell_edit");
			String price = request.getParameter("bprice_edit");
			String sprice = request.getParameter("bsellprice_edit");
			String detail = request.getParameter("bdetail_edit");			
			
			sql = "UPDATE CBT_BOOK b SET b.book_isbn = '" + isbn + "', b.book_type = '" + type + "', b.book_name_ch = '" 
					+ namech + "', b.book_name_en = '" + nameen + "', b.book_author_ch = '" + authch + "', b.book_author_en = '" 
					+ authen + "', b.book_press = '" + press + "', b.book_pressdate = to_date('" + pressdate + "', 'yyyy-mm-dd'), "
					+ "b.book_language = '" + lang + "', b.book_format = '" + fmt + "', b.book_page = '" + page + "', b.book_cover = '" 
					+ cover + "', b.book_version = '" + version + "', b.book_issell = '" + issell + "', b.book_price = '" + price 
					+ "', b.book_sellprice = '" + sprice + "', b.book_lastmdf = to_date('" + DataManager.getCurrDateTime() 
					+ "', 'yyyy-mm-dd hh24:mi:ss'), b.book_detail = '" + detail + "' WHERE b.book_id = '" + bookid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('保存成功！');window.location.href='" + request.getContextPath() + "/user/mybook.jsp'</script>";
			} else {
				rel = "<script>alert('保存失败，请稍后再试');window.location.href='" + request.getContextPath() + "/user/mybook.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//已发布图书删除（禁用）
		else if (act.equals("delbook")) {
			String bookid = request.getParameter("bookid");
			sql = "UPDATE CBT_BOOK SET BOOK_ENABLE = 'F' WHERE BOOK_ID = '" + bookid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('删除成功！');window.location.href='" + request.getContextPath() + "/user/mybook.jsp'</script>";
			} else {
				rel = "<script>alert('删除失败，请稍后再试');window.location.href='" + request.getContextPath() + "/user/mybook.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//个人信息预加载
		else if (act.equals("loadmyinfo")) {
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT u.u_id, u.u_email, u.u_mobile, u.u_name, u.u_sex, d1.dept_name as u_dept1, d2.dept_name as u_dept2, "
					+ "d3.dept_name as u_dept3, u.u_age, u.u_hometown, r.r_sign as u_role FROM CBT_USER u "
					+ "LEFT OUTER JOIN CBT_ROLE r ON r.r_uid = u.u_id and r.r_sign = 'U' "
					+ "LEFT OUTER JOIN CBT_DEPT d1 ON d1.dept_id = substr(u.u_deptid, 0, 2) and r.r_sign = 'U' "
					+ "LEFT OUTER JOIN CBT_DEPT d2 ON d2.dept_id = substr(u.u_deptid, 0, 4) and r.r_sign = 'U' "
					+ "LEFT OUTER JOIN CBT_DEPT d3 ON d3.dept_id = substr(u.u_deptid, 0, 6) and r.r_sign = 'U' "
					+ "WHERE u.u_id = '" + userid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//个人信息修改
		else if (act.equals("editinfo")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String uname = request.getParameter("u_name");
			String uemail = request.getParameter("u_email");
			String utel = request.getParameter("u_mobile");
			String usex = request.getParameter("u_sex");
			String uage = request.getParameter("u_age");
			String uhome = request.getParameter("u_hometown");
			sql = "UPDATE CBT_USER u set u.u_name = '" + uname + "', u.u_email = '" + uemail + "', u.u_mobile = '" + utel 
					+ "', u.u_sex = '" + usex + "', u.u_age = '" + uage + "', u.u_hometown = '" + uhome + "',  u.u_lastupdate "
					+ "= to_date('" + DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss') WHERE u.u_id = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('保存成功！');window.location.href='" + request.getContextPath() + "/user/myinfo.jsp'</script>";
			} else {
				rel = "<script>alert('保存失败，请稍后再试');window.location.href='" + request.getContextPath() + "/user/myinfo.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//加载地址列表
		else if (act.equals("loadadr")) {
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT ADR_ID, ADR_UNAME, ADR_PHONE, o1.org_name as ADR_PROV, o2.org_name as ADR_CITY, o3.org_name as ADR_DIST, "
					+ "ADR_ADDRESS, ADR_ZIPCODE, ADR_DEFAULT FROM CBT_USERADR "
					+ "LEFT OUTER JOIN CBT_ORG o1 on o1.org_id = ADR_PROV "
					+ "LEFT OUTER JOIN CBT_ORG o2 on o2.org_id = ADR_CITY "
					+ "LEFT OUTER JOIN CBT_ORG o3 on o3.org_id = ADR_DIST "
					+ "WHERE ADR_UID = '" + userid + "' and ADR_ENABLE = 'T' ORDER BY ADR_ADDTIME desc";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//加载地址数量
		else if (act.equals("countadr")) {
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT COUNT(*) AS ADRCOUNT FROM CBT_USERADR WHERE ADR_UID = '" + userid + "' and ADR_ENABLE = 'T'";
			rel = DBManager.queryCol(sql, "ADRCOUNT");
			IOManager.write(rel, response);		
		}
		
		//新增地址
		else if (act.equals("addadr")) {
			sql = "SELECT trim(to_char(CBS_ADR.NEXTVAL, '0000')) as ADRID FROM DUAL";
			String adrid = "ADR" + DataManager.getCurrDateNosplit() + DBManager.queryCol(sql, "ADRID");
			String userid = (String)request.getSession().getAttribute("userid");
			String uname = request.getParameter("uname");
			String uphone = request.getParameter("uphone");
			String prov = request.getParameter("prov");
			String city = request.getParameter("city");
			String dist = request.getParameter("dist");
			String address = request.getParameter("address");
			String zipcode = request.getParameter("zipcode");
			
			sql = "INSERT INTO CBT_USERADR VALUES ('" + adrid + "', '" + userid + "', '" + uname + "', '" + uphone + "', '" +
					prov + "', '" + city + "', '" + dist + "', '" + address + "', '" + zipcode + "', to_date('" + DataManager.getCurrDateTime() +
					"', 'yyyy-mm-dd hh24:mi:ss'), '', '', 'T', 'F')";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('添加成功！');window.location.href='" + request.getContextPath() + "/user/myadr.jsp'</script>";
			} else {
				rel = "<script>alert('添加失败，请稍后再试');window.location.href='" + request.getContextPath() + "/user/myadr.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//加载ORG字典
		else if (act.equals("loadorg")) {
			String parentid = request.getParameter("parentid");
			sql = "select ORG_ID, ORG_NAME from CBT_ORG where ORG_PARENT = '" + parentid + "' order by abs(ORG_ID)";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//删除地址
		else if (act.equals("deladr")) {
			String adrid = request.getParameter("adrid");
			sql = "UPDATE CBT_USERADR SET ADR_ENABLE = 'F' WHERE ADR_ID = '" + adrid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('删除成功！');window.location.href='" + request.getContextPath() + "/user/myadr.jsp'</script>";
			} else {
				rel = "<script>alert('删除失败，请稍后再试');window.location.href='" + request.getContextPath() + "/user/myadr.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//地址编辑加载
		else if (act.equals("adrdetail")) {
			String adrid = request.getParameter("adrid");
			sql = "SELECT ADR_UNAME, ADR_PHONE, ADR_PROV, ADR_CITY, ADR_DIST, ADR_ADDRESS, ADR_ZIPCODE FROM CBT_USERADR "
					+ "WHERE ADR_ID = '" + adrid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//地址编辑提交
		else if (act.equals("adredit")) {
			String adrid = request.getParameter("adrid");
			String uname = request.getParameter("uname_edit");
			String uphone = request.getParameter("uphone_edit");
			String prov = request.getParameter("prov_edit");
			String city = request.getParameter("city_edit");
			String dist = request.getParameter("dist_edit");
			String address = request.getParameter("address_edit");
			String zipcode = request.getParameter("zipcode_edit");
			sql = "UPDATE CBT_USERADR SET ADR_U_NAME = '" + uname + "', ADR_PHONE = '" + uphone + "', ADR_PROV = '" + prov + 
					"', ADR_CITY = '" + city + "', ADR_DIST = '" + dist + "', ADR_ADDRESS = '" + address + "', ADR_ZIPCODE = '" +
					zipcode + "', ADR_LASTMDF = to_date('" + DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss') "
					+ "WHERE ADR_ID = '" + adrid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//设置默认地址
		else if (act.equals("setdefaultadr")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String adrid = request.getParameter("adrid");
			sql = "UPDATE CBT_USERADR SET ADR_DEFAULT = 'F' WHERE ADR_UID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				sql = "UPDATE CBT_USERADR SET ADR_DEFAULT = 'T' WHERE ADR_ID = '" + adrid + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					rel = "<script>window.location.href='" + request.getContextPath() + "/user/myadr.jsp'</script>";
				} else {
					rel = "<script>alert('设置失败，请稍后再试');window.location.href='" + request.getContextPath() + "/user/myadr.jsp'</script>";
				}
				IOManager.write(rel, response);
			}
		}
		
		//检查是否设置了默认地址
		else if (act.equals("getdefaultadr")) {
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT ADR_ID FROM CBT_USERADR WHERE ADR_UID = '" + userid + "' and ADR_DEFAULT = 'T'";
			rel = DBManager.queryCol(sql, "ADR_ID");
			IOManager.write(rel, response);
		}
		
	}

}
