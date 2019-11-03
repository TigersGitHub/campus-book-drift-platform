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
 * 字典通用服务
 * Servlet implementation class DctCommon
 * @author ShenHongtai
 */
public class DctCommon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 字典通用服务初始化
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public DctCommon() {
        super();
    }

	/**
	 * 字典通用服务Get
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * 字典通用服务Post
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
		
		//新增节点
		if (act.equals("add")) {
			//SQL选择
			String dct = request.getParameter("dct");
			if (dct.equals("dept")) {
				//院校专业字典
				String parent = request.getParameter("parent");
				String deptid = request.getParameter("deptid");
				String deptname = request.getParameter("deptname");
				String deptadr = request.getParameter("deptadr");	//可选
				String note = request.getParameter("note");			//可选
				sql = "insert into CBT_DEPT values ('" + deptid + "', '" + deptname + "', '" + parent + "', '";
				if (deptadr.length() > 0) {
					sql += deptadr;
				}
				sql += "', '";
				if (note.length() > 0) {
					sql += note;					
				}
				sql += "')";
				rel = request.getContextPath() + "/mgr/dictionary/dept.jsp";
			} else if (dct.equals("org")) {
				//组织机构字典
				String parent = request.getParameter("parent");
				String orgid = request.getParameter("orgid");
				String orgname = request.getParameter("orgname");
				String note = request.getParameter("note");			//可选
				sql = "insert into CBT_ORG values ('" + orgid + "', '" + orgname + "', '" + parent + "', '";
				if (note.length() > 0) {
					sql += note;					
				}
				sql += "')";		
				rel = request.getContextPath() + "/mgr/dictionary/org.jsp";
			} else if (dct.equals("lang")) {
				//图书语种字典
				String langname = request.getParameter("langname");
				String note = request.getParameter("note");
				sql = "insert into CBT_BLANG values (CBS_BLANG.nextval, '" + langname + "', '" + note + "')";
				rel = request.getContextPath() + "/mgr/dictionary/lang.jsp";
			} else if (dct.equals("format")) {
				//图书规格字典
				String fmtname = request.getParameter("fmtname");
				String note = request.getParameter("note");
				sql = "insert into CBT_BFMT values (CBS_BFMT.nextval, '" + fmtname + "', '" + note + "')";	
				rel = request.getContextPath() + "/mgr/dictionary/format.jsp";			
			} else if (dct.equals("corp")) {
				//合作商字典
				String corpname = request.getParameter("corpname");
				String shortname = request.getParameter("shortname");
				String linkman = request.getParameter("linkman");
				String tel = request.getParameter("tel");
				String address = request.getParameter("address");
				String note = request.getParameter("note");
				sql = "INSERT INTO CBT_CORPORATION VALUES (CBS_CORPORATION.NEXTVAL, '" + corpname + "', '" + linkman + 
						"', '" + tel + "', '" + address + "', '" + note + "', '" + shortname + "')";
				rel = request.getContextPath() + "/mgr/dictionary/corp.jsp";
			} else if (dct.equals("exp")) {
				//快递厂商字典
				String expid = request.getParameter("expid");
				String expname = request.getParameter("expname");
				String linkman = request.getParameter("linkman");
				String tel = request.getParameter("tel");
				String note = request.getParameter("note");
				sql = "INSERT INTO CBT_EXPRESS VALUES ('" + expid + "', '" + expname + "', '" + linkman + 
						"', '" + tel + "', '" + note + "')";
				rel = request.getContextPath() + "/mgr/dictionary/express.jsp";
			}
			
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(rel);
			} else {
				rel = "<script>alert('节点添加失败，Code：'" + row + ");</script>";
				IOManager.write(rel, response);				
			}
		}
		
		//删除节点
		if (act.equals("del")) {
			//SQL选择
			String dct = request.getParameter("dct");
			if (dct.equals("dept")) {
				//院校专业字典
				String deptid = request.getParameter("deptid");
				sql = "select 1 from CBT_DEPT where DEPT_PARENT = '" + deptid + "' group by 1";
				rel = DBManager.queryCol(sql, "1");
				if (rel == "1") {
					rel = "notleaf";
				} else {
					sql = "delete from CBT_DEPT where DEPT_ID = '" + deptid + "'";
					row = DBManager.update(sql);
					if (row > 0) {
						rel = "success";
						System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Delete Dept" + deptid + " succeed.");
					} else {
						rel = "failed";
						System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Delete Dept" + deptid + " failed.");
					}
				}
			} else if (dct.equals("org")) {
				//组织机构字典
				String orgid = request.getParameter("orgid");
				sql = "select 1 from CBT_ORG where ORG_PARENT = '" + orgid + "' group by 1";
				rel = DBManager.queryCol(sql, "1");				
				if (rel == "1") {
					rel = "notleaf";
				} else {
					sql = "delete from CBT_ORG where ORG_ID = '" + orgid + "'";
					row = DBManager.update(sql);
					if (row > 0) {
						rel = "success";
						System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Delete Org" + orgid + " succeed.");
					} else {
						rel = "failed";
						System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Delete Org" + orgid + " failed.");
					}
				}
			} else {
				String aimid = request.getParameter("aimid");
				if (dct.equals("lang")) {
					//图书语种字典
					sql = "delete from CBT_BLANG where LAN_ID = '" + aimid + "'";
				} else if (dct.equals("format")) {
					//图书规格字典
					sql = "delete from CBT_BFMT where FMT_ID = '" + aimid + "'";					
				} else if (dct.equals("corp")) {
					//合作商字典
					sql = "delete from CBT_CORPORATION where CORP_ID = '" + aimid + "'";
				}

				row = DBManager.update(sql);
				if (row > 0) {
					rel = "success";
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Delete " + dct + aimid + " succeed.");
				} else {
					rel = "failed";
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Delete " + dct + aimid + " failed.");
				}
			}
			IOManager.write(rel, response);
		}
		
		//编辑节点
		if (act.equals("edit")) {
			//SQL选择
			String dct = request.getParameter("dct");
			if (dct.equals("dept")) {
				//院校专业字典
				String deptid = request.getParameter("deptid");
				String deptname = request.getParameter("deptname");
				String deptadr = request.getParameter("deptadr");
				String deptnote = request.getParameter("deptnote");
				sql = "update CBT_DEPT set DEPT_NAME = '" + deptname + "', DEPT_ADDRESS = '" + deptadr 
						+ "', DEPT_NOTE = '" + deptnote + "' where DEPT_ID = '" + deptid + "'";				
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Update Dept"
							+ request.getParameter("deptid") + " succeed.");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/dept.jsp");
				} else {
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Update Dept" 
							+ request.getParameter("deptid") + " failed by " + row + ".");
					request.getSession().setAttribute("deptedit", request.getParameter("deptid"));
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/deptedit.jsp");				
				}
			} else if (dct.equals("org")) {
				//组织机构字典
				String orgid = request.getParameter("orgid");
				String orgname = request.getParameter("orgname");
				String orgnote = request.getParameter("orgnote");
				sql = "update CBT_ORG set ORG_NAME = '" + orgname + "', ORG_NOTE = '" + orgnote + "' where ORG_ID = '" + orgid + "'";				
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Update Org"
							+ request.getParameter("orgid") + " succeed.");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/org.jsp");
				} else {
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Update Org" 
							+ request.getParameter("orgid") + " failed by " + row + ".");
					request.getSession().setAttribute("orgedit", request.getParameter("orgid"));
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/orgedit.jsp");				
				}
			} else if (dct.equals("lang")) {
				//图书语种字典
				String langid = request.getParameter("langid");
				String langname = request.getParameter("langname");
				String langnote = request.getParameter("langnote");
				sql = "update CBT_BLANG set LAN_NAME = '" + langname + "', LAN_NOTE = '" + langnote + "' where LAN_ID = '" + langid + "'";				
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Update Lang"
							+ request.getParameter("langid") + " succeed.");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/lang.jsp");
				} else {
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Update Lang" 
							+ request.getParameter("langid") + " failed by " + row + ".");
					request.getSession().setAttribute("langedit", request.getParameter("langid"));
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/langedit.jsp");				
				}
			} else if (dct.equals("format")) {
				//图书规格字典
				String fmtid = request.getParameter("fmtid");
				String fmtname = request.getParameter("fmtname");
				String fmtnote = request.getParameter("fmtnote");
				sql = "update CBT_BFMT set FMT_NAME = '" + fmtname + "', FMT_NOTE = '" + fmtnote + "' where FMT_ID = '" + fmtid + "'";				
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Update Format"
							+ request.getParameter("fmtid") + " succeed.");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/format.jsp");
				} else {
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Update Format" 
							+ request.getParameter("fmtid") + " failed by " + row + ".");
					request.getSession().setAttribute("fmtedit", request.getParameter("fmtid"));
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/formatedit.jsp");				
				}
			} else if (dct.equals("btype")) {
				//图书类别字典
				String btypeid = request.getParameter("btypeid");
				String btypename = request.getParameter("btypename");
				String btypenote = request.getParameter("btypenote");
				sql = "update CBT_BTYPE set TYP_NAME = '" + btypename + "', TYP_NOTE = '" + btypenote + "' where TYP_ID = '" + btypeid + "'";				
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Update BookType"
							+ request.getParameter("btypeid") + " succeed.");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/booktype.jsp");
				} else {
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Update BookType" 
							+ request.getParameter("btypeid") + " failed by " + row + ".");
					request.getSession().setAttribute("btypeedit", request.getParameter("btypeid"));
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/btypeedit.jsp");				
				}
			} else if (dct.equals("corp")) {
				//合作商字典
				String corpid = request.getParameter("ecorpid");
				String corpname = request.getParameter("ecorpname");
				String shortname = request.getParameter("eshortname");
				String linkman = request.getParameter("elinkman");
				String tel = request.getParameter("etel");
				String address = request.getParameter("eaddress");
				String note = request.getParameter("enote");
				sql = "update CBT_CORPORATION set CORP_NAME = '" + corpname + "', CORP_SHORTNAME = '" + shortname + 
						"', CORP_LINKMAN = '" + linkman + "', CORP_TEL = '" + tel + "', CORP_ADDRESS = '" + address + 
						"', CORP_NOTE = '" + note + "' where CORP_ID = '" + corpid + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Update Corporation"
							+ corpid + " succeed.");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/corp.jsp");
				} else {
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Update Corporation" 
							+ corpid + " failed by " + row + ".");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/corp.jsp");
				}
			} else if (dct.equals("exp")) {
				//快递厂商字典
				String expid = request.getParameter("eexpid");
				String expname = request.getParameter("eexpname");
				String linkman = request.getParameter("elinkman");
				String tel = request.getParameter("etel");
				String note = request.getParameter("enote");
				sql = "update CBT_EXPRESS set EXP_NAME = '" + expname + "', EXP_LINKMAN = '" + linkman + 
						"', EXP_TEL = '" + tel + "', EXP_NOTE = '" + note + "' where EXP_ID = '" + expid + "'";
				row = DBManager.update(sql);
				if (row > 0) {
					System.out.println("[DCTMGR][S][" + DataManager.getCurrDateTime() + "] Update Express[" + expid + "] succeed.");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/express.jsp");
				} else {
					System.out.println("[DCTMGR][F][" + DataManager.getCurrDateTime() + "] Update Express[" + expid + "] failed by " + row + ".");
					response.sendRedirect(request.getContextPath() + "/mgr/dictionary/express.jsp");
				}
			}
		}
		
		//编辑节点（跳转）
		if (act.equals("editjump")) {
			//SQL选择
			String dct = request.getParameter("dct");
			if (dct.equals("dept")) {
				//院校专业字典
				String deptid = request.getParameter("deptid");
				request.getSession().setAttribute("deptedit", deptid);
				response.sendRedirect(request.getContextPath() + "/mgr/dictionary/deptedit.jsp");	
			} else if (dct.equals("org")) {
				//组织机构字典
				String orgid = request.getParameter("orgid");
				request.getSession().setAttribute("orgedit", orgid);
				response.sendRedirect(request.getContextPath() + "/mgr/dictionary/orgedit.jsp");
			} else if (dct.equals("lang")) {
				//图书语种字典
				String langid = request.getParameter("langid");
				request.getSession().setAttribute("langedit", langid);
				response.sendRedirect(request.getContextPath() + "/mgr/dictionary/langedit.jsp");				
			} else if (dct.equals("format")) {
				//图书规格字典
				String fmtid = request.getParameter("fmtid");
				request.getSession().setAttribute("fmtedit", fmtid);
				response.sendRedirect(request.getContextPath() + "/mgr/dictionary/formatedit.jsp");	
			} else if (dct.equals("btype")) {
				//图书类别字典
				String btypeid = request.getParameter("btypeid");
				request.getSession().setAttribute("btypeedit", btypeid);
				response.sendRedirect(request.getContextPath() + "/mgr/dictionary/btypeedit.jsp");	
			}
		}
		
		//编辑节点（加载）
		if (act.equals("editload")) {
			//SQL选择
			String dct = request.getParameter("dct");
			String no = null;
			if (dct.equals("dept")) {
				//院校专业字典
				try {
					if ((String)request.getSession().getAttribute("deptedit") != null) {
						no = (String)request.getSession().getAttribute("deptedit");
					} else {
						IOManager.write("back", response);
						return;
					}
				} catch (Exception e) {
					System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] User jump for deptedit without id");
				}
				sql = "select d1.DEPT_ID, d1.DEPT_NAME, d2.DEPT_NAME as DEPT_PARENTNAME, d1.DEPT_ADDRESS, d1.DEPT_NOTE "
						+ "from CBT_DEPT d1 left join CBT_DEPT d2 on d1.DEPT_PARENT = d2.DEPT_ID where d1.DEPT_ID = '" + no + "'";
			} else if (dct.equals("org")) {
				//组织机构字典
				try {
					if ((String)request.getSession().getAttribute("orgedit") != null) {
						no = (String)request.getSession().getAttribute("orgedit");
					} else {
						IOManager.write("back", response);
						return;
					}
				} catch (Exception e) {
					System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] User jump for OrgEdit without id");
				}
				sql = "select d1.ORG_ID, d1.ORG_NAME, d2.ORG_NAME as ORG_PARENTNAME, d1.ORG_NOTE from CBT_ORG d1 "
						+ "left join CBT_ORG d2 on d1.ORG_PARENT = d2.ORG_ID where d1.ORG_ID = '" + no + "'";				
			} else if (dct.equals("lang")) {
				//图书语种字典
				try {
					if ((String)request.getSession().getAttribute("langedit") != null) {
						no = (String)request.getSession().getAttribute("langedit");
					} else {
						IOManager.write("back", response);
						return;
					}
				} catch (Exception e) {
					System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] User jump for LanguageEdit without id");
				}
				sql = "select LAN_ID, LAN_NAME, LAN_NOTE from CBT_BLANG where LAN_ID = '" + no + "'";
			} else if (dct.equals("format")) {
				//图书规格字典
				try {
					if ((String)request.getSession().getAttribute("fmtedit") != null) {
						no = (String)request.getSession().getAttribute("fmtedit");
					} else {
						IOManager.write("back", response);
						return;
					}
				} catch (Exception e) {
					System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] User jump for FormatEdit without id");
				}
				sql = "select FMT_ID, FMT_NAME, FMT_NOTE from CBT_BFMT where FMT_ID = '" + no + "'";				
			} else if (dct.equals("btype")) {
				//图书类别字典
				try {
					if ((String)request.getSession().getAttribute("btypeedit") != null) {
						no = (String)request.getSession().getAttribute("btypeedit");
					} else {
						IOManager.write("back", response);
						return;
					}
				} catch (Exception e) {
					System.out.println("[EMPMGR][F][" + DataManager.getCurrDateTime() + "] User jump for BooktypeEdit without id");
				}
				sql = "select TYP_ID, TYP_NAME, TYP_NOTE from CBT_BTYPE where TYP_ID = '" + no + "'";
			} else if (dct.equals("corp")) {
				//合作商字典
				String corpid = request.getParameter("corpid");
				sql = "select * from CBT_CORPORATION where CORP_ID = '" + corpid + "'";
			} else if (dct.equals("exp")) {
				//快递商字典
				String expid = request.getParameter("expid");
				sql = "select * from CBT_EXPRESS where EXP_ID = '" + expid + "'";
			}
			
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);		
		}
		
		//新增节点生成编号
		if (act.equals("newnodeid")) {
			//SQL选择
			String dct = request.getParameter("dct");
			String parent = request.getParameter("parent");
			String format = "";
			if (dct.equals("dept")) {
				//院校专业字典
				if (parent.equals("0")) {
					format = "00";
				} else if (parent.length() == 2) {
					format = "0000";
				} else if (parent.length() == 4) {
					format = "000000";
				}
				sql = "select substr(to_char(max(DEPT_ID) + 1, '" + format + "'), 2) as newid from CBT_DEPT "
						+ "where DEPT_PARENT = '" + parent + "'";
			} else if (dct.equals("org")) {
				//组织机构字典
				if (parent.equals("0")) {
					format = "00";
				} else if (parent.length() == 2) {
					format = "0000";
				} else if (parent.length() == 4) {
					format = "000000";
				}
				sql = "select substr(to_char(max(ORG_ID)+1, '" + format + "'), 2) as newid from CBT_ORG "
						+ "where ORG_PARENT = '" + parent + "'";
			}
			
			//SQL执行
			rel = DBManager.queryCol(sql, "NEWID");
			if (rel == null) {
				//若父节点下无数据，则从01开始
				if (parent.equals("0")) {
					rel = "01";
				} else {
					rel = parent + "01";
				}		
			}
			IOManager.write(rel, response);
		}		
		
		//加载面包屑
		if (act.equals("breadcrumb")) {
			//SQL选择
			String dct = request.getParameter("dct");
			String level = request.getParameter("level");
			String parent = request.getParameter("parent");
			if (dct.equals("dept")) {
				//院校专业字典
				if (level.equals("b")) {
					sql = "select DEPT_NAME from CBT_DEPT where DEPT_ID = '" + parent + "'";
				} else if (level.equals("c")) {
					sql = "select DEPT_NAME from CBT_DEPT where ( DEPT_ID = ( select DEPT_PARENT from CBT_DEPT "
							+ "where DEPT_ID = '" + parent + "' ) or DEPT_ID = '" + parent + "') order by DEPT_ID";					
				}
			} else if (dct.equals("org")) {
				//组织机构字典
				if (level.equals("b")) {
					sql = "select ORG_NAME from CBT_ORG where ORG_ID = '" + parent + "'";
				} else if (level.equals("c")) {
					sql = "select ORG_NAME from CBT_ORG where ( ORG_ID = ( select ORG_PARENT from CBT_ORG "
							+ "where ORG_ID = '" + parent + "' ) or ORG_ID = '" + parent + "') order by ORG_ID";					
				}				
			}
			
			//SQL执行
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
			
		//加载三级筛选
		if (act.equals("loadselect")) {
			//SQL选择
			String dct = request.getParameter("dct");
			if (dct.equals("dept")) {
				//院校专业字典
				String level = request.getParameter("level");
				if (level.equals("b")) {
					sql = "select DEPT_ID, DEPT_NAME from CBT_DEPT where DEPT_PARENT = '0' order by DEPT_ID";
				} else if (level.equals("c")) {
					sql = "select DEPT_ID, DEPT_NAME from CBT_DEPT where DEPT_PARENT = 0 or DEPT_PARENT in "
							+ "(select DEPT_ID from CBT_DEPT where DEPT_PARENT = 0) order by DEPT_ID";
				}
			} else if (dct.equals("org")) {
				//组织机构字典
				String level = request.getParameter("level");
				if (level.equals("b")) {
					sql = "select ORG_ID, ORG_NAME from CBT_ORG where ORG_PARENT = '0' order by ORG_ID";
				} else if (level.equals("c")) {
					sql = "select ORG_ID, ORG_NAME from CBT_ORG where ORG_PARENT = 0 or ORG_PARENT in "
							+ "(select ORG_ID from CBT_ORG where ORG_PARENT = 0) order by ORG_ID";
				}
			}
			
			//SQL执行
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//加载字典
		if (act.equals("load")) {
			//SQL选择
			String dct = request.getParameter("dct");
			if (dct.equals("dept")) {
				//加载院校专业字典
				String level = request.getParameter("level");
				if (level.equals("a")) {
					//全部院校
					sql = "select DEPT_ID, DEPT_NAME, DEPT_PARENT, DEPT_ADDRESS from CBT_DEPT "
							+ "where DEPT_PARENT = 0 order by DEPT_ID";
				} else if (level.equals("b") || level.equals("c")) {
					//指定院校查询院系、指定院系查询专业
					String parent = request.getParameter("parent");
					sql = "select DEPT_ID, DEPT_NAME, DEPT_PARENT, DEPT_ADDRESS from CBT_DEPT "
							+ "where DEPT_PARENT = '" + parent + "' order by DEPT_ID";
				}
			} else if (dct.equals("org")) {
				//加载组织机构字典
				String level = request.getParameter("level");
				if (level.equals("a")) {
					//全部省份
					sql = "select ORG_ID, ORG_NAME, ORG_PARENT, ORG_NOTE from CBT_ORG where ORG_PARENT = '0' order by ORG_ID";
				} else if (level.equals("b") || level.equals("c")) {
					//指定省查询市、指定市查询区
					String parent = request.getParameter("parent");
					sql = "select ORG_ID, ORG_NAME, ORG_PARENT, ORG_NOTE from CBT_ORG where ORG_PARENT = '" + parent + "' order by ORG_ID";
				}
			} else if (dct.equals("lang")) {
				//加载图书语种字典
				sql = "select LAN_ID, LAN_NAME, LAN_NOTE from CBT_BLANG order by cast(LAN_ID as int)";
			} else if (dct.equals("format")) {
				//加载图书规格字典
				sql = "select FMT_ID, FMT_NAME, FMT_NOTE from CBT_BFMT order by cast(FMT_ID as int)";
			} else if (dct.equals("btype")) {
				//加载图书类别字典
				sql = "select TYP_ID, TYP_NAME, TYP_NOTE from CBT_BTYPE order by cast(TYP_ID as int)";
			} else if (dct.equals("corp")) {
				//加载合作商字典
				sql = "SELECT CORP_ID, CORP_NAME, CORP_SHORTNAME, CORP_LINKMAN, CORP_TEL FROM CBT_CORPORATION order by cast(CORP_ID as int)";
			} else if (dct.equals("exp")) {
				//加载快递商字典
				sql = "SELECT * FROM CBT_EXPRESS order by EXP_ID";
			}
			
			//SQL执行
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		//节点搜索
		if (act.equals("search")) {
			//SQL选择
			String dct = request.getParameter("dct");
			String key = request.getParameter("key");
			if (dct.equals("lang")) {
				//加载图书语种字典
				sql = "select LAN_ID, LAN_NAME, LAN_NOTE from CBT_BLANG where LAN_NAME like '%" + key + "%' order by cast(LAN_ID as int)";
			} else if (dct.equals("format")) {
				//加载图书规格字典
				sql = "select FMT_ID, FMT_NAME, FMT_NOTE from CBT_BFMT where FMT_NAME like '%" + key + "%' order by cast(FMT_ID as int)";			
			} else if (dct.equals("btype")) {
				//加载图书类别字典
				sql = "select TYP_ID, TYP_NAME, TYP_NOTE from CBT_BTYPE where TYP_NAME like '%" + key + "%' order by cast(TYP_ID as int)";
			} else if (dct.equals("corp")) {
				//加载合作商字典
				sql = "SELECT CORP_ID, CORP_NAME, CORP_SHORTNAME, CORP_LINKMAN, CORP_TEL FROM CBT_CORPORATION where CORP_NAME like '%" +
						key + "%' order by cast(CORP_ID as int)";
			} else if (dct.equals("exp")) {
				//加载快递商字典
				sql = "SELECT EXP_ID, EXP_NAME, EXP_LINKMAN, EXP_TEL FROM CBT_EXPRESS WHERE EXP_NAME like '%" + key + "%' order by EXP_ID";
			}
			
			//SQL执行
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);			
		}
		
	}
}
