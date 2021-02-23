<%@ page language="java" import="com.utils.*, java.sql.*,java.math.BigDecimal,java.util.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>列表</title>
</head>
<body>
	<%


	List<Integer> idList=new ArrayList<>();
	List<String> nameList=new ArrayList<>();
	List<String> dishMegsList=new ArrayList<>();
	List<String> timesList=new ArrayList<>();
	List<String> addressList=new ArrayList<>();
	List<Integer> statesList=new ArrayList<>();
	List<BigDecimal> sumPriceList=new ArrayList<>();
	
	Connection conn=JDBCConnUtil.getConnection();
	String sql="select * from `order`";
	PreparedStatement pstmt=conn.prepareStatement(sql);
	ResultSet rs= pstmt.executeQuery();
	while(rs.next()){
		int id=rs.getInt("id");
		String name=rs.getString("name");
		String dishMegs=rs.getString("dish_megs");
		String times=rs.getString("times");
		String address=rs.getString("address");
		int states=rs.getInt("states");
		BigDecimal sumPrice=rs.getBigDecimal("sum_price");
		idList.add(id);
		nameList.add(name);
		dishMegsList.add(dishMegs);
		timesList.add(times);
		addressList.add(address);
		statesList.add(states);
		sumPriceList.add(sumPrice);
	}
	%>
	<div align="center">
	<a href="add.jsp">新增订单</a>
	  <table style="">
	     <tr>
            <th>订单名称</th>
            <th>菜品</th>
            <th>菜品信息</th>
            <th>送餐时间</th>
            <th>送餐地址</th>
            <th>订单状态</th>
            <th>总金额</th>
            <th>操作</th>
        </tr>
        
    <%
	int j=0;
	for(int i=0;i<nameList.size();i++){
	%>
	 <tr>
	 <td><%=idList.get(i) %></td>
	 <td><%=nameList.get(i) %></td>
	 <td><%=dishMegsList.get(i) %></td>
	 <td><%=timesList.get(i) %></td>
	 <td><%=addressList.get(i) %></td>
	  <td><%=statesList.get(i) %></td>
	  <td><%=sumPriceList.get(i) %></td>
	  <td><a href="update.jsp?id=<%=idList.get(i)%>">更新   </a><a href="delete.jsp?id=<%=idList.get(i)%>">删除</a></td>
	 </tr>
 	<% 
 		}
	%>
	</table>
	</div>
	  
</body>
</html>