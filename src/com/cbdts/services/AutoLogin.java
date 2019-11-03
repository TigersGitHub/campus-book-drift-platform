package com.cbdts.services;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbdts.commons.DBManager;
import com.cbdts.commons.DataManager;
import com.cbdts.commons.IOManager;

public class AutoLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 自动登录服务初始化方法
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public AutoLogin() {
        super();
    }

	/**
	 * 自动登录服务GET类型方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 自动登录服务POST类型方法
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");		
		Cookie[] autoRecord = request.getCookies();		
		String username = "";
		String userid = "";
		String sql = "";
		String aEmail = "";
		String aPassword = "";
		String status = "";	//Cookie: CBDTSAutoLogin
		String rel = "";
		
		if (autoRecord != null) {
			for (int i = 0; i < autoRecord.length; i++) {
				if ("CBDTSAutoLogin".equals(autoRecord[i].getName())) {
					status = autoRecord[i].getValue();
				}
				if ("aEmail".equals(autoRecord[i].getName())) {
					aEmail = autoRecord[i].getValue();
					aEmail = URLDecoder.decode(aEmail, "utf-8");
				}
				if ("aPassword".equals(autoRecord[i].getName())) {
					aPassword = autoRecord[i].getValue();
				}
			}
			
			if (status.equals("true")) {
				//Cookie存储正常
				sql = "select U_ID, U_NAME, U_ENABLE from CBT_USER where U_EMAIL = '" + aEmail + "' and U_PW = '" + aPassword + "'";
				username = DBManager.queryCol(sql, "U_NAME");
				if (username != null) {
					//用户名密码正确
					userid = DBManager.queryCol(sql, "U_ID");
					rel = DBManager.queryCol(sql, "U_ENABLE");
					if (rel.equals("T")) {
						//用户状态正常
						sql = "select R_SIGN from CBT_ROLE r inner join CBT_USER u on u.u_id = r.r_uid "
								+ "where u.u_email = '" + aEmail + "' order by R_SIGN";	//同时有用户和管理员权限时管理员（A）优先
						String sign = DBManager.queryCol(sql, "R_SIGN");					
						request.getSession().setAttribute("online", "true");
						request.getSession().setAttribute("email", aEmail);
						request.getSession().setAttribute("username", username);
						request.getSession().setAttribute("userid", userid);
						request.getSession().setAttribute("sign", sign);
						if (sign.equals("U")) {
							System.out.println("[AutoLogin][S][" + DataManager.getCurrDateTime() + "] User <" + aEmail + "> autologin succeed.");	
							rel = "U";
						} else if (sign.equals("A")) {
							System.out.println("[AutoLogin][S][" + DataManager.getCurrDateTime() + "] Admin <" + aEmail + "> autologin succeed.");	
							rel = "A";
						}
					} else {
						//用户被禁用
						System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] <" + aEmail + "> have been disabled.");	
						rel = "F";
					}
				} else {
					//用户名密码错误
					System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] <" + aEmail + "> autologin failed by wrong username/password.");	
					rel = "F";
				}				
			} else {
				//Cookie未存
				System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] Never save cookie for autologin.");
				rel = "F";
			}
		} else {
			//cookie列表空
			System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] Never save cookie for autologin.");
			rel = "F";
		}
		IOManager.write(rel, response);
	}
}
