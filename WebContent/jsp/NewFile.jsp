<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
        <%
 String path = request.getContextPath();
 String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="lib/layui-v2.5.5/css/layui.css" media="all">
<link rel="stylesheet" href="css/login.css">
</head>
<body>

<div class="admin-login-background">
        <!--<div class="admin-header">-->
        <!--<img src="image/ex_logo.png" class="admin-logo">-->
        <!--</div>-->
        <form class="layui-form" >
            <div>
                <i class="layui-icon layui-icon-username admin-icon admin-icon-username"></i>
                <input type="text" name="userName" placeholder="请输入用户名"  lay-verify="userName" 
                       autocomplete="off" 
                       class="layui-input admin-input admin-input-username">
            </div>
            <div>
                <i class="layui-icon layui-icon-email admin-icon layui-icon-email"></i>
                <input type="email" name="email"  lay-verify="pwd"  
                       placeholder="请输入邮箱" 
                       autocomplete="off"
                       class="layui-input admin-input">
            </div>
                                    
            <button class="layui-btn admin-button" lay-submit lay-filter="formDemo">确定</button>


        </form>
    </div>

</body>
<script src="lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

<script>
layui.use(['form','jquery'], function(){
  var form = layui.form;
  var $ = layui.jquery;

  
	form.on('submit(formDemo)', function(data) {		
			var param = data.field;
			
			$.ajax({
				type : "post",
				url : " <%=basePath%>login?action=mail",
				data : param,
				dataType : "json",
				success : function(data){	
					
				},
				error:function(xhr){
					//alert("错误提示： " + xhr.status + " " + xhr.statusText);
					window.location = '500.jsp';
				}
			});
		
		return false;
	});
});
</script>
</html>