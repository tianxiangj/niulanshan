package com.niulanshan.dao.login;

import com.niulanshan.dao.IBaseDao;
import com.niulanshan.pojo.User;

public interface LoginDao extends IBaseDao{

	User findUser(User user) throws Exception;//��¼
	

	
	//�޸�url��time
	Integer update(User user) throws Exception;
}
