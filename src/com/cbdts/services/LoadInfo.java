package com.cbdts.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cbdts.commons.DBManager;
import com.cbdts.commons.DataManager;
import com.cbdts.commons.IOManager;

public class LoadInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * ��Ϣ���ط����ʼ������
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public LoadInfo() {
        super();
    }

	/**
	 * ��Ϣ���ط���GET����
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * ��Ϣ���ط���POST����
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String act = request.getParameter("act");
		String rel = "";		
		String sql = "";
		
		//��ѯͼ������
		if (act.equals("blang")) {
			sql = "select LAN_ID, LAN_NAME from CBT_BLANG order by abs(LAN_ID)";
		}
		
		//��ѯͼ����
		if (act.equals("bfmt")) {
			sql = "select FMT_ID, FMT_NAME from CBT_BFMT order by abs(FMT_ID)";
		}
				
		//�����̲�ѯ
		if (act.equals("corp")) {
			sql = "select CORP_ID, CORP_NAME from CBT_CORPORATION order by abs(CORP_ID)";
		}
		
		//ͼ������ѯ
		if (act.equals("btype")) {
			sql = "select TYP_ID, TYP_NAME from CBT_BTYPE order by abs(TYP_ID)";
		}	
		
		//�ֲ���ѯ
		if (act.equals("carousel")) {
			sql = "select CSL_SRC, CSL_TARGET, CSL_NOTE from CBT_CAROUSEL order by abs(CSL_ID)";
		}	
		
		//��ҳ֪ͨ��ѯ
		if (act.equals("latestnotice")) {
			sql = "select NTC_ID, NTC_TYPE, NTC_TITLE from ("
					+ "select NTC_ID, NTC_TYPE, NTC_TITLE from CBT_NOTICE n order by NTC_ADDTIME desc"
					+ ") where rownum <= 6";
		}	
		
		//��ҳ֪ͨ�б��ѯ
		if (act.equals("noticelist")) {
			int page = Integer.parseInt(request.getParameter("page"));
			String type = request.getParameter("type");
			String extSql = "";
			if (type.equals("N")) {
				extSql = "where NTC_TYPE = 'N'";
			}
			if (type.equals("A")) {
				extSql = "where NTC_TYPE = 'A'";				
			}
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "select NTC_ID, NTC_TYPE, NTC_TITLE, to_char(NTC_ADDTIME, 'yyyy-mm-dd') as ADDTIME from CBT_NOTICE n "
					+ extSql + " order by NTC_ADDTIME desc"
				+ ") a1) a2 where rn <= " + (page * 10) + " and rn > " + (page * 10 - 10);
		}
		
		//֪ͨҳ���ѯ
		if (act.equals("noticetotalpage")) {
			String type = request.getParameter("type");
			sql = "select ceil(count(NTC_ID)/10) as TOTALPAGE from CBT_NOTICE";
			if (type.equals("N")) {
				sql += " where NTC_TYPE = 'N'";
			}
			if (type.equals("A")) {
				sql += " where NTC_TYPE = 'A'";				
			}
		}
		
		//֪ͨ������ת����
		if (act.equals("noticejump")) {
			String no = request.getParameter("no");
			request.getSession().setAttribute("noticeno", no);
			response.sendRedirect(request.getContextPath() + "/notice/article.jsp");
			return;
		}
		
		//֪ͨ���ݲ�ѯ
		if (act.equals("noticecontent")) {
			String no = null;
			try {
				if ((String)request.getSession().getAttribute("noticeno") != null) {
					no = (String)request.getSession().getAttribute("noticeno");
				} else {
					IOManager.write("back", response);
					return;
				}
			} catch (Exception e) {
				System.out.println("[Load][F][" + DataManager.getCurrDateTime() + "] User jump for notice without id");
			}
			sql = "select n.NTC_TITLE, n.NTC_TYPE, u.U_NAME as AUTHOR, to_char(n.NTC_ADDTIME, "
					+ "'yyyy-mm-dd hh24:mi:ss') as ADDTIME, n.NTC_CONTENT from CBT_NOTICE n "
					+ "inner join CBT_USER u on n.NTC_AUTHOR = u.U_ID where NTC_ID = '" + no + "'"; 
		}
		
		//��ҳ�����б��ѯ
		if (act.equals("helplist")) {
			int page = Integer.parseInt(request.getParameter("page"));
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "select HELP_ID, HELP_TITLE, to_char(HELP_ADDTIME, 'yyyy-mm-dd') as ADDTIME "
					+ "from CBT_HELP n order by HELP_ADDTIME desc"
				+ ") a1) a2 where rn <= " + (page * 10) + " and rn > " + (page * 10 - 10);
		}
		
		//����ҳ���ѯ
		if (act.equals("helptotalpage")) {
			sql = "select ceil(count(HELP_ID)/10) as TOTALPAGE from CBT_HELP";
		}
		
		//��������ҳ��ת
		if (act.equals("helpjump")) {
			String no = request.getParameter("no");
			request.getSession().setAttribute("helpno", no);
			response.sendRedirect(request.getContextPath() + "/help/article.jsp");
			return;
		}
		
		//�������ݲ�ѯ
		if (act.equals("helpcontent")) {
			String no = null;
			try {
				if ((String)request.getSession().getAttribute("helpno") != null) {
					no = (String)request.getSession().getAttribute("helpno");
				} else {
					IOManager.write("back", response);
					return;
				}
			} catch (Exception e) {
				System.out.println("[Load][F][" + DataManager.getCurrDateTime() + "] User jump for help without id");
			}
			sql = "select n.HELP_TITLE, u.U_NAME as AUTHOR, to_char(n.HELP_ADDTIME, 'yyyy-mm-dd hh24:mi:ss') as ADDTIME, "
					+ "n.HELP_CONTENT from CBT_HELP n inner join CBT_USER u on n.HELP_AUTHOR = u.U_ID "
					+ "where HELP_ID = '" + no + "'"; 
		}
		
		//��ҳ�����б��ѯ
		if (act.equals("advicelist")) {
			int page = Integer.parseInt(request.getParameter("page"));
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "select ADV_ID, ADV_TITLE, to_char(ADV_ADDTIME, 'yyyy-mm-dd') as ADDTIME "
					+ "from CBT_ADVICE n where ADV_ENABLE = 'T' order by ADV_ADDTIME desc"
				+ ") a1) a2 where rn <= " + (page * 10) + " and rn > " + (page * 10 - 10);
		}
		
		//����ҳ���ѯ
		if (act.equals("advicetotalpage")) {
			sql = "select ceil(count(ADV_ID)/10) as TOTALPAGE from CBT_ADVICE where ADV_ENABLE = 'T'";
		}
		
		//��������ҳ��ת
		if (act.equals("advicejump")) {
			String no = request.getParameter("no");
			request.getSession().setAttribute("adviceno", no);
			response.sendRedirect(request.getContextPath() + "/advice/article.jsp");
			return;
		}
		
		//�������ݲ�ѯ
		if (act.equals("advicecontent")) {
			String no = null;
			try {
				if ((String)request.getSession().getAttribute("adviceno") != null) {
					no = (String)request.getSession().getAttribute("adviceno");
				} else {
					IOManager.write("back", response);
					return;
				}
			} catch (Exception e) {
				System.out.println("[Load][F][" + DataManager.getCurrDateTime() + "] User jump for advice without id");
			}
			sql = "select n.ADV_ID, n.ADV_TITLE, u.U_NAME as AUTHOR, to_char(n.ADV_ADDTIME, 'yyyy-mm-dd hh24:mi:ss') as ADDTIME, "
					+ "n.ADV_CONTENT, n.ADV_REAUTHOR from CBT_ADVICE n inner join CBT_USER u on n.ADV_AUTHOR = u.U_ID "
					+ "where ADV_ID = '" + no + "'"; 
		}
		
		//����ظ���ѯ
		if (act.equals("advicereply")) {
			String advid = request.getParameter("advid");
			sql = "select u.U_NAME as REAUTHOR, to_char(n.ADV_RETIME, 'yyyy-mm-dd hh24:mi:ss') as RETIME, "
					+ "n.ADV_REPLY as REPLY from CBT_ADVICE n inner join CBT_USER u on n.ADV_REAUTHOR = u.U_ID "
					+ "where n.ADV_ID = '" + advid + "'";
		}
		
		rel = DBManager.queryJson(sql);
		IOManager.write(rel, response);
	}
}
