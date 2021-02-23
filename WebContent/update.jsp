<%@page import="java.math.BigDecimal"%>
<%@ page language="java" import="com.utils.*, java.sql.*,java.math.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>修改</title>
</head>
<body>

		<%
		request.setCharacterEncoding("utf-8");
		String name=null;
		String dishMegs=null;
		String times=null;
		String address=null;
		int states=0;
		BigDecimal sumPrice=new BigDecimal(0.0);
		
		int id=Integer.parseInt(request.getParameter("id"));
		
		Connection conn=JDBCConnUtil.getConnection();
		String sql="select * from `order` where id=?";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setObject(1, id);
		ResultSet rs= pstmt.executeQuery();
		while(rs.next()){
			int id2=rs.getInt("id");
			 name=rs.getString("name");
			 dishMegs=rs.getString("dish_megs");
			 times=rs.getString("times");
			 address=rs.getString("address");
			 states=rs.getInt("states");
			 sumPrice=rs.getBigDecimal("sum_price");
		}
		
		%>
			<div align="center">
		<form action="update.jsp?id=<%=id%>" method="post">
		 菜品:<input type="text" name="name"  value="<%=name %>"><br/>
		 菜品信息:<input type="text" name="dish_megs"  value="<%=dishMegs %>" ><br/>
		 送餐时间:<input type="text" name="times"  value="<%=times %>" ><br/>
		 送餐地址:<input type="text" name="address"  value="<%=address %>" ><br/>
		 订单状态:<input type="text" name="states"  value="<%=states %>" ><br/>
		 总金额:<input type="text" name="sum_price"  value="<%=sumPrice%>"><br/>
		 <input type="submit" value="更新">
		</form>
		</div>
	<%
	//修改
	request.setCharacterEncoding("utf-8");
	String method = request.getMethod();
	if(method.equals("POST")){
		int id2=Integer.parseInt(request.getParameter("id"));
		String name2=request.getParameter("name");
		String dishMegs2=request.getParameter("dish_megs");
		String times2=request.getParameter("times");
		String address2=request.getParameter("address");
		int states2=Integer.parseInt(request.getParameter("states"));
		
		String su=request.getParameter("sum_price");
		BigDecimal sumPrice2=new BigDecimal(su);
		
		Connection conn2=JDBCConnUtil.getConnection();
		String sql2="update `order` set `name`=?, `dish_megs`=?, `times`=?, `address`=?, states=?, `sum_price`=? where `id`= ?";
		PreparedStatement pstmt2=conn2.prepareStatement(sql2);
		pstmt2.setObject(1, name2);
		pstmt2.setObject(2, dishMegs2);
		pstmt2.setObject(3, times2);
		pstmt2.setObject(4, address2);
		pstmt2.setObject(5, states2);
		pstmt2.setObject(6, sumPrice2);
		pstmt2.setObject(7, id2);
		pstmt2.executeUpdate();
		response.sendRedirect("list.jsp");
	}
	
	%>

	
</body>
</html>