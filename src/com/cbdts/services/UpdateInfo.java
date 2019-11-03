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
 * 信息维护服务
 * Servlet implementation class UpdateInfo
 * @author ShenHongtai
 */
public class UpdateInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 信息维护服务初始化方法
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public UpdateInfo() {
        super();
    }

	/**
	 * 信息维护服务GET方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 信息维护服务POST方法
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
		
		if (act.equals("createAdvice")) {
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String author = (String)request.getSession().getAttribute("email");
			String no = "ADV" + DataManager.getCurrDateNosplit();
			
			sql = "select U_ID from CBT_USER where U_EMAIL = '" + author + "'";
			author = DBManager.queryCol(sql, "U_ID");
			
			sql = "select to_char(CBS_ADVICE.Nextval, 'fm0000') as ADVNO from dual";
			no += DBManager.queryCol(sql, "ADVNO");
						
			sql = "insert into CBT_ADVICE (ADV_ID, ADV_TITLE, ADV_CONTENT, ADV_AUTHOR, ADV_ADDTIME) values "
					+ "('" + no + "', '" + title + "', '" + content + "', '" + author + "', " 
					+ "to_date('" + DataManager.getCurrDateTime() + "', 'yyyy-MM-dd HH24:mi:ss'))";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "success";
			} else {
				rel = row + "";
			}
			IOManager.write(rel, response);
		}
	}
	
}
