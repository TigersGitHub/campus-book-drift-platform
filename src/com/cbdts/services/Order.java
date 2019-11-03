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
 * ����ͨ�÷���
 * Servlet implementation class Order
 * @author ShenHongtai
 */
public class Order extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * ����ͨ�÷����ʼ��
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public Order() {
        super();
    }

	/**
	 * ����ͨ�÷���GET����
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * ����ͨ�÷���POST����
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
		
		//ȷ���µ�ҳ�����
		if (act.equals("beforeorder")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bookid = request.getParameter("bookid");
			sql = "SELECT a.adr_uname, a.adr_phone, o1.org_name as ADR_PROV, o2.org_name as ADR_CITY, o3.org_name as ADR_DIST, "
					+ "a.adr_address, a.adr_zipcode, b.book_isbn, b.book_name_ch, b.book_name_en, b.book_author_ch, b.book_author_en, "
					+ "b.book_press, decode(b.book_cover, 'P', 'ƽװ', '��װ') as BOOK_COVER, b.book_version, b.book_sellprice, b.book_isexist, "
					+ "b.book_enable, b.book_image, b.book_seller, u.u_name as BOOK_SELLERNAME FROM CBT_BOOK b "
					+ "LEFT OUTER JOIN CBT_USER u ON u.u_id = b.book_seller "
					+ ", CBT_USERADR a "
					+ "LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov "
					+ "LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city "
					+ "LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist "
					+ "WHERE b.BOOK_ID = '" + bookid + "' and a.adr_uid = '" + userid + "' and a.adr_default = 'T' and a.adr_enable = 'T'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//���ؿ�ѡ��ַ�б�
		else if (act.equals("loadadrlist")) {
			String userid = (String)request.getSession().getAttribute("userid");
			sql = "SELECT a.adr_id, a.adr_default, a.adr_uname, a.adr_phone, o1.org_name as ADR_PROV, o2.org_name as ADR_CITY, "
					+ "o3.org_name as ADR_DIST, a.adr_address, a.adr_zipcode FROM CBT_USERADR a "
					+ "LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov "
					+ "LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city "
					+ "LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist "
					+ "WHERE a.adr_uid = '" + userid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//����Ĭ�ϵ�ַ
		else if (act.equals("setdefaultadr")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String adrid = request.getParameter("adrid");
			sql = "UPDATE CBT_USERADR SET ADR_DEFAULT = 'F' WHERE ADR_UID = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				sql = "UPDATE CBT_USERADR SET ADR_DEFAULT = 'T' WHERE ADR_ID = '" + adrid + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					rel = "success";
				} else {
					rel = "failed";
				}
				IOManager.write(rel, response);
			}
		}

		//�µ�
		else if (act.equals("order")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bookid = request.getParameter("bookid");
			String msg = request.getParameter("msg");
			String ordway = request.getParameter("ordway");
			String ordid = "";
			//1 �¼�Ŀ��ͼ��
			sql = "UPDATE CBT_BOOK SET BOOK_ISEXIST = 'N' WHERE BOOK_ID = '" + bookid + "' and BOOK_ISEXIST = 'Y'";
			row = DBManager.update(sql);
			if (row > 0) {
				//2 ���ɶ�����
				sql = "SELECT trim(to_char(CBS_ORDER.NEXTVAL, '0000')) as ORDID FROM DUAL";
				ordid = "ORD" + DataManager.getCurrDateNosplit() + DBManager.queryCol(sql, "ORDID");
				
				//3 ���ɶ���
				sql = "INSERT INTO CBT_ORDER VALUES ('" + ordid + "', '" + bookid + "', (SELECT book_seller FROM CBT_BOOK "
						+ "WHERE book_id = '" + bookid + "'), '" + userid + "', (SELECT a.ADR_ID FROM CBT_USERADR a "
						+ "WHERE a.adr_uid = '" + userid + "' and a.adr_default = 'T'), to_date('" + DataManager.getCurrDateTime() 
						+ "', 'yyyy-mm-dd hh24:mi:ss'), '', '" + ordway + "', '', 'F', 'F', '1', '" + msg + "', '', '')";
				row = DBManager.update(sql);
				if (row > 0) {
					//4 ���Ӧ������ת����ҳ��
					sql = "SELECT BOOK_SELLPRICE FROM CBT_BOOK WHERE BOOK_ID = '" + bookid + "'";
					if (Double.parseDouble(DBManager.queryCol(sql, "BOOK_SELLPRICE")) == 0.0) {
						//����֧��
						sql = "UPDATE CBT_ORDER o SET o.ord_status = '2' WHERE o.ord_id = '" + ordid + "'";
						row = DBManager.update(sql);
						if (row > 0) {
							//�µ����
							IOManager.write("DONE", response);
							return;
						} else {
							//���Ķ���״̬ʧ��
							IOManager.write("Ư�������Զ�������������ʧ��", response);
							//�ͷ�ͼ��
							sql = "UPDATE CBT_BOOK SET BOOK_ISEXIST = 'Y' WHERE BOOK_ID = '" + bookid + "'";
							DBManager.update(sql);
							return;
						}
					} else {
						//��Ҫ֧��
						IOManager.write("PAY" + ordid, response);
						return;
					}
				} else {
					//3-ERR ���ɶ���ʧ��
					IOManager.write("���ɶ���ʧ��", response);
					//�ͷ�ͼ��
					sql = "UPDATE CBT_BOOK SET BOOK_ISEXIST = 'Y' WHERE BOOK_ID = '" + bookid + "'";
					DBManager.update(sql);
					return;
				}
			} else {
				//1-ERR ͼ���¼�ʧ��
				IOManager.write("ͼ���ѱ��������¼�", response);
				return;
			}
		}
		
		//������Ϣ����
		else if (act.equals("beforecheckout")) {
			String ordid = request.getParameter("orderid");
			sql = "SELECT ORD_ID, BOOK_NAME_CH AS ORD_BOOKNAME, BOOK_SELLPRICE AS ORD_PRICE FROM CBT_ORDER "
					+ "INNER JOIN CBT_BOOK ON BOOK_ID = ORD_BOOKID WHERE ORD_ID = '" + ordid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//����
		else if (act.equals("checkout")) {
			String ordid = request.getParameter("orderid");
			sql = "UPDATE CBT_ORDER o SET o.ord_status = '2' WHERE o.ord_id = '" + ordid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				//�µ����
				IOManager.write("DONE", response);
			} else {
				//���Ķ���״̬ʧ��
				IOManager.write("֧��ʧ�ܣ������Ѿ�����ʽ�ԭ·�˻�", response);
			}
		}
		
		//������Ϣ��״̬����
		else if (act.equals("loadorderbystatus")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String status = request.getParameter("status");
			sql = "SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi') as ORD_TIME, b.book_sellprice as ORD_PRICE, "
					+ "a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) "
					+ "as ORD_ADDRESS, b.book_name_ch||' '||b.book_author_ch||' ��' as ORD_TITLE, o.ord_status, o.ord_selcom, "
					+ "o.ord_cuscom, decode(o.ord_status, '1', '������', '2', '������', '3', '���ջ�', '4', '������') "
					+ "as ORD_STATUSNAME FROM CBT_ORDER o "
					+ "INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ "INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid "
					+ "LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov "
					+ "LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city "
					+ "LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist "
					+ "WHERE o.ord_customer = '" + userid + "' "
					+ ((status.equals("2") || status.equals("3"))?"and o.ord_status in ('2', '3') ":"and o.ord_status = '" + status + "' ")
					+ "ORDER BY o.ord_ordtime desc";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//�����̨�����б����
		else if (act.equals("loadcomformgr")) {
			String type = request.getParameter("type");
			String ordid = request.getParameter("ordid");
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			String page = request.getParameter("page");
			
			String searchitems = "WHERE 1=1";
			if (ordid.length() > 0) {
				searchitems += " and COM_ORDID like '%" + ordid + "%'";
			}
			if ("0".equals(type) == false) {
				searchitems += " and COM_TYPE = '" + type + "'";
			}
			if (starttime.length() > 0) {
				searchitems += " and COM_TIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and COM_TIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT c.com_id, o.ord_id as com_order, b.book_id as com_book, to_char(c.com_time, 'yyyy-mm-dd hh24:mi') as "
					+ "com_time, c.com_userid, u.u_name as com_username, decode(c.com_type, 'G', '����', 'B', '����') as com_type, "
					+ "c.com_comment, b.book_name_ch||' '||b.book_author_ch||' �� '||b.book_press as com_bookinfo FROM CBT_COMMENT c "
					+ "INNER JOIN CBT_ORDER o ON o.ord_id = c.com_ordid "
					+ "INNER JOIN CBT_BOOK b on o.ord_bookid = b.book_id "
					+ "INNER JOIN CBT_USER u ON u.u_id = c.com_userid "
					+ searchitems + " ORDER BY COM_TIME desc"
				+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);			
			System.out.println(sql);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//�����̨�����б��ҳ�������
		else if (act.equals("mgrcomtotalpage")) {
			String type = request.getParameter("type");
			String ordid = request.getParameter("ordid");
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			
			String searchitems = "WHERE 1=1";
			if (ordid.length() > 0) {
				searchitems += " and COM_ORDID like '%" + ordid + "%'";
			}
			if ("0".equals(type) == false) {
				searchitems += " and COM_TYPE = '" + type + "'";
			}
			if (starttime.length() > 0) {
				searchitems += " and COM_TIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and COM_TIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "SELECT ceil(count(o.COM_ID)/10) as TOTALPAGE FROM CBT_COMMENT o " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//�����̨�����б����
		else if (act.equals("loadorderformgr")) {
			String issell = request.getParameter("issell");
			String status = request.getParameter("status");
			String ordid = request.getParameter("ordid");
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			String page = request.getParameter("page");
			
			String searchitems = "WHERE 1=1";
			if (ordid.length() > 0) {
				searchitems += " and ORD_ID like '%" + ordid + "%'";
			}
			if ("0".equals(status) == false) {
				searchitems += " and ORD_STATUS = '" + status + "'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if (starttime.length() > 0) {
				searchitems += " and ORD_ORDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and ORD_ORDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi') as ORD_TIME, b.book_sellprice as ORD_PRICE, "
					+ "a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) "
					+ "as ORD_ADDRESS, b.book_name_ch||' '||b.book_author_ch||' ��' as ORD_TITLE, o.ord_status, o.ord_selcom, "
					+ "o.ord_cuscom, decode(o.ord_status, '1', '������', '2', '������', '3', '���ջ�', '4', '������', '5', '�����', '6', '�ѹر�') "
					+ "as ORD_STATUSNAME FROM CBT_ORDER o "
					+ "INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ "INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid "
					+ "LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov "
					+ "LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city "
					+ "LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist "
					+ searchitems + " ORDER BY o.ord_ordtime desc"
				+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);			
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//�����̨�����б��ҳ�������
		else if (act.equals("mgrordtotalpage")) {
			String issell = request.getParameter("issell");
			String status = request.getParameter("status");
			String ordid = request.getParameter("ordid");
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			
			String searchitems = "WHERE 1=1";
			if (ordid.length() > 0) {
				searchitems += " and ORD_ID like '%" + ordid + "%'";
			}
			if ("0".equals(status) == false) {
				searchitems += " and ORD_STATUS = '" + status + "'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if (starttime.length() > 0) {
				searchitems += " and ORD_ORDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and ORD_ORDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "SELECT ceil(count(o.ORD_ID)/10) as TOTALPAGE FROM CBT_ORDER o INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//ȡ������
		else if (act.equals("cancelorder")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String ordid = request.getParameter("orderid");
			sql = "UPDATE CBT_ORDER o SET o.ord_status = '6', o.ord_finishtime = to_date('" + DataManager.getCurrDateTime() + 
					"', 'yyyy-mm-dd hh24:mi:ss') WHERE ORD_ID = '" + ordid + "' and ORD_CUSTOMER = '" + userid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				sql = "UPDATE CBT_BOOK SET BOOK_ISEXIST = 'Y' WHERE BOOK_ID = (SELECT o.ord_bookid FROM CBT_ORDER o "
						+ "WHERE o.ord_id = '" + ordid + "')";
				row = DBManager.update(sql);
				if (row > 0) {
					rel = "<script>window.location.href='" + request.getContextPath() + "/user'</script>";
				} else {
					rel = "<script>alert('�����ϼ�ͼ��ʧ�ܣ�����ϵ����Ա');window.location.href='" + request.getContextPath() + "/user'</script>";
				}
			} else {
				rel = "<script>alert('ȡ������ʧ�ܣ����Ժ�����');window.location.href='" + request.getContextPath() + "/user'</script>";
			}
			IOManager.write(rel, response);			
		}
		
		//������ϸ��Ϣ
		else if (act.equals("orderdetail")) {
			String ordid = request.getParameter("orderid");
			sql = "SELECT ord_status from CBT_ORDER where ORD_ID = '" + ordid + "'";
			int ord_status = Integer.parseInt(DBManager.queryCol(sql, "ORD_STATUS"));
			sql = "SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi:ss') as ORD_TIME, b.book_sellprice as ORD_PRICE, "
					+ "a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) "
					+ "as ORD_ADDRESS, a.adr_zipcode as ORD_ZIPCODE, b.book_id, b.book_name_ch||'��'||b.book_version||'��'||"
					+ "b.book_author_ch||' �� '||b.book_press as ORD_TITLE, o.ord_status, decode(o.ord_status, '1', '������', '2', "
					+ "'������', '3', '���ջ�', '4', '������', '5', '�����', '6', '�ѹر�') as ORD_STATUSNAME, decode(o.ord_ordway, "
					+ "'E', '��ݽ���', 'F', '���潻��') as ORD_ORDWAY, o.ord_msg, o.ord_expid, o.ord_expcorp, o.ord_seller, u.u_name "
					+ "as ORD_SELLERNAME, o.ord_customer, u2.u_name as ord_customername, ";
			if (ord_status == 5) {
				sql += "cs.com_comment as ord_selcom, cc.com_comment as ord_cuscom ";
			} else {
				sql += "o.ord_selcom, o.ord_cuscom ";
			}
			sql += "FROM CBT_ORDER o "
					+ "INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ "INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid "
					+ "INNER JOIN CBT_USER u ON u.u_id = o.ord_seller "
					+ "INNER JOIN CBT_USER u2 ON u2.u_id = o.ord_customer ";
			if (ord_status == 5) {
				sql += "INNER JOIN CBT_COMMENT cc ON o.ord_id = cc.com_ordid and cc.com_source = 'C' ";
				sql += "INNER JOIN CBT_COMMENT cs ON o.ord_id = cs.com_ordid and cs.com_source = 'S' ";
			}
			sql += "LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov "
					+ "LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city "
					+ "LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist "
					+ "WHERE ORD_ID = '" + ordid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//����ɶ�����ҳ����
		else if (act.equals("pastordertotalpage")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bname = request.getParameter("bname");
			String issell = request.getParameter("issell");
			String starttime = request.getParameter("starttime");
			String endtime  = request.getParameter("endtime");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if (starttime.length() > 0) {
				searchitems += " and ORD_ORDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and ORD_ORDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "SELECT ceil(count(o.ORD_ID)/10) as TOTALPAGE FROM CBT_ORDER o INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ "WHERE o.ord_customer = '" + userid + "' and o.ord_status in ('5', '6')" + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//����ɶ����б�
		else if (act.equals("pastorder")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bname = request.getParameter("bname");
			String issell = request.getParameter("issell");
			String starttime = request.getParameter("starttime");
			String endtime  = request.getParameter("endtime");
			String page = request.getParameter("page");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if (starttime.length() > 0) {
				searchitems += " and ORD_ORDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and ORD_ORDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi') as ORD_TIME, b.book_sellprice as ORD_PRICE, "
					+ "a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) "
					+ "as ORD_ADDRESS, b.book_name_ch||' '||b.book_author_ch||' ��' as ORD_TITLE, o.ord_status, "
					+ "decode(o.ord_status, '5', '�����', '6', '�ѹر�') as ORD_STATUSNAME FROM CBT_ORDER o "
					+ "INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ "INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid "
					+ "LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov "
					+ "LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city "
					+ "LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist "
					+ "WHERE o.ord_customer = '" + userid + "' and o.ord_status in ('5', '6')" + searchitems
					+ " ORDER BY o.ord_ordtime desc"
				+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//���۳�������ҳ����
		else if (act.equals("soldordertotalpage")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bname = request.getParameter("bname");
			String issell = request.getParameter("issell");
			String starttime = request.getParameter("starttime");
			String endtime  = request.getParameter("endtime");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if (starttime.length() > 0) {
				searchitems += " and ORD_ORDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and ORD_ORDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "SELECT ceil(count(o.ORD_ID)/10) as TOTALPAGE FROM CBT_ORDER o INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ "WHERE o.ord_seller = '" + userid + "'" + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		//���۳������б�
		else if (act.equals("soldorder")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String bname = request.getParameter("bname");
			String issell = request.getParameter("issell");
			String status = request.getParameter("status");
			String starttime = request.getParameter("starttime");
			String endtime = request.getParameter("endtime");
			String page = request.getParameter("page");
			
			String searchitems = "";
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if ("1".equals(status)) {
				searchitems += " and ORD_STATUS in ('1', '2', '3', '4')";
			} else if ("2".equals(status)) {
				searchitems += " and ORD_STATUS in ('5', '6')";
			}
			if (starttime.length() > 0) {
				searchitems += " and ORD_ORDTIME >= to_date('" + starttime + " 00:00:00', 'yyyy-mm-dd hh24:mi:ss')";
			}
			if (endtime.length() > 0) {
				searchitems += " and ORD_ORDTIME <= to_date('" + endtime + " 23:59:59', 'yyyy-mm-dd hh24:mi:ss')";
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi') as ORD_TIME, b.book_sellprice as ORD_PRICE, "
					+ "a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) "
					+ "as ORD_ADDRESS, b.book_name_ch||' '||b.book_author_ch||' ��' as ORD_TITLE, o.ord_status, o.ord_selcom, o.ord_cuscom, "
					+ "decode(o.ord_status, '1', '������', '2', '������', '3', '���ջ�', '4', '������', '5', '�����', '6', '�ѹر�') "
					+ "as ORD_STATUSNAME FROM CBT_ORDER o "
					+ "INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid "
					+ "INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid "
					+ "LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov "
					+ "LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city "
					+ "LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist "
					+ "WHERE o.ord_seller = '" + userid + "'" + searchitems
					+ " ORDER BY o.ord_ordtime desc"
				+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//����ҳ�潻�׷�ʽ����
		else if (act.equals("queryordway")) {
			String ordid = request.getParameter("orderid");
			sql = "select ORD_ORDWAY from CBT_ORDER where ORD_ID = '" + ordid + "'";
			rel = DBManager.queryCol(sql, "ORD_ORDWAY");
			IOManager.write(rel, response);
		}
		
		//����
		else if (act.equals("delivery")) {
			String ordid = request.getParameter("orderid");
			String ordway = request.getParameter("ordway");
			if (ordway.equals("F")) {
				sql = "UPDATE CBT_ORDER SET ORD_STATUS='3' WHERE ORD_ID = '" + ordid + "'";
			} else if (ordway.equals("E")) {
				String expid = request.getParameter("expid");
				String expcorp = request.getParameter("expcorp");
				sql = "UPDATE CBT_ORDER SET ORD_EXPID = '" + expid + "', ORD_EXPCORP = '" + expcorp + "', ORD_STATUS='3' "
						+ "WHERE ORD_ID = '" + ordid + "'";
			}
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>window.location.href='" + request.getContextPath() + "/user/mysold.jsp'</script>";
			} else {
				rel = "<script>alert('����ʧ�ܣ����Ժ�����');window.location.href='" + request.getContextPath() + "/user/mysold.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//ȷ���ջ�
		else if (act.equals("acceptorder")) {
			String ordid = request.getParameter("orderid");
			sql = "UPDATE CBT_ORDER SET ORD_STATUS = '4' WHERE ORD_ID = '" + ordid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>window.location.href='" + request.getContextPath() + "/user/index.jsp'</script>";
			} else {
				rel = "<script>alert('ȷ���ջ�ʧ�ܣ����Ժ�����');window.location.href='" + request.getContextPath() + "/user/index.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//������
		else if (act.equals("cuscomment")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String ordid = request.getParameter("orderid");
			String comtype = request.getParameter("comtype");
			String comment = request.getParameter("comment");
			sql = "SELECT ORD_SELCOM FROM CBT_ORDER WHERE ORD_ID = '" + ordid + "'";
			String selcom = DBManager.queryCol(sql, "ORD_SELCOM");
			if (selcom.equals("F")) {
				sql = "UPDATE CBT_ORDER SET ORD_CUSCOM = 'T' WHERE ORD_ID = '" + ordid + "'";
			} else if (selcom.equals("T")) {
				sql = "UPDATE CBT_ORDER SET ORD_CUSCOM = 'T', ORD_STATUS = '5' WHERE ORD_ID = '" + ordid + "'";
			}
			row = DBManager.update(sql);
			if (row > 0) {
				sql = "SELECT trim(to_char(CBS_COMMENT.NEXTVAL, '0000')) as COMID FROM DUAL";
				String comid = "COM" + DataManager.getCurrDateNosplit() + DBManager.queryCol(sql, "COMID");
				sql = "INSERT INTO CBT_COMMENT VALUES ('" + comid + "', '" + ordid + "', 'C', to_date('" 
						+ DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss'), '" + comtype + "', '" 
						+ comment + "', 'T', '', '" + userid + "')";
				row = DBManager.update(sql);
				if (row > 0) {
					rel = "<script>window.location.href='" + request.getContextPath() + "/user/index.jsp'</script>";
				} else {
					sql = "UPDATE CBT_ORDER SET ORD_CUSCOM = 'F', ORD_STATUS = '4' WHERE ORD_ID = '" + ordid + "'";
					DBManager.update(sql);
					rel = "<script>alert('�����ύʧ�ܣ����Ժ�����');window.location.href='" + request.getContextPath() + "/user/index.jsp'</script>";
				}
			} else {
				rel = "<script>alert('�������ʧ�ܣ����Ժ�����');window.location.href='" + request.getContextPath() + "/user/index.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//��������
		else if (act.equals("selcomment")) {
			String userid = (String)request.getSession().getAttribute("userid");
			String ordid = request.getParameter("orderid");
			String comtype = request.getParameter("comtype");
			String comment = request.getParameter("comment");
			sql = "SELECT ORD_CUSCOM FROM CBT_ORDER WHERE ORD_ID = '" + ordid + "'";
			String cuscom = DBManager.queryCol(sql, "ORD_CUSCOM");
			if (cuscom.equals("F")) {
				sql = "UPDATE CBT_ORDER SET ORD_SELCOM = 'T' WHERE ORD_ID = '" + ordid + "'";
			} else if (cuscom.equals("T")) {
				sql = "UPDATE CBT_ORDER SET ORD_SELCOM = 'T', ORD_STATUS = '5' WHERE ORD_ID = '" + ordid + "'";
			}
			row = DBManager.update(sql);
			if (row > 0) {
				sql = "SELECT trim(to_char(CBS_COMMENT.NEXTVAL, '0000')) as COMID FROM DUAL";
				String comid = "COM" + DataManager.getCurrDateNosplit() + DBManager.queryCol(sql, "COMID");
				sql = "INSERT INTO CBT_COMMENT VALUES ('" + comid + "', '" + ordid + "', 'S', to_date('" 
						+ DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss'), '" + comtype + "', '" 
						+ comment + "', 'T', '', '" + userid + "')";
				row = DBManager.update(sql);
				if (row > 0) {
					rel = "<script>window.location.href='" + request.getContextPath() + "/user/index.jsp'</script>";
				} else {
					sql = "UPDATE CBT_ORDER SET ORD_SELCOM = 'F', ORD_STATUS = '4' WHERE ORD_ID = '" + ordid + "'";
					DBManager.update(sql);
					rel = "<script>alert('�����ύʧ�ܣ����Ժ�����');window.location.href='" + request.getContextPath() + "/user/mysold.jsp'</script>";
				}
			} else {
				rel = "<script>alert('�������ʧ�ܣ����Ժ�����');window.location.href='" + request.getContextPath() + "/user/mysold.jsp'</script>";
			}
			IOManager.write(rel, response);
		}
		
		//���������б�
		else if (act.equals("loadcomment")) {
			String userid  = (String)request.getSession().getAttribute("userid");
			sql = "SELECT c.com_id, o.ord_id as com_order, b.book_id as com_book, to_char(c.com_time, 'yyyy-mm-dd hh24:mi') as "
					+ "com_time, c.com_userid, u.u_name as com_username, decode(c.com_type, 'G', '����', 'B', '����') as com_type, "
					+ "c.com_comment, b.book_name_ch||' '||b.book_author_ch||' �� '||b.book_press as com_bookinfo FROM CBT_COMMENT c "
					+ "INNER JOIN CBT_ORDER o ON o.ord_id = c.com_ordid "
					+ "INNER JOIN CBT_BOOK b on o.ord_bookid = b.book_id "
					+ "INNER JOIN CBT_USER u ON u.u_id = c.com_userid "
					+ "WHERE (c.com_source = 'C' and o.ord_seller = '" + userid + "') "
					+ "or (c.com_source = 'S' and o.ord_customer = '" + userid + "') "
					+ "and COM_ENABLE = 'T' and o.ord_status = '5' ORDER BY COM_TIME desc";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//�����б��ҳ
		else if (act.equals("commenttotalpage")) {
			String userid = (String)request.getSession().getAttribute("userid");			
			sql = "SELECT ceil(count(COM_ID)/10) as TOTALPAGE FROM CBT_COMMENT c INNER JOIN CBT_ORDER o ON o.ord_id = c.com_ordid "
					+ "WHERE (c.com_source = 'C' and o.ord_seller = '" + userid + "') or (c.com_source = 'S' and o.ord_customer = '" 
					+ userid + "') and COM_ENABLE = 'T' and o.ord_status = '5'";
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
	}

}
