package com.niulanshan.servlet;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niulanshan.utils.EmptyUtils;
import com.niulanshan.utils.PrintUtil;
import com.niulanshan.utils.ReturnResult;


/**
 * 公共的Servlet抽象类
 * @author 10947
 *
 */
public abstract class AbstractServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	
	/**
	 * 定义获取Servlet类的抽象方法
	 * @return
	 */
	public abstract Class getServletClass();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);  //如果是get请求转发给doPost处理，如果是POST请求依旧doPost处理
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String actionIndicator = req.getParameter("action");
		Method method = null;
		Object result = null;
		try {
			if(EmptyUtils.isEmpty(actionIndicator)) {
				result = execute(req,resp);
			}else {
				/**
				 * 反射第一步拿到Class类的对象，但是在这里不是拿到AbstractServlet类的Class对象。
				 * 因为Action的方法是写在其他的Servlet里，而不是写在父类AbstractServlet
				 * 所以我需要拿到其他类的Class类的对象，所以才有了getServletClass这个抽象方法的存在，
				 * 是为了让子类去实现，这样就可以间接拿到子类 Class对象
				 * 所以只要调用 getServletClass()就可以获取子类 Class对象
				 */
				method = getServletClass().getDeclaredMethod(actionIndicator, HttpServletRequest.class,HttpServletResponse.class);
				result = method.invoke(this, req,resp);
			}
			
			toView(req,resp,result);
			
		}catch(NoSuchMethodException e) {
			String viewName = "404.jsp";
			req.getRequestDispatcher(viewName).forward(req, resp);
		}catch(Exception e) {
			e.printStackTrace();
			if(!EmptyUtils.isEmpty(result)) {
				if(result instanceof String) {
					String viewName = "500.jsp";
					req.getRequestDispatcher(viewName).forward(req, resp);
				}else {
					ReturnResult returnResult = new ReturnResult();
					returnResult.returnFail("系统错误");
					PrintUtil.write(returnResult, resp);
				}
			}else {
				String viewName = "500.jsp";
				req.getRequestDispatcher(viewName).forward(req, resp);
			}
		}
	}

	
	/**
	 * MVC：因为一个Servlet最终是要渲染到页面，会将 req和resp重定向转发到某个jsp页面， 这种方法叫做 显示1.
	 * Ajax: 返回的数据，是通过IO流将JSON字符串打印给浏览器作为输出。不需要JSP页面。也不需要req,resp
	 * 
	 * Object result: 如果是String类型， 这个result的值就是某个jsp页面的文件名！如果不是String类型，而是对象那就是Ajax
	 */
	
	/**
	 * 显示方法  ： MVC+Ajax
	 * @param req
	 * @param resp
	 * @param result
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void toView(HttpServletRequest req,HttpServletResponse resp,Object result) throws IOException,ServletException {
		if(!EmptyUtils.isEmpty(result)) {
			    //MVC 返回
			if(result instanceof String) {
				String viewName = result.toString() + ".jsp";
				req.getRequestDispatcher(viewName).forward(req, resp);
			}else {
				//Ajax返回
				PrintUtil.write(result, resp);
			}
		}
	}
	
	
	/**
	 * 默认返回
	 * @param req
	 * @param resp
	 * @return
	 */
	public Object execute(HttpServletRequest req,HttpServletResponse resp) {
		return "login";
	}
	
	
}
