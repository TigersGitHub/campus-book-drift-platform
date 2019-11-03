package com.cbdts.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbdts.commons.DBManager;
import com.cbdts.commons.DataManager;
import com.cbdts.commons.IOManager;

public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
     * 登录服务初始化方法
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public Login() {
        super();
    }

    /**
	 * 登录服务GET类型处理方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 登录服务POST类型处理方法
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String username = null;
		String userid = null;
		String auto	= request.getParameter("auto");
		String rel = "";		
		String sql = "select U_ID, U_NAME, U_ENABLE from CBT_USER where U_EMAIL = '" + email + "' and U_PW = '" + password + "'";
		
		username = DBManager.queryCol(sql, "U_NAME");
		userid = DBManager.queryCol(sql, "U_ID");
		if (username != null) {
			if (DBManager.queryCol(sql, "U_ENABLE").equals("T")) {
				sql = "select R_SIGN from CBT_ROLE r inner join CBT_USER u on u.u_id = r.r_uid "
						+ "where u.u_email = '" + email + "' order by R_SIGN";
	
				String sign = DBManager.queryCol(sql, "R_SIGN");
				request.getSession().setAttribute("online", "true");
				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("userid", userid);
				request.getSession().setAttribute("sign", sign);
							
				if (auto.equals("auto")) {
					Cookie aEmail = new Cookie("aEmail", email); 
					Cookie aPassword = new Cookie("aPassword", password); 
					Cookie status = new Cookie("CBDTSAutoLogin", "true");
					aEmail.setMaxAge(604800);
					aPassword.setMaxAge(604800);
					status.setMaxAge(604800);
					response.addCookie(aEmail);
					response.addCookie(aPassword);
					response.addCookie(status);
					System.out.println("[AutoLogin] Autologin cookie has been saved.");
				} else {
					Cookie status = new Cookie("CBDTSAutoLogin", "false");
					status.setMaxAge(604800);
					response.addCookie(status);
					System.out.println("[AutoLogin] User refused to save autologin cookie.");
				}
	
				if (sign.equals("U")) {
					rel = "user";
					System.out.println("[Login][S][" + DataManager.getCurrDateTime() + "] User <" + email + "> login succeed.");		
				} else if (sign.equals("A")) {
					rel = "admin";
					System.out.println("[Login][S][" + DataManager.getCurrDateTime() + "] Admin <" + email + "> login succeed.");						
				}
			} else {
				rel = "disabled";
				System.out.println("[Login][F][" + DataManager.getCurrDateTime() + "] <" + email + "> have been disabled.");	
			}				
		} else {
			rel = "error";	
			System.out.println("[Login][F][" + DataManager.getCurrDateTime() + "] <" + email + "> login failed by wrong Email/Password.");			
		}
		IOManager.write(rel, response);			
	}
}
