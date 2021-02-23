<%@ page language="java" import="com.utils.*, java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
int id=Integer.parseInt(request.getParameter("id"));
Connection conn=JDBCConnUtil.getConnection();
String sql="delete from `order` where id=?";
PreparedStatement pstmt=conn.prepareStatement(sql);
pstmt.setObject(1, id);
pstmt.executeUpdate();
response.sendRedirect("list.jsp");
%>
</body>
</html>