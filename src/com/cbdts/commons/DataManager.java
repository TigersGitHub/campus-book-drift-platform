/**
 * DataManager.java
 * CreateDate:	2016-12-15
 * LastUpdate:	2017-3-20
 * Description:	���ݹ�������
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
	 * �����б��ֵ��ѯ
	 * @param dct �ֵ������
	 * @param col_id ID�ֶ�����
	 * @param col_name NAME�ֶ�����
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
	 * �����б��ֵ�ɸѡ��ѯ
	 * @param dct �ֵ������
	 * @param col_id ID�ֶ�����
	 * @param col_name NAME�ֶ�����
	 * @param sqlwhere �ж��������
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
	 * ��ȡ��ǰ����ʱ��
	 * @return String ��ǰ����ʱ��
	 * @author ShenHongtai
	 */
	public static String getCurrDateTime() {
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}
	
	/**
	 * ��ȡָ����������ʱ��
	 * @return String ָ������ʱ��
	 * @author ShenHongtai
	 */
	public static String getPastDateTime(int pastday) {
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		return format.format(new Date(date.getTime() - (pastday - 1) * 24 * 60 * 60 * 1000)) + " 00:00:00";		 
	}
	
	/**
	 * ��ȡ��ǰ���ڣ��޷ָ�����
	 * @return String ��ǰ����
	 * @author ShenHongtai
	 */
	public static String getCurrDateNosplit() {
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyyMMdd");
		return format.format(date);
	}
	
	/**
	 * �����תJSON
	 * @param rs �����
	 * @return String JSON�ַ���
	 * @throws SQLException
	 * @author ShenHongtai
	 */
	public static String rsToJson(ResultSet rs) throws SQLException {
		return listToJson(rsToList(rs));
	}
	
	/**
	 * ListתJSON
	 * @param list java.util.List�б�
	 * @return String JSON�ַ���
	 * @author ShenHongtai
	 */
	@SuppressWarnings("rawtypes")
	public static String listToJson(List list) {		
		JSONArray jsonArray = JSONArray.fromObject(list);
		return jsonArray.toString();
	}
	
	/**
	 * �����תList
	 * @param rs �����
	 * @return List java.util.List�б�
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
