package com.niulanshan.servlet.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sound.midi.Soundbank;

import com.alibaba.fastjson.JSON;
import com.niulanshan.pojo.User;
import com.niulanshan.service.login.LoginService;
import com.niulanshan.service.login.impl.LoginServiceImpl;
import com.niulanshan.servlet.AbstractServlet;
import com.niulanshan.utils.CheckCodeUtils;
import com.niulanshan.utils.SendMail;



@WebServlet(urlPatterns = {"/login"}, name = "login")
public class LoginServlet extends AbstractServlet{

	LoginService loginService;
	
	
	@Override
	public Class getServletClass() {
		return LoginServlet.class;
	}
	
	
	
	@Override
	public void init() throws ServletException {
		loginService =new LoginServiceImpl();
	}



	public void cache(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		 //设置相应类型,告诉浏览器输出的内容为图片
        resp.setContentType("image/jpeg");
        //设置响应头信息，告诉浏览器不要缓存此内容
        resp.setHeader("pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expire", 0);
        CheckCodeUtils.check(resp,req);
	}
	
	
	public int login(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		 resp.setCharacterEncoding("UTF-8");
		   String random  =(String)req.getSession().getAttribute("CHECKCODE_SERVER");
		    String name=req.getParameter("name");
		    String pwd=req.getParameter("pwd");
		    String textpwd=req.getParameter("textpwd");//记住密码
		    String captcha=req.getParameter("captcha");//验证码
		User user=new User();
		user.setName(name);
		user.setPwd(pwd);		
		   // 记录用户登陆状态  1：登陆成功；  0：登陆失败 ；
      int resultStatus = 0;
      
      if(captcha.equals(random)) {
		User u=loginService.findUser(user);
	      if(u!=null) {
	        	if(textpwd!=null){//勾选记住密码添加cookie
	        		String cookiePwd=user.getPwd();
	        		String cookieuser=user.getName();

	        		Cookie cookie1=new Cookie("cookieuser",cookieuser);
	        		Cookie cookie2=new Cookie("cookiePwd",cookiePwd);        		
	        		cookie1.setMaxAge(60);
	        		cookie2.setMaxAge(60);
	        		resp.addCookie(cookie1);
	        		resp.addCookie(cookie2);       		
	        	}
	        	//如果没有勾选记住密码则清除cookie
	        	if(textpwd==null){
	        		Cookie[] cookies=req.getCookies();
	        		for(int i=0;i<cookies.length;i++){  
	        			if("cookieuser".equals(cookies[i].getName()) |"checked".equals(cookies[i].getName())){
	        				  cookies[i].setMaxAge(0);  
	        				  resp.addCookie(cookies[i]) ; 
	        			}	       		     
	        		} 
	        	}        
	     
	        	req.getSession().setAttribute("user", user.getName());
	            resultStatus = 1;
	        }  	
      }else {
      	resultStatus=-1;
		}
	return resultStatus;
		
	}
	
	//忘记密码页面
	public String ftp(HttpServletRequest req,HttpServletResponse resp) throws Exception {
		return "/jsp/NewFile";	
	}
	//判断 重置密码页面
	public String cz(HttpServletRequest req,HttpServletResponse resp) throws Exception {
		int id=Integer.parseInt(req.getParameter("id"));
		User user=new User();
		user.setId(id);
		User u=loginService.findUser(user);
		Date date=new Date();
		int b=date.compareTo(u.getTime());
		int a=(int)((date.getTime()-(u.getTime().getTime())) / (1000*3600*24));
		
		System.out.println("aaaaaaaaaaaaa==="+b);
		
		if((int)((date.getTime()-(u.getTime().getTime())) / (1000*3600*24))<=30) {
			return "/jsp/NewFile1";	
		}
	
		return null;	
	}
	
	public int mail(HttpServletRequest req,HttpServletResponse resp)throws Exception {
	    String name=req.getParameter("userName");
	    String email=req.getParameter("email");
	    int resultStatus=0;
		User user=new User();
		user.setEmail(email);
		user.setName(name);
		User u=loginService.findUser(user);

		if(u!=null) {
			u.setUrl(SendMail.generateResetPwdLink(u));
			
	    	u.setTime(new Date());
	    	int row=loginService.update(u);
	    	SendMail.sendMail(u.getEmail(),SendMail.mailUrl(u));//发送邮件
	    	  resultStatus = 1;
		}
		return resultStatus;
	}
	
	


	
}
