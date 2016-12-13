<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    
    if (session.getAttribute("utype") == null) {
        session.setAttribute("utype", "anonymous");
        response.sendRedirect(path + "/anonymous");
    } else if(session.getAttribute("utype") != "anonymous"){
        response.sendRedirect(path + "/");
    };
%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        
        <meta charset="UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>NPS 首页</title>
        
        
        
        <!--进度条-->
        <link href="lib/nprogress.css" rel="stylesheet" type="text/css"/>
        <script src="lib/nprogress.js" type="text/javascript"></script><script>NProgress.start();</script>
        
        <!-- css -->
        <link href="<%=path%>/lib/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/app.css" rel="stylesheet" />
        <script> var app = new Object(); app.path = "<%=path%>"; </script>
        <script src="<%=path%>/js/app.common.js" type="text/javascript"></script>

        <style>
            #app-login{
                background-image: url(<%=path%>/images/bg.jpg);
                position: fixed;
                height: 100%;
                width: 100%;
            }
            #login-form-wrap{
                width: 960px;
                margin: auto;
                height: 100%;

                display: flex;
                justify-content: center;
                align-items: center;

            }
            #tree-footer{
                background-color: rgba(0,0,0,.3);
                color:#FFF;
            }
        </style>
        
        <script src="<%=path%>/lib/jquery.min.js"></script>
        <script src="<%=path%>/lib/vue.min.js"></script>
        
    </head>
    
    <body class="page-default tab-content hidden" id='lms-main'>
        
        <div class="stage-image " id="app-login">
            <div class="container-fuild" style="height: inherit;padding: 0;">
                <div class="row" id="login-form-wrap">
                    <form id="login-form" class="card col-md-12 form-horizontal" role="form" action="/app?action=login" method="post">

                        <!--ID号-->
                        <div class="form-group form-group-label col-md-5">
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="floating-label" for="id">ID号</label>
                                    <input type="text" class="form-control" id="id" name="id" placeholder="请输入学生证号/教职工号" value="14452020">
                                </div>
                            </div>
                        </div>

                        <!--密码-->
                        <div class="form-group form-group-label col-md-5">
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="floating-label" for="pw">密码</label>
                                    <input type="password" class="form-control" id="pw"  name="pw" placeholder="请输入密码" onkeydown="keyListener(event)" value="123">
                                </div>
                            </div>
                        </div>

                        <div class="form-group form-group-label col-md-2">
                            <div type="submit" class="btn-gold btn-card btn-success btn-block" onclick="trySignIn()">登录</div>
                        </div>

                    </form>
                </div>
            </div>

            <footer class="ui-footer" id="tree-footer">
                <div class="container">
                    <p >
                        <strong>Copyright © 2016 软工一班  llgt · 【 NPS System 】</strong>
                    </p>
                </div>
            </footer>
        </div>
            
        <!--单向信息传递 snackbar-->
        <div id="snackbar" class="z-index-covermsg"></div>
        
        <!--退出框 modal-->
        <div class="modal fade z-index-covermsg" id="modal" role="dialog" >
            <div class="modal-dialog modal-xs">
                <div class="modal-content">
                    <div class="modal-heading">
                        <a class="modal-close" data-dismiss="modal">×</a>
                        <h2 class="modal-title">:-)</h2>
                    </div>
                    <div class="modal-inner">
                        <p class="test-center h5" id="modal-msg">

                        </p>
                    </div>
                    <div class="modal-footer">
                        <p class="text-right"><button class="btn btn-flat btn-brand waves-attach waves-effect" data-dismiss="modal" type="button">关闭</button></p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- js -->
        <script src="<%=path%>/lib/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/jquery.scrollUp.min.js" type="text/javascript"></script>
        <script>NProgress.done();</script>
        <script>
             //返回顶部 插件 scrollUp 配置
             $(function () {
		            $.scrollUp({
		                scrollName: 'scrollUp',      // Element ID
		                scrollDistance: 0,         // Distance from top/bottom before showing element (px)
		                scrollFrom: 'top',           // 'top' or 'bottom'
		                scrollSpeed: 300,            // Speed back to top (ms)
		                easingType: 'linear',        // Scroll to top easing (see http://easings.net/)
		                animation: 'fade',           // Fade, slide, none
		                animationSpeed: 200,         // Animation speed (ms)
		                scrollTrigger: false,        // Set a custom triggering element. Can be an HTML string or jQuery object
		                scrollTarget: false,         // Set a custom target element for scrolling to. Can be element or number
		                scrollText: '',                  // Text for element, can contain HTML
		                scrollTitle: false,           // Set a custom <a> title if required.
		                scrollImg: false,            // Set true to use image
		                activeOverlay: false,    // Set CSS color to display scrollUp active point, e.g '#00FFFF'
		                zIndex: 2000                 // Z-Index for the overlay
		                            }); });
             
             $('#ajax-test').click(function(){
                 
                $.ajax({
                   url: "<%=path%>/app?target=user",
                   type: 'get',
                   async: false,
                   success: function (data) {
                       console.log(data);
                       $('#test').html(data);
                       status = 0;
                   },
                   error: function () {
                       status = -1;
                   }
               });
               
             });
        </script>

        <script>
            function trySignIn() {

                if (!isSignInfoNull()) {
                    $("#loginMsg").html("正在登录...请稍后...");
                    tryChangeRole();
                }

            };
            
            function tryChangeRole(){
                $.ajax({
                   url: "<%=path%>/role?target=signIn&uid=" +  $("#id").val() + "&password=" + $("#pw").val(),
                   //url: "<%=path%>/role?target=signIn&uid=1445202015&password=123",
                   //url: "<%=path%>/role?target=signIn&uid=1445202013&password=123",
                   type: 'post',
                   async: false,
                   success: function (data) {
                        if (data === "false") {
                            app.msg.alert("输入的账户或密码错误，请重试...");
                            $("#pw").val("");
                        }else if (data === "ok") {
                            app.msg.snackbar("登录成功!");
                            signInBefore();
                        }else{
                            app.msg.snackbar("未知错误!");
                        }
                   },
                   error: function () {
                       app.msg.snackbar("未知错误!");
                       status = -1;
                   }
               });
            }
            
            function isSignInfoNull(){
                var id = $("#id"),pw = $("#pw"),msg = "";
                
                if(id.val() === ''){
                    msg = "ID号不能为空...";
                } else if(pw.val() === ''){
                    msg = "密码不能为空...";
                } else {
                    return false;
                }
                
                //app.msg.snackbar(msg);
                app.msg.alert(msg);
                
                return true;
            }
            
            function signInBefore(){
                window.top.location = "<%=path%>/";
            }
            
            //验证码框响应回车键提交登录
            function keyListener(e) {
                var keynum;
                var status = false;

                if (window.event){ keynum = e.keyCode; } else if (e.which){  keynum = e.which; }
                if (keynum === 13) {
                    trySignIn();
                }
            };
            
            //tryChangeRole();
        </script>
    </body>  
</html>