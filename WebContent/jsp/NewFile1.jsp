<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="lib/layui-v2.5.5/css/layui.css" media="all">
</head>
<body>

<div style="margin-left: 35%;margin-top: 5%">
   <form class="layui-form"  method="post"  >
    
	 <div class="layui-form-item">
	    <label class="layui-form-label">用户名</label>
	    <div class="layui-input-inline">
	      <input type="text" name="userName"  lay-verify="userName"  placeholder="请输入用户名" autocomplete="off" class="layui-input">
	    </div>

	  </div>
	
	 <div class="layui-form-item">
	    <label class="layui-form-label">密码:</label>
	    <div class="layui-input-inline">
	      <input type="password" name="pwd"  lay-verify="pwd"  placeholder="请输入密码" autocomplete="off" class="layui-input">
	       </div>
	  </div>
	  
	  	 <div class="layui-form-item">
	    <label class="layui-form-label">确认密码:</label>
	    <div class="layui-input-inline">
	      <input type="password" name="validatepwd"  lay-verify="pwd"  placeholder="请输入再次密码" autocomplete="off" class="layui-input">
	       </div>
	  </div>
  
	  
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">注册</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
      
    </form>
   </div>
   
</body>
<script src="lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script type="text/javascript">

layui.use(['form','jquery'], function(){
	  var form = layui.form;
	  var $ = layui.jquery;
	 


		//自定义验证规则
			form.verify({
				userName: function(value) {
					if (value == '') {
						return '用户名不能为空';
					}
				},
				pwd: function(value) {
					if (value == '') {
						return '密码不能为空';
					} else if (value.length < 6 || value.length > 11) {
						return '请正确输入6~11位密码';
					}
				}
			});
		  
			form.on('submit(formDemo)', function(data) {		
					var param = data.field;
					
					$.ajax({
						type : "post",
						url : "control.jsp?control=control",
						data : param,
						dataType : "json",
						success : function(data){						
							console.log(data);
							if(data == '1'){
								layer.msg('注册成功！', {anim: 3, icon: 6, time: 2000, shade: 0.1});
								setTimeout(function() {
									window.location = 'login.jsp';
								}, 1000);
							} 
							if(data == '0'){
								layer.msg('注册失败！', {anim: 3, icon: 6, time: 2000, shade: 0.1});
								setTimeout(function() {
									window.location = 'register.jsp';
								}, 1000);
							} 
						},
						error:function(xhr){
							alert("错误提示： " + xhr.status + " " + xhr.statusText);
							window.location = '500.jsp';
						}
					});
				
				return false;
			});

	});
	</script>
</html>