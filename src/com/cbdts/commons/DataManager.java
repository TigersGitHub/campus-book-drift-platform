/**
 * DataManager.java
 * CreateDate:	2016-12-15
 * LastUpdate:	2017-3-20
 * Description:	数据管理器器
 * @author ShenHongtai
 */

package com.cbdts.commons;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

public class DataManager {
	/**
	 * 下拉列表字典查询
	 * @param dct 字典表名称
	 * @param col_id ID字段名称
	 * @param col_name NAME字段名称
	 * @return JSON Key&Value
	 * @author ShenHongtai
	 */
	public static String queryDct(String dct, String col_id, String col_name) {
		String json = "";
		String sql = "SELECT " + col_id + ", " + col_name + " FROM " + dct;
		json = DBManager.queryJson(sql);
		return json;
	}
	
	/**
	 * 下拉列表字典筛选查询
	 * @param dct 字典表名称
	 * @param col_id ID字段名称
	 * @param col_name NAME字段名称
	 * @param sqlwhere 判断条件语句
	 * @return JSON Key&Value
	 * @author ShenHongtai
	 */
	public static String queryDct(String dct, String col_id, String col_name, String sqlwhere) {
		String json = "";
		String sql = "SELECT " + col_id + ", " + col_name + " FROM " + dct + " WHERE 1=1 AND " + sqlwhere;
		json = DBManager.queryJson(sql);
		return json;
	}
	
	/**
	 * 获取当前日期时间
	 * @return String 当前日期时间
	 * @author ShenHongtai
	 */
	public static String getCurrDateTime() {
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}
	
	/**
	 * 获取指定距离日期时间
	 * @return String 指定日期时间
	 * @author ShenHongtai
	 */
	public static String getPastDateTime(int pastday) {
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		return format.format(new Date(date.getTime() - (pastday - 1) * 24 * 60 * 60 * 1000)) + " 00:00:00";		 
	}
	
	/**
	 * 获取当前日期（无分隔符）
	 * @return String 当前日期
	 * @author ShenHongtai
	 */
	public static String getCurrDateNosplit() {
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyyMMdd");
		return format.format(date);
	}
	
	/**
	 * 结果集转JSON
	 * @param rs 结果集
	 * @return String JSON字符串
	 * @throws SQLException
	 * @author ShenHongtai
	 */
	public static String rsToJson(ResultSet rs) throws SQLException {
		return listToJson(rsToList(rs));
	}
	
	/**
	 * List转JSON
	 * @param list java.util.List列表
	 * @return String JSON字符串
	 * @author ShenHongtai
	 */
	@SuppressWarnings("rawtypes")
	public static String listToJson(List list) {		
		JSONArray jsonArray = JSONArray.fromObject(list);
		return jsonArray.toString();
	}
	
	/**
	 * 结果集转List
	 * @param rs 结果集
	 * @return List java.util.List列表
	 * @throws SQLException
	 * @author ShenHongtai
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List rsToList(ResultSet rs) throws SQLException {
		List list = new ArrayList();
        ResultSetMetaData md = rs.getMetaData();
        int columnCount = md.getColumnCount();
        while (rs.next()) {
            Map rowData = new HashMap();
            for (int i = 1; i <= columnCount; i++) {
                rowData.put(md.getColumnName(i), rs.getObject(i));
            }
            list.add(rowData);
        }
        return list;
	}
}
