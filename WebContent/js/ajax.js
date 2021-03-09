//application/x-www-form-urlencoded, multipart/form-data, or text/plain
//封装
function ajax(url,type,contentType,json,reqType,formData,successBackFun,errBackfun,$formDom){
	if(reqType == "obj"){                     //不支持图片上传,非formData
	    $.ajax({
            //请求方式
            type : type,
            //请求的媒体类型
            contentType: contentType,
            //请求地址
            url : url,
            dataType: "json",
            //数据，json字符串
            data : json,
            //请求成功
            success : function(result) {
                console.log(result);
                backFun(result);
                
            },
            //请求失败，包含具体的错误信息
            error : function(e){
                console.log(e.status);
                console.log(e.responseText);
                errBackfun(e.responseText);
            }
         });		
	}else if(reqType == "formdata"){         //图片上传,formData
		 $.ajax({
	           dataType: "json",
	          // 提交方式 get 或 post
               type: type,
              // 需要访问的 Servlet 的映射路径 urlPatterns
               url:  url, 
               data: formData,
               //请求的媒体类型
               contentType: contentType,
               success: function(data) {
               	   console.log(data)
               	   backFun(data)
               },
                //请求失败，包含具体的错误信息
               error : function(e){
                   console.log(e.status);
                   console.log(e.responseText);
               }

         });

	}else if(reqType == "dom"){

		 $.ajax({
                 //几个参数需要注意一下
                type: type,//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: url,//url
                data: $formDom.serialize(),
                success: function (result) {
                    console.log(result);//打印服务端返回的数据(调试用)
                    backFun(result)
                },
                error : function() {
                    console.log(e.status);
                    console.log(e.responseText);
                }
          });

	}
	
}