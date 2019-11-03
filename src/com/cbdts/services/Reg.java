package com.cbdts.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbdts.commons.DBManager;
import com.cbdts.commons.DataManager;
import com.cbdts.commons.IOManager;

public class Reg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 注册服务初始化方法
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public Reg() {
        super();
    }

	/**
	 * 注册服务GET类型处理方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 注册服务POST类型处理方法
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String rel = "";		
		String sql = "";
		String act = request.getParameter("act");
		
		//注册页面Email唯一性
		if (act.equals("chkemail")) {
			String email = request.getParameter("email");
			sql = "select 1 from CBT_USER where U_EMAIL = '" + email + "'";
		}
		
		//注册页面手机号码唯一性
		if (act.equals("chkmobile")) {
			String tel = request.getParameter("tel");
			sql = "select 1 from CBT_USER where U_MOBILE = '" + tel + "'";		
		}	
		
		//注册页面密码复杂度
		if (act.equals("chkpw")) {
			String pw = request.getParameter("pw");
			sql = "select 1 from CBT_POORPW where PPW_ENABLE = 'T' and PPW_PW = '" + pw + "'";		
		}
		
		//重置密码步骤一
		if (act.equals("chkreset")) {
			String email = request.getParameter("email");
			String tel = request.getParameter("tel");
			sql = "select 1 from CBT_USER where U_EMAIL = '" + email + "' and U_MOBILE = '" + tel + "'";
		}

		//数据存在性通用查询
		if (act.substring(0, 3).equals("chk")) {
			rel = DBManager.queryCol(sql, "1");
			if ("1".equals(rel)) {
				rel = "exist";
			} else {
				rel = "new";
			}
			IOManager.write(rel, response);
		}
		
		//重置密码步骤二
		if (act.equals("reset")) {
			String email = request.getParameter("email");
			String pw = request.getParameter("pw");
			sql = "update CBT_USER set U_PW = '" + pw + "' where U_EMAIL = '" + email + "'";
			
			int row = DBManager.update(sql);
			if (row > 0) {
				rel = "succeed";
				System.out.println("[Reset][S][" + DataManager.getCurrDateTime() + "] <" + email + "> reset password succeed.");
			} else {
				rel = "failed";
				System.out.println("[Reset][F][" + DataManager.getCurrDateTime() + "] <" + email + "> reset password failed.");
			}
			IOManager.write(rel, response);
		}
		
		//注册页面加载院校
		if (act.equals("loaddept")) {
			String parentid = request.getParameter("parentid");
			sql = "select DEPT_ID, DEPT_NAME from CBT_DEPT where DEPT_PARENT = " + parentid + " order by abs(DEPT_ID)";
			
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//注册
		if (act.equals("reg")) {
			String email = request.getParameter("email");
			String tel = request.getParameter("tel");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String sex = request.getParameter("sex");
			String dept3 = request.getParameter("dept3");
			String age = request.getParameter("age");
			String hometown = request.getParameter("hometown");	
			String time = DataManager.getCurrDateTime();	
			String newid = "";
			
			if (age == "" || age == null) {
				age = "''";
			}
			
			sql = "select CBS_USER.Nextval as NEWID from dual";
			newid = DBManager.queryCol(sql, "NEWID");
				
			sql = "insert into CBT_USER values ('" + newid + "', '" + email + "', '" + tel + "', '" + username + "', '" 
					+ password + "', '" + sex + "', '" + dept3 + "', " + age + ", '" + hometown + "', " 
					+ "to_date('" + time + "','yyyy-MM-dd HH24:mi:ss')" + ", 100, 'T', '', '')";
			
			int row = DBManager.update(sql);
			if (row > 0) {
				sql = "insert into CBT_ROLE values ('" + newid + "', '" + newid + "', 'U')";
				row = DBManager.update(sql);
				if (row > 0) {
					rel = "succeed";
					System.out.println("[Reg][S][" + DataManager.getCurrDateTime() + "] User <" + email + "> registe succeed.");					
				} else {
					rel = "failed";
					System.out.print("[Reg][F][" + DataManager.getCurrDateTime() + "] User <" + email + "> grant role failed, rolling back...");
					sql = "delete from CBT_USER where U_ID = '" + newid + "'";
					row = DBManager.update(sql);
					if (row > 0) {
						System.out.println("done.");
					} else {
						System.out.println("failed.");
					}
				}
			} else {
				rel = "failed";
				System.out.println("[Reg][F][" + DataManager.getCurrDateTime() + "] User <" + email + "> registe failed.");
			}
			IOManager.write(rel, response);
		}
	}
}
