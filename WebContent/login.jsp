<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
 String path = request.getContextPath();
 String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
 %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理-登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="lib/layui-v2.5.5/css/layui.css" media="all">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        html, body {width: 100%;height: 100%;overflow: hidden}
        body {background: #1E9FFF;}
        body:after {content:'';background-repeat:no-repeat;background-size:cover;-webkit-filter:blur(3px);-moz-filter:blur(3px);-o-filter:blur(3px);-ms-filter:blur(3px);filter:blur(3px);position:absolute;top:0;left:0;right:0;bottom:0;z-index:-1;}
        .layui-container {width: 100%;height: 100%;overflow: hidden}
        .admin-login-background {width:360px;height:300px;position:absolute;left:50%;top:40%;margin-left:-180px;margin-top:-100px;}
        .logo-title {text-align:center;letter-spacing:2px;padding:14px 0;}
        .logo-title h1 {color:#1E9FFF;font-size:25px;font-weight:bold;}
        .login-form {background-color:#fff;border:1px solid #fff;border-radius:3px;padding:14px 20px;box-shadow:0 0 8px #eeeeee;}
        .login-form .layui-form-item {position:relative;}
        .login-form .layui-form-item label {position:absolute;left:1px;top:1px;width:38px;line-height:36px;text-align:center;color:#d2d2d2;}
        .login-form .layui-form-item input {padding-left:36px;}
        .captcha {width:60%;display:inline-block;}
        .captcha-img {display:inline-block;width:34%;float:right;}
        .captcha-img img {height:34px;border:1px solid #e6e6e6;height:36px;width:100%;}
    </style>
</head>
<body>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" action="">
                <div class="layui-form-item logo-title">
                    <h1>niulanshan</h1>
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username" for="username"></label>
                    <input type="text" id="username" name="name" lay-verify="required|account" placeholder="用户名或者邮箱" autocomplete="off" class="layui-input" value="">
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-password" for="password"></label>
                    <input type="password" id="userpwd" name="pwd" lay-verify="required|password" placeholder="密码" autocomplete="off" class="layui-input" value="">
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-vercode" for="captcha"></label>
                    <input type="text" name="captcha" lay-verify="required|captcha" placeholder="图形验证码" autocomplete="off" class="layui-input verification captcha" >
                    <div class="captcha-img">
                        <img id="check" src="${pageContext.request.contextPath}/login?action=cache">
                    </div>
                </div>
                
                <div class="layui-form-item">
                    <input type="checkbox" name="textpwd" id="checked" value="true" lay-skin="primary" title="记住密码" >
                    <a href="${pageContext.request.contextPath}/login?action=ftp" style="margin-left: 100px" >忘记密码？</a>
                </div>
                
                
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="login" id="login">登 入</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="lib/jquery.cookie.js" charset="utf-8"></script>
<script src="js/ajax.js" charset="utf-8"></script>
<script src="lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="lib/jq-module/jquery.particleground.min.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer;

        // 登录过期的时候，跳出ifram框架
        if (top.location != self.location) top.location = self.location;

        // 粒子线条背景
        $(document).ready(function(){
            $('.layui-container').particleground({
                dotColor:'#7ec7fd',
                lineColor:'#7ec7fd'
            });
        });

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


     // $("#login").click(function () {
    	// var data= ajax(type,url,json);
       //   )}

        
    	form.on('submit(login)', function(data) {		
    			var param = data.field;
    			
    			$.ajax({
    				type : "post",
    				url :' <%=basePath%>login?action=login',
    				data : param,
    				dataType : "json",
    				success : function(data){	
    					console.log(data);
    					if(data == '1'){   						
    						layer.msg('登录成功！', {anim: 3, icon: 6, time: 2000, shade: 0.1});
    						setTimeout(function() {
    							window.location = 'index.jsp';
    						}, 1000);
    					} else if(data == '0') {
    		                  layer.msg('密码或用户名错误，登录失败',{anim: 6, icon: 5, time: 1500, shade: 0.1});
    		                  $('#userpwd').val("");
    					} else if(data == '-1') {
  		                  layer.msg('验证码错误，登录失败',{anim: 6, icon: 5, time: 1500, shade: 0.1});
		                  $('#userpwd').val("");
					} 
    				},
    				error:function(xhr){
    					//alert("错误提示： " + xhr.status + " " + xhr.statusText);
    					window.location = '500.jsp';
    				}
    			});
    		
    		return false;
    	});
    });
    
	 $('#username').val($.cookie("cookieuser"));  
	 $('#userpwd').val($.cookie("cookiePwd"));  
	if($.cookie("cookieuser")!=null){
		$("#checked").prop("checked",true);
		}
  //验证码点击刷新
      var elementById = document.getElementById("check");
      elementById.onclick=function () {
          var date = new Date();
          var time = date.getTime();
          elementById.src="${pageContext.request.contextPath}/login?action=cache&"+time;
      }
</script>
</body>
</html>