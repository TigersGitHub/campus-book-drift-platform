/**
 * DBManager.java
 * CreateDate:	2016-12-15
 * LastUpdate:	2017-2-24
 * Description:	数据库管理器
 * @author ShenHongtai
 */

package com.cbdts.commons;

import java.sql.*;

public class DBManager { 
	/**
	 * CBDTS数据库连接串
	 */
	private static String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
	
	/**
	 * CBDTS数据库用户名
	 */
	private static String user = "scott";   
	
	/**
	 * CBDTS数据库登录密码
	 */
	private static String password = "tiger";  	 
	
	/**
	 * 全局连接对象
	 */
	public static Connection conn = null;
	 
	/**
	 * 获取数据库连接
	 * @return conn 连接对象
	 * @author ShenHongtai
	 */
	public static Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	 
	/**
	 * 数据查询
	 * @param sql SQL语句
	 * @param col 列名
	 * @return String column value or null
	 * @author ShenHongtai
	 */
	public static String queryCol(String sql, String col) {
		Connection conn = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		String re = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);	
			if (rs.next()) {
				re = rs.getString(col);
			}
		} catch (SQLException e) {
			System.out.println("[DBManager] Query failed by sql: " + sql);
			e.printStackTrace();
		}
		close(conn, stmt, rs);			
		return re;
	}
	 
	/**
	 * 数据查询
	 * @param sql SQL语句
	 * @return String JSON
	 * @author ShenHongtai
	 */
	public static String queryJson(String sql) {
		Connection conn = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		String json = "";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);			 
		} catch (SQLException e) {
			System.out.println("[DBManager] Query failed by sql: " + sql);
			e.printStackTrace();
		} finally {
			try {
				json = DataManager.rsToJson(rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}		
		}
		close(conn, stmt, rs);
		return json;
	}
	 
	/**
	 * 数据更改
	 * @param sql SQL语句
	 * @return row 更改的行数
	 * @author ShenHongtai
	 */
	public static int update(String sql) {
		Connection conn = getConnection();
		Statement stmt = null;
		int row = -1;
		try {
			stmt = conn.createStatement();
			row = stmt.executeUpdate(sql);			 
		} catch (SQLException e) {
			System.out.println("[DBManager] Update failed by sql: " + sql);
			e.printStackTrace();
		} finally {
			close(conn, stmt);
		}
		return row;
	}
	
	/**
	 * 关闭数据库对象（数据更改用）
	 * @param conn 连接对象
	 * @param stmt 执行器
	 * @return boolean 操作结果
	 * @author ShenHongtai
	 */
	public static boolean close(Connection conn, Statement stmt) {
		try {
			if (conn != null) {
				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	 
	/**
	 * 关闭数据库对象（数据查询用）
	 * @param conn 连接对象
	 * @param stmt 执行器
	 * @param rs 结果集
	 * @return boolean 操作结果
	 * @author ShenHongtai
	 */
	public static boolean close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if (conn != null) {
				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	/**
	 * 关闭数据库连接
	 * @param conn 需关闭的连接对象
	 * @return boolean 操作结果
	 * @author ShenHongtai
	 */
	public static boolean close(Connection conn) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	 
	/**
	 * 关闭执行器
	 * @param stmt 需关闭的执行器
	 * @return boolean 操作结果
	 * @author ShenHongtai
	 */
	public static boolean close(Statement stmt) {
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	 
	/**
	 * 关闭结果集
	 * @param rs 需关闭的结果集
	 * @return boolean 操作结果
	 * @author ShenHongtai
	 */
	public static boolean close(ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
}
