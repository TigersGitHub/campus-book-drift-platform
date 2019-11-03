package com.cbdts.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbdts.commons.DataManager;

public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 注销服务初始化方法
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public Logout() {
        super();
    }

	/**
	 * 注销服务GET类型方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 注销服务POST类型方法
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		Cookie aEmail = new Cookie("aEmail", null); 
		Cookie aPassword = new Cookie("aPassword", null); 
		Cookie autoLogin = new Cookie("CBDTSAutoLogin", null);
		aEmail.setMaxAge(0);
		aPassword.setMaxAge(0);
		autoLogin.setMaxAge(0);
		response.addCookie(aEmail);
		response.addCookie(aPassword);
		response.addCookie(autoLogin);
		
		request.getSession().setAttribute("online", "false");
		request.getSession().setAttribute("email", null);
		request.getSession().setAttribute("username", null);
		request.getSession().setAttribute("sign", null);
		
		System.out.println("[Logout][S][" + DataManager.getCurrDateTime() + "] Admin <" + 
				request.getSession().getAttribute("email") + "> logout succeed.");						
		
		response.sendRedirect(request.getContextPath());
	}
}
