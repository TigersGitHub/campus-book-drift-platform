package com.cbdts.mgrservice;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.cbdts.commons.DBManager;
import com.cbdts.commons.DataManager;
import com.cbdts.commons.IOManager;

/**
 * 图书管理通用服务
 * Servlet implementation class BookCommon
 * @author ShenHongtai
 */
public class BookCommon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 图书管理初始化方法
     * @see HttpServlet#HttpServlet()
     * @author ShenHongtai
     */
    public BookCommon() {
        super();
    }

	/**
	 * 图书管理服务GET方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * @author ShenHongtai
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	/**
	 * 文件上传
	 * @param request
	 * @param response
	 * @author ShenHongtai
	 */
	@SuppressWarnings("unused")
	private void upload(HttpServletRequest request, HttpServletResponse response) {
	    // 上传文件存储目录
	    final String UPLOAD_DIRECTORY = "upload";
	 
	    // 上传配置
	    final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
	    final int MAX_FILE_SIZE      = 1024 * 1024 * 40; // 40MB
	    final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
	 
	    /**
	     * 上传数据及保存文件
	     */
		// 检测是否为多媒体上传
		if (!ServletFileUpload.isMultipartContent(request)) {
		    // 如果不是则停止
		    PrintWriter writer = null;
			try {
				writer = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
		    writer.println("Error: 表单必须包含 enctype=multipart/form-data");
		    writer.flush();
		    return;
		}
 
        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // 设置临时存储目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
 
        ServletFileUpload upload = new ServletFileUpload(factory);
         
        // 设置最大文件上传值
        upload.setFileSizeMax(MAX_FILE_SIZE);
         
        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(MAX_REQUEST_SIZE);
 
        // 构造临时路径来存储上传的文件
        // 这个路径相对当前应用的目录
        String uploadPath = getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;
       
         
        // 如果目录不存在则创建
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
 
        try {
            // 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(request);
 
            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        // 在控制台输出文件的上传路径
                        System.out.println(filePath);
                        // 保存文件到硬盘
                        item.write(storeFile);
                        request.setAttribute("message", "文件上传成功!");
                    }
                }
            }
        } catch (Exception ex) {
            request.setAttribute("message", "错误信息: " + ex.getMessage());
        }	        
	}

	/**
	 * 图书管理服务POST方法
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
		
		if (act.equals("disable")) {
			String recid = request.getParameter("recid");
			sql = "UPDATE CBT_RECOMMEND SET REC_ENABLE = 'F' WHERE REC_ID = '" + recid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/mgr/base/recommend.jsp");
			} else {
				rel = "<script>alert('禁用失败，请刷新后再试');window.location.href='" + request.getContextPath() + "/mgr/base/recommend.jsp';</script>";
				IOManager.write(rel, response);
			}
		}
		
		else if (act.equals("enable")) {
			String recid = request.getParameter("recid");
			sql = "UPDATE CBT_RECOMMEND SET REC_ENABLE = 'T' WHERE REC_ID = '" + recid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/mgr/base/recommend.jsp");
			} else {
				rel = "<script>alert('启用失败，请刷新后再试');window.location.href='" + request.getContextPath() + "/mgr/base/recommend.jsp';</script>";
				IOManager.write(rel, response);
			}
		}
		
		else if (act.equals("bdisable")) {
			String bookid = request.getParameter("bookid");
			sql = "UPDATE CBT_BOOK SET BOOK_ENABLE = 'F' WHERE BOOK_ID = '" + bookid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/mgr/base/bookinfo.jsp");
			} else {
				rel = "<script>alert('启用失败，请刷新后再试');window.location.href='" + request.getContextPath() + "/mgr/base/bookinfo.jsp';</script>";
				IOManager.write(rel, response);
			}
		}
		
		else if (act.equals("benable")) {
			String bookid = request.getParameter("bookid");
			sql = "UPDATE CBT_BOOK SET BOOK_ENABLE = 'T' WHERE BOOK_ID = '" + bookid + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				response.sendRedirect(request.getContextPath() + "/mgr/base/bookinfo.jsp");
			} else {
				rel = "<script>alert('启用失败，请刷新后再试');window.location.href='" + request.getContextPath() + "/mgr/base/bookinfo.jsp';</script>";
				IOManager.write(rel, response);
			}
		}
		
		else if (act.equals("recdetail")) {
			String recid = request.getParameter("recid");
			sql = "SELECT REC_ISBN, REC_TYPE, REC_NAME_CH, REC_NAME_EN, REC_AUTHOR_CH, REC_AUTHOR_EN, REC_PRESS, REC_LANGUAGE, "
					+ "REC_IMAGE, REC_PRICE, REC_SELLPRICE, REC_CORPID, REC_URL, REC_SPPRICE, REC_PAYBALANCE, REC_NOTE "
					+ "FROM CBT_RECOMMEND WHERE REC_ID = '" + recid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("binfodetail")) {
			String bookid = request.getParameter("bookid");
			sql = "SELECT b.book_isbn, t.typ_name as book_type, b.book_name_ch, b.book_name_en, b.book_author_ch, b.book_author_en, "
					+ "b.book_press, to_char(b.book_pressdate, 'yyyy-mm-dd') as book_pressdate, l.lan_name as book_language,  "
					+ "f.fmt_name as BOOK_FORMAT, b.book_page, decode(b.book_cover, 'P', '平装', 'R', '精装') as BOOK_COVER, "
					+ "b.book_version, decode(b.book_issell, 'Y', '二手交易', 'N', '图书漂流') as book_issell, b.book_price, "
					+ "b.book_sellprice, decode(b.book_isexist, 'Y', '在售', 'N', '售出') as book_isexist, b.book_image, "
					+ "b.book_detail, b.book_note FROM CBT_BOOK b INNER JOIN CBT_BTYPE t on t.typ_id = b.book_type "
					+ "INNER JOIN CBT_BLANG l on l.lan_id = b.book_language INNER JOIN CBT_BFMT f on f.fmt_id = b.book_format "
					+ "WHERE BOOK_ID = '" + bookid + "'";
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("editrec")) {
			String id = request.getParameter("recid_edit");
			String isbn = request.getParameter("isbn_edit");
			String btype = request.getParameter("btype_edit");
			String bname_ch = request.getParameter("bname_ch_edit");
			String bname_en = request.getParameter("bname_en_edit");
			String bauth_ch = request.getParameter("bauth_ch_edit");
			String bauth_en = request.getParameter("bauth_en_edit");
			String press = request.getParameter("press_edit");
			String blang = request.getParameter("blang_edit");
			String bprice = request.getParameter("bprice_edit");
			String bsellprice = request.getParameter("bsellprice_edit");
			String bcorp = request.getParameter("bcorp_edit");
			String burl = request.getParameter("burl_edit");
			String spprice = request.getParameter("spprice_edit");
			String paybal = request.getParameter("paybal_edit");
			String bnote = request.getParameter("bnote_edit");
			
			sql = "UPDATE CBT_RECOMMEND SET REC_ISBN = '" + isbn + "', REC_TYPE = '" + btype + "', REC_NAME_CH = '" + bname_ch
					+ "', REC_NAME_EN = '" + bname_en + "', REC_AUTHOR_CH = '" + bauth_ch + "', REC_AUTHOR_EN = '" + bauth_en
					+ "', REC_PRESS = '" + press + "', REC_LANGUAGE = '" + blang + "', REC_PRICE = '" + bprice
					+ "', REC_SELLPRICE = '" + bsellprice + "', REC_CORPID = '" + bcorp + "', REC_URL = '" + burl
					+ "', REC_SPPRICE = '" + spprice + "', REC_PAYBALANCE = '" + paybal + "', REC_NOTE = '" + bnote
					+ "', REC_LASTMDF = to_date('" + DataManager.getCurrDateTime() + "', 'yyyy-mm-dd hh24:mi:ss') "
					+ "WHERE REC_ID = '" + id + "'";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('修改成功！');window.location.href='" + request.getContextPath() + "/mgr/base/recommend.jsp';</script>";
			} else {
				rel = "<script>alert('修改失败，请刷新后再试');window.location.href='" + request.getContextPath() + "/mgr/base/recommend.jsp';</script>";
			}
			IOManager.write(rel, response);
		}
		
		else if (act.equals("addrec")) {
			String id = "";
			String isbn = request.getParameter("isbn");
			String btype = request.getParameter("btype");
			String bname_ch = request.getParameter("bname_ch");
			String bname_en = request.getParameter("bname_en");
			String bauth_ch = request.getParameter("bauth_ch");
			String bauth_en = request.getParameter("bauth_en");
			String press = request.getParameter("press");
			String blang = request.getParameter("blang");
			String bimage = request.getParameter("bimage");
			String bprice = request.getParameter("bprice");
			String bsellprice = request.getParameter("bsellprice");
			String bcorp = request.getParameter("bcorp");
			String burl = request.getParameter("burl");
			String spprice = request.getParameter("spprice");
			String paybal = request.getParameter("paybal");
			String bnote = request.getParameter("bnote");
			
			sql = "SELECT trim(TO_CHAR(CBS_RECOMMEND.NEXTVAL,'0000')) as RECID FROM dual";
			id = "REC" + DataManager.getCurrDateNosplit();
			id += DBManager.queryCol(sql, "RECID");
			
			sql = "INSERT INTO CBT_RECOMMEND VALUES ('" + id + "', '" + isbn + "', '" + btype + "', '" + bname_ch + "', '" + 
					bname_en + "', '" + bauth_ch + "', '" + bauth_en + "', '" + press + "', '" + blang + "', '" + bimage + 
					"', '" + bprice + "', '" + bsellprice + "', to_date('" + DataManager.getCurrDateTime() + 
					"', 'yyyy-mm-dd hh24:mi:ss'), '', '" + bcorp + "', '" + burl + "', '0', '" + spprice + "', '" + paybal + 
					"', 'T', '" + bnote + "')";
			row = DBManager.update(sql);
			if (row > 0) {
				rel = "<script>alert('添加成功！');window.location.href='" + request.getContextPath() + "/mgr/base/recommend.jsp';</script>";
			} else {
				rel = "<script>alert('添加失败，请刷新后再试');window.location.href='" + request.getContextPath() + "/mgr/base/recommend.jsp';</script>";
			}
			IOManager.write(rel, response);
		}
		
		else if (act.equals("rectotalpage")) {
			String type = request.getParameter("type");
			String isbn = request.getParameter("isbn");
			String corp = request.getParameter("corp");
			String bname = request.getParameter("bname");
			
			String searchitems = "where 1=1";
			if ("0".equals(type) == false) {
				searchitems += " and REC_TYPE = '" + type + "'";
			}
			if ("0".equals(corp) == false) {
				searchitems += " and REC_CORPID = '" + corp + "'";
			}
			if (isbn.length() > 0) {
				searchitems += " and REC_ISBN like '%" + isbn + "%'";
			}
			if (bname.length() > 0) {
				searchitems += " and REC_NAME_CH like '%" + bname + "%'";
			}
			sql = "select ceil(count(REC_ID)/10) as TOTALPAGE from CBT_RECOMMEND n " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("btotalpage")) {
			String type = request.getParameter("type");
			String issell = request.getParameter("issell");
			String isexist = request.getParameter("isexist");
			String isbn = request.getParameter("isbn");
			String bname = request.getParameter("bname");
			String searchitems = "WHERE 1=1";
			
			if ("0".equals(type) == false) {
				searchitems += " and BOOK_TYPE = '" + type + "'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if ("0".equals(isexist) == false) {
				searchitems += " and BOOK_ISEXIST = '" + isexist + "'";
			}
			if (isbn.length() > 0) {
				searchitems += " and BOOK_ISBN like '%" + isbn + "%'";
			}
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			
			sql = "select ceil(count(BOOK_ID)/10) as TOTALPAGE from CBT_BOOK n " + searchitems;
			rel = DBManager.queryCol(sql, "TOTALPAGE");
			IOManager.write(rel, response);
		}
		
		else if (act.equals("loadrec")) {
			String page = request.getParameter("page");
			String type = request.getParameter("type");
			String isbn = request.getParameter("isbn");
			String corp = request.getParameter("corp");
			String bname = request.getParameter("bname");
			String searchitems = "WHERE 1=1";
			
			if ("0".equals(type) == false) {
				searchitems += " and REC_TYPE = '" + type + "'";
			}
			if ("0".equals(corp) == false) {
				searchitems += " and REC_CORPID = '" + corp + "'";
			}
			if (isbn.length() > 0) {
				searchitems += " and REC_ISBN like '%" + isbn + "%'";
			}
			if (bname.length() > 0) {
				searchitems += " and REC_NAME_CH like '%" + bname + "%'";
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT REC_ID, substr(REC_ISBN, 1, 3)||'-'||substr(REC_ISBN, 4, 1)||'-'||substr(REC_ISBN, 5, 3)||'-'"
					+ "||substr(REC_ISBN, 8, 5)||'-'||substr(REC_ISBN, 13, 1) as REC_ISBN, t.typ_name as REC_TYPE, REC_NAME_CH, "
					+ "REC_AUTHOR_CH, cp.corp_name as REC_CORPNAME, REC_CLICK, to_char(REC_SPPRICE*(REC_CLICK/REC_PAYBALANCE), "
					+ "'0.00') as REC_TOTALPRICE, REC_ENABLE FROM CBT_RECOMMEND INNER JOIN CBT_BTYPE t on t.typ_id = rec_type "
					+ "INNER JOIN CBT_CORPORATION cp on cp.corp_id = REC_CORPID " + searchitems + " order by REC_TOTALPRICE desc"
				+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
		
		else if (act.equals("loadbinfo")) {
			String page = request.getParameter("page");
			String type = request.getParameter("type");
			String issell = request.getParameter("issell");
			String isexist = request.getParameter("isexist");
			String isbn = request.getParameter("isbn");
			String bname = request.getParameter("bname");
			String searchitems = "WHERE 1=1";
			
			if ("0".equals(type) == false) {
				searchitems += " and BOOK_TYPE = '" + type + "'";
			}
			if ("0".equals(issell) == false) {
				searchitems += " and BOOK_ISSELL = '" + issell + "'";
			}
			if ("0".equals(isexist) == false) {
				searchitems += " and BOOK_ISEXIST = '" + isexist + "'";
			}
			if (isbn.length() > 0) {
				searchitems += " and BOOK_ISBN like '%" + isbn + "%'";
			}
			if (bname.length() > 0) {
				searchitems += " and BOOK_NAME_CH like '%" + bname + "%'";
			}
			
			sql = "select a2.* from (select a1.*, rownum rn from ("
					+ "SELECT b.BOOK_ID, substr(b.book_isbn, 1, 3)||'-'||substr(b.book_isbn, 4, 1)||'-'||substr(b.book_isbn, "
					+ "5, 3)||'-'||substr(b.book_isbn, 8, 5)||'-'||substr(b.book_isbn, 13, 1) as BOOK_ISBN, t.typ_name as "
					+ "book_type, b.book_name_ch, decode(b.book_issell, 'Y', '二手交易', 'N', '图书漂流') as BOOK_ISSELL, "
					+ "b.book_sellprice, decode(b.book_isexist, 'Y', '在售', 'N', '售出') as BOOK_ISEXIST, o.ord_status, b.book_enable "
					+ "FROM CBT_BOOK b left outer join CBT_ORDER o ON o.ord_bookid = b.book_id "
					+ "INNER JOIN CBT_BTYPE t on t.typ_id = b.book_type " + searchitems + " order by b.book_addtime desc"
					+ ") a1) a2 where rn <= " + (Integer.parseInt(page) * 10) + " and rn > " + (Integer.parseInt(page) * 10 - 10);
			rel = DBManager.queryJson(sql);
			IOManager.write(rel, response);
		}
	}

}
