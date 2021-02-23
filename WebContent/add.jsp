<%@page import="java.math.BigDecimal"%>
<%@ page language="java" import="com.utils.*, java.sql.*,java.math.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>新增</title>
</head>
<body>
	<div align="center">
<form action="add.jsp" method="post">
		 菜品:<input type="text" name="name" ><br/>
		 菜品信息:<input type="text" name="dish_megs"  " ><br/>
		 送餐时间:<input type="text" name="times"   ><br/>
		 送餐地址:<input type="text" name="address"   ><br/>
		 订单状态:<input type="text" name="states"  ><br/>
		 总金额:<input type="text" name="sum_price"  ><br/>
		 <input type="submit" value="新增">
		</form>
		</div>
		
		<%
		//增加
		request.setCharacterEncoding("utf-8");
		String method = request.getMethod();
		if(method.equals("POST")){
		String name=request.getParameter("name");
		String dishMegs=request.getParameter("dish_megs");
		String times=request.getParameter("times");
		String address=request.getParameter("address");
		int states=Integer.parseInt(request.getParameter("states"));
		String su=request.getParameter("sum_price");
		BigDecimal sumPrice=new BigDecimal(su);
		
		Connection conn=JDBCConnUtil.getConnection();
		String sql="insert into `order` (name,dish_megs,times,address,states,sum_price) values(?,?,?,?,?,?)";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setObject(1, name);
		pstmt.setObject(2, dishMegs);
		pstmt.setObject(3, times);
		pstmt.setObject(4, address);
		pstmt.setObject(5, states);
		pstmt.setObject(6, sumPrice);
		pstmt.executeUpdate();
		response.sendRedirect("list.jsp");
	}
		%>
</body>
</html>