package com.niulanshan.service.login.impl;

import java.sql.Connection;

import com.niulanshan.dao.login.LoginDao;
import com.niulanshan.dao.login.LoginDaoImpl;
import com.niulanshan.pojo.User;
import com.niulanshan.service.login.LoginService;
import com.niulanshan.utils.JDBCConnUtil;



public class LoginServiceImpl implements LoginService{

	@Override
	public User findUser(User user) throws Exception {
		Connection conn=JDBCConnUtil.getConnection();
		LoginDao loginDao=new LoginDaoImpl(conn);
		return loginDao.findUser(user);
	}


	@Override
	public Integer update(User user) throws Exception {
		Connection conn=JDBCConnUtil.getConnection();
		LoginDao loginDao=new LoginDaoImpl(conn);		
		return loginDao.update(user);
	}

	
}
