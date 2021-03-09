package com.niulanshan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;



/**
 * 基础dao的实现类�? 实现�?基本的增删改查的方法
 * @author 10947
 *
 */


/**
 * 源码分析�?
 *    executeQuery:如果是查询操作，则调用execjteQuery方法，这里将多个参数封装成数组对象作为入参，这里�?
 *    Object[] params表示，还有sql字符串入参，利用JDBC API和循环将参数拼接成完整的SQL，发送到数据库执行，�?
   *          拿到ResultSet实例�?
 * 
 *    executeUpdate:用来执行增删改操作，这里创建�?个PreparedStatement对象来将参数化的SQL语句发�?�到数据库，
   *     这里利用循环调用setObject方法实现�? �?后返回影响的行数
 * 
 * 
 *    executeInsert:用来执行插入操作，将多个参数封装成数组对象作为入参，还有SQL字符串入参，返回插入后的主键ID值�??
 * 
 *    tableToClass:这个返回值类型的Object 其实是一个实体类的实例，入参是ResultSet实例，主要功能就是将�?个已�?
   *           数据查询的一个记录（ResultSet实例�? 结果集转成实体类对象�?
 * 
 * 
 * 
 * 
 * 
 * @author 10947
 *
 */

public abstract class BaseDaoImpl implements IBaseDao{
	protected Connection connection;
	
	protected PreparedStatement pstm;
	
	



	public BaseDaoImpl(Connection connection) {
		this.connection = connection;
	}
	
	
	
	public ResultSet executeQuery(String sql,Object[] params) {
		ResultSet rs = null;
		
		try {
			pstm = connection.prepareStatement(sql);
			for(int i=0; i<params.length; i++) {
				pstm.setObject(i+1, params[i]);
			}
			rs = pstm.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return rs;
	}
	
	
	public int excuteUpdate(String sql,Object[] params) {
		int updateRows = 0;
		try {
			pstm = connection.prepareStatement(sql);
			for(int i=0; i<params.length; i++) {
				pstm.setObject(i+1, params[i]);
			}
			updateRows = pstm.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			updateRows = -1;
		}
		return updateRows;
	}
	
	
	public int executeInsert(String sql,Object[] params) {
		Long id = 0L;
		try {
			pstm = connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			for(int i=0; i<params.length; i++) {
				pstm.setObject(i+1, params[i]);
			}
			pstm.executeUpdate();
			ResultSet rs = pstm.getGeneratedKeys();
			if(rs.next()) {
				id = rs.getLong(1);

			}
		}catch(Exception e) {
			e.printStackTrace();
			id = null;
		}
		return id.intValue();
	}
	
	
	//释放资源
	public boolean closeResource() {
		if(pstm != null) {
			try {
				pstm.close();
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}
	
	//关闭资源
	public boolean closeResource(ResultSet reSet) {
		if(reSet != null) {
			try {
				reSet.close();
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}
	
	/* 需要重写的方法，子类实现对象关系映射
	 */
	public abstract Object tableToClass(ResultSet rs)throws Exception;
	
	
}
