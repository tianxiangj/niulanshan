<%@ page language="java" import="com.utils.*, java.sql.*,java.math.BigDecimal" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>列表</title>
</head>
<body>
	<%

	int id=0;
	String name=null;
	String dishMegs=null;
	String times=null;
	String address=null;
	int states=0;
	BigDecimal sumPrice;
	Connection conn=JDBCConnUtil.getConnection();
	String sql="select * from `order`";
	PreparedStatement pstmt=conn.prepareStatement(sql);
	ResultSet rs= pstmt.executeQuery();
	while(rs.next()){
		id=rs.getInt("id");
		name=rs.getString("name");
		dishMegs=rs.getString("dish_megs");
		times=rs.getString("times");
	}
	%>
	  <table>
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
	<c:forEach var="" items="\">
 	</c:forEach>
 	</table>
</body>
</html>