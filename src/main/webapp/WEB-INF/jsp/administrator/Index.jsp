<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    
    if (session.getAttribute("utype") == null) {
        session.setAttribute("utype", "anonymous");
        response.sendRedirect(path + "/anonymous");
    } else if(session.getAttribute("utype") != "admin"){
        response.sendRedirect(path + "/");
    };
%>
<html>
    <head>
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>NPS 管理员</title>



        <!--进度条-->
        <link href="lib/nprogress.css" rel="stylesheet" type="text/css"/>
        <script src="lib/nprogress.js" type="text/javascript"></script><script>NProgress.start();</script>

        <!-- css -->
        <link href="<%=path%>/lib/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/app.css" rel="stylesheet" />

        <script src="<%=path%>/lib/jquery.min.js"></script>
        <script src="<%=path%>/lib/vue.min.js"></script>
        <script src="<%=path%>/dwr/engine.js" type="text/javascript"></script>  
        <script src="<%=path%>/dwr/util.js" type="text/javascript"></script>  
        <script src="<%=path%>/dwr/interface/notify.js"></script>  
        
        <script> var app = new Object(); app.path = "<%=path%>"; </script>
        <script src="<%=path%>/js/app.common.js" type="text/javascript"></script>
        <script src="<%=path%>/js/app.administrator.js" type="text/javascript"></script>

        <style>
            #panel-manageUsers .bootstrap-table{
                width: 1200px;
                height: auto;
                margin: 1em auto;
                padding: 1em;
                margin-bottom: 12em;
                
            }
            #panel-manageUsers .fixed-table-body{
                height: auto;
            }
            #scrollUp{
                position: fixed !important;
                right: 16px;
                bottom: 12px;
            }
        </style>
    </head>
    <body>
        <!--header-->
        <header class="header header-brand header-waterfall ui-header" id="app-header">

            <ul class="nav nav-list pull-left">
                <li>
                    <a href="<%=path%>/">
                        <span class="icon icon-lg">home</span>
                    </a>
                </li>
            </ul>

            <span class="header-logo" >NPS系统 | <span id="header-location">管理员</span></span>

            <ul class="nav nav-list pull-right" id="uheader">

                <!--                
                <li class="nav-item">
                    <a href="#"><span class="nav-item-text">登录</span><span class="icon icon-lg nav-item-icon">input</span></a>
                </li>
                -->

                <li class="dropdown">
                    <a class="dropdown-toggle padding-left-no padding-right-no" data-toggle="dropdown" >
                        <span class="access-hide">Avatar</span>
                        <span class="avatar avatar-sm"><span class="icon mg-sm-right" id="uavatar-small">account_circle</span></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li class="">
                            <a class="waves-attach waves-effect" href="javascript:void(0)">
                                <span class="icon mg-sm-right">person</span> 个人信息
                            </a>
                        </li>
                        <li class="divider-b"></li>
                        <li class="">
                            <a class="waves-attach waves-effect" href="javascript:void(0)">
                                <span class="icon mg-sm-right">settings</span> 设置
                            </a>
                        </li>
                        <li class="divider-b"></li>
                        <li class="">
                            <a class="waves-attach waves-effect" href="javascript:void(0)" onclick="signOut()">
                                <span class="icon mg-sm-right">exit_to_app</span> 退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>                  
        </header>

        <!--App Main Content-->                
        <div id="app-content" class="app-m" style="margin-bottom: 15em;">
            
            <nav class="fbtn-container" id="app-ubtn">


                <div class="fbtn-inner">
                    <a class="fbtn btn-grey waves-attach waves-circle waves-light" data-toggle="tab" href="#panel-Index">
                        <span class="fbtn-text fbtn-text-left">个人面板</span>
                        <span class="icon pos-op-3px">keyboard_return</span>
                    </a>
                </div>

                <div class="fbtn-inner">
                    <a class="fbtn btn-aqua waves-attach waves-circle waves-light waves-effect"  data-toggle="tab" href="#panel-manageUsers">
                        <span class="fbtn-ori icon">people</span>
                        <span class="fbtn-text fbtn-text-left">用户管理</span>
                    </a>
                </div>

                <div class="fbtn-inner">
                    <a class="fbtn fbtn-trans waves-attach waves-circle waves-light waves-effect" onclik="toggle">
                        <span class="fbtn-ori icon">notifications</span>
                        <span class="fbtn-text fbtn-text-left">消息管理</span>
                    </a>
                </div>

            </nav>
            
            <div class="tab-content">

                <!--控制面板-->
                <div id="panel-Index" class="container tab-pane fade">
                    <div class="bg-content z-index-bg"></div>
                    <!-- 个人面板 -->
                    <div class="row"> 
                        <div class="card col-md-12">

                            <div class="card-main">
                                <div class="card-inner">
                                    <div class="card-heading">控制面板</div>
                                    <div id="itisme">


                                        <ul class="">
                                            <li><a id="ajax-test">TEST</a></li>
                                            <li><a id="ajax-getall">TEST GET ALL USER INFO JSON</a></li>

                                            <p id="test"></p>
                                        </ul> 
                                    </div>
                                </div>
                                <div class="card-action">
                                    <div class="card-action-btn" style="margin:6px 16px;">
                                        <a href="javascript:void(0);" 
                                           class="btn btn-flat lms-c-text-light stage-card waves-attach pull-right" 
                                           style="text-align: right;"> 查看 / 修改 个人信息
                                            <span class="icon margin-left-sm">open_in_new</span> 
                                        </a>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row"> 
                        <div class="card col-md-12">

                            <div class="card-main">
                                <div class="card-inner">
                                    <div class="card-heading">服务器信息</div>
                                    <div class="sample-height">
                                        <iframe onload ="startInit('EnvInfo', 500);"  src="<%=path%>/admin/env" id="EnvInfo" frameborder="0" scrolling="no" marginheight="0"  width="100%" name="服务器信息" ></iframe> 
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- 个人面板 END-->                

                </div>

                <!--用户管理-->                    
                <div id="panel-manageUsers" class="container-fuild tab-pane fade in active">
                    <jsp:include page="IncludeUserManage.jsp" />
                    <!--<iframe onload ="startInit('UserManage', 500);"  src="<%=path%>/admin/usr" id="UserManage" frameborder="0" scrolling="no" marginheight="0"  width="100%" name="用户管理" ></iframe>--> 
                </div>

            </div>


            <!--message-->
            <jsp:include page="IncludeInbox.jsp" />
            
        </div>
            
        <!--footer-->
        <footer class="footer ui-footer" id="tree-footer">
            <div class="container">
                <p >
                    <strong>Copyright © 2016 软工一班  llgt · 【 NPS System 】</strong>
                </p>
            </div>
        </footer>  
        
        <!--scorll up-->
        <div class=" fbtn-container" id="scrollUp">
            <a class="fbtn fbtn-trans waves-attach waves-circle waves-light waves-effect" >
                <span class="fbtn-ori icon">keyboard_arrow_up</span><span class="fbtn-text fbtn-text-left">返回顶部</span>
            </a>
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
        <script src="<%=path%>/lib/jquery.fs.core.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/transition.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/jquery.fs.boxer.min.js" type="text/javascript"></script>
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

                }); 
            });
             $('#ajax-test').click(function(){
                 
                $.ajax({
                   url: "<%=path%>/app?target=test",
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
             $('#ajax-getall').click(function(){
                 
                $.ajax({
                   url: "<%=path%>/admin?target=getallinfo",
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
             $('#ajax-autoadd').click(function(){
                 
                $.ajax({
                   url: "<%=path%>/admin?target=autoadd",
                   type: 'post',
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
            function signOut(){
                $.ajax({
                   url: "<%=path%>/role?target=signOut",
                   type: 'post',
                   async: false,
                   success: function (data) {
                        if (data === "ok") {
                            app.msg.alert("正在退出...");
                            $("#pw").val("");
                        }else{
                            app.msg.snackbar("未知错误!请尝试刷新页面...");
                        }
                   },
                   error: function () {
                       app.msg.snackbar("未知错误!请尝试关闭浏览器...");
                       status = -1;
                   }
               });
               window.top.location = "<%=path%>/";
            }
        </script>
        <script type="text/javascript">
            var browserVersion = window.navigator.userAgent.toUpperCase();
            var isOpera = false, isFireFox = false, isChrome = false, isSafari = false, isIE = false;
            function reinitIframe(iframeId, minHeight) {
                try {
                    var iframe = document.getElementById(iframeId);
                    var bHeight = 0;
                    if (isChrome == false && isSafari == false)
                        bHeight = iframe.contentWindow.document.body.scrollHeight;
                    var dHeight = 0;
                    if (isFireFox == true)
                        dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    else if (isIE == false && isOpera == false)
                        dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    else if (isIE == true && !-[1, ] == false) {
                    } //ie9+
                    else
                        bHeight += 3;
                    var height = Math.max(bHeight, dHeight);
                    if (height < minHeight)
                        height = minHeight;
                    iframe.style.height = height + "px";
                } catch (ex) {
                }
            }
            function startInit(iframeId, minHeight) {
                isOpera = browserVersion.indexOf("OPERA") > -1 ? true : false;
                isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
                isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
                isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
                if (!!window.ActiveXObject || "ActiveXObject" in window)
                    isIE = true;
                window.setInterval("reinitIframe('" + iframeId + "'," + minHeight + ")", 100);
            }   
        </script>
        
    </body>
</html>
