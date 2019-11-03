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
     * �Զ���¼�����ʼ������
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public AutoLogin() {
        super();
    }

	/**
	 * �Զ���¼����GET���ͷ���
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * �Զ���¼����POST���ͷ���
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
				//Cookie�洢����
				sql = "select U_ID, U_NAME, U_ENABLE from CBT_USER where U_EMAIL = '" + aEmail + "' and U_PW = '" + aPassword + "'";
				username = DBManager.queryCol(sql, "U_NAME");
				if (username != null) {
					//�û���������ȷ
					userid = DBManager.queryCol(sql, "U_ID");
					rel = DBManager.queryCol(sql, "U_ENABLE");
					if (rel.equals("T")) {
						//�û�״̬����
						sql = "select R_SIGN from CBT_ROLE r inner join CBT_USER u on u.u_id = r.r_uid "
								+ "where u.u_email = '" + aEmail + "' order by R_SIGN";	//ͬʱ���û��͹���ԱȨ��ʱ����Ա��A������
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
						//�û�������
						System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] <" + aEmail + "> have been disabled.");	
						rel = "F";
					}
				} else {
					//�û����������
					System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] <" + aEmail + "> autologin failed by wrong username/password.");	
					rel = "F";
				}				
			} else {
				//Cookieδ��
				System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] Never save cookie for autologin.");
				rel = "F";
			}
		} else {
			//cookie�б��
			System.out.println("[AutoLogin][F][" + DataManager.getCurrDateTime() + "] Never save cookie for autologin.");
			rel = "F";
		}
		IOManager.write(rel, response);
	}
}
