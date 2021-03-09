package com.niulanshan.utils;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;

/**
 * io 输出 ajax�? json字符�? javabean
 * @author 10947
 *
 */
public class PrintUtil {
	private static void print(String msg,HttpServletResponse response) {
		PrintWriter writer = null;
		try {
			if(null != response) {
				writer = response.getWriter();
				writer.print(msg);
				writer.flush();
			}
		}catch(IOException e) {
			e.printStackTrace();
		}finally {
			writer.close();
		}
	}
	
	public static void write(Object obj,HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");
		String json = JSONObject.toJSONString(obj);
		print(json,response);
	}
}
