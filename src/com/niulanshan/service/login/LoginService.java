package com.niulanshan.service.login;

import com.niulanshan.pojo.User;

public interface LoginService {

	User findUser(User user) throws Exception;//µÇÂ¼
	
	
	Integer update(User user) throws Exception;	//ÐÞ¸ÄurlºÍtime
}
