package com.niulanshan.service.login;

import com.niulanshan.pojo.User;

public interface LoginService {

	User findUser(User user) throws Exception;//��¼
	
	
	Integer update(User user) throws Exception;	//�޸�url��time
}
