package com.niulanshan.dao.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.niulanshan.dao.BaseDaoImpl;
import com.niulanshan.pojo.User;


public class LoginDaoImpl extends BaseDaoImpl implements LoginDao {
	
	public Connection conn;

	public LoginDaoImpl(Connection conn) {
		super(conn);
		this.conn = conn;
	}

	@Override
	public User findUser(User user) throws Exception {
			User u=null;
			Object[] obj=null;
			StringBuffer sql=new StringBuffer("select * from `login` where 1=1 ");
			if(user.getId()!=null) {
				sql.append("and id=?");
				obj=new Object[] {user.getId()};
			}
			if(user.getName()!=null & user.getPwd()!=null) {
				sql.append("and name=? and pwd=?");
				obj=new Object[] {user.getName(),user.getPwd()};			
			}
			if(user.getName()!=null & user.getEmail()!=null) {
				sql.append("and name=? and email=?");
				obj=new Object[] {user.getName(),user.getEmail()};	
			}
		
			ResultSet rs= executeQuery(sql.toString(),obj);
			while(rs.next()) {
				 u=(User)tableToClass(rs);
			}
		return u;
	}



	
	@Override
	public Integer update(User user)throws Exception  {
			int row=0;
			String sql="update `login` set time =?,url = ? where id = ? ";
			Object[] obj=new Object[] {user.getTime(),user.getUrl(),user.getId()};;			
			 row =excuteUpdate(sql,obj);
			 return row;
	}

	
	@Override
	public Object tableToClass(ResultSet rs) throws Exception {
		User user=new User();
		user.setId(rs.getInt("id"));
		user.setName(rs.getString("name"));
		user.setPwd(rs.getString("pwd"));
		user.setEmail(rs.getString("email"));
		user.setTime(rs.getDate("time"));
		user.setUrl(rs.getString("url"));
		return user;
	}


	
	
}
