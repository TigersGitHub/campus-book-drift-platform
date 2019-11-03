/**
 * IOManager.java
 * CreateDate:	2016-12-15
 * LastUpdate:	2017-1-10
 * Description:	输入输出管理器
 * @author ShenHongtai
 */

package com.cbdts.commons;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class IOManager {
	/**
	 * 页面输出
	 * @param rel
	 * @param response
	 * @throws IOException
	 * @author ShenHongtai
	 */
	public static void write(String rel, HttpServletResponse response) throws IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(rel);
		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (out != null) {
				out.close();
			}
		}		
	}
}
