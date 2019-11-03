/**
 * DBManager.java
 * CreateDate:	2016-12-15
 * LastUpdate:	2017-2-24
 * Description:	���ݿ������
 * @author ShenHongtai
 */

package com.cbdts.commons;

import java.sql.*;

public class DBManager { 
	/**
	 * CBDTS���ݿ����Ӵ�
	 */
	private static String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
	
	/**
	 * CBDTS���ݿ��û���
	 */
	private static String user = "scott";   
	
	/**
	 * CBDTS���ݿ��¼����
	 */
	private static String password = "tiger";  	 
	
	/**
	 * ȫ�����Ӷ���
	 */
	public static Connection conn = null;
	 
	/**
	 * ��ȡ���ݿ�����
	 * @return conn ���Ӷ���
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
	 * ���ݲ�ѯ
	 * @param sql SQL���
	 * @param col ����
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
	 * ���ݲ�ѯ
	 * @param sql SQL���
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
	 * ���ݸ���
	 * @param sql SQL���
	 * @return row ���ĵ�����
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
	 * �ر����ݿ�������ݸ����ã�
	 * @param conn ���Ӷ���
	 * @param stmt ִ����
	 * @return boolean �������
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
	 * �ر����ݿ�������ݲ�ѯ�ã�
	 * @param conn ���Ӷ���
	 * @param stmt ִ����
	 * @param rs �����
	 * @return boolean �������
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
	 * �ر����ݿ�����
	 * @param conn ��رյ����Ӷ���
	 * @return boolean �������
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
	 * �ر�ִ����
	 * @param stmt ��رյ�ִ����
	 * @return boolean �������
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
	 * �رս����
	 * @param rs ��رյĽ����
	 * @return boolean �������
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
