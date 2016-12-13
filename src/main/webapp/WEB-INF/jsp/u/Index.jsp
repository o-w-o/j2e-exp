<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    
    if (session.getAttribute("utype") == null) {
        session.setAttribute("utype", "anonymous");
        response.sendRedirect(path + "/anonymous");
    } else if(session.getAttribute("utype") != "user"){
        response.sendRedirect(path + "/");
    };
    
    String uid = session.getAttribute("uid").toString();
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
        <link href="<%=path%>/lib/animate.css" rel="stylesheet" />
        <link href="<%=path%>/css/app.css" rel="stylesheet" />
        
        <style> 
            .ubox{
                display:none;
            }
            .ubox.active{
                display:block;
            }
            #notify-wrap .sign-notify{
                background-color: #fb5959;
                display: none;
                position: absolute;
                height: 20px;
                width: 20px;
                top: -8px;
                right: -8px;
                border-radius: 50%;
                border: 2px solid #fff;
                box-shadow: -.5px .5px 1px RGBA(72, 72, 72, 0.51);
                line-height: 25px;
                text-align: center;
                color: #fff;
                font-weight: 900;
                font-size: 11px;
                line-height: 16px;
            }
            #notify-wrap .sign-notify.true{
                display: block;
            }
        </style>
        <script src="<%=path%>/lib/jquery.min.js"></script>
        <script src="<%=path%>/lib/vue.min.js"></script>
        <script src="<%=path%>/lib/tinymce/tinymce.min.js" type="text/javascript"></script>
        
        <script src="<%=path%>/lib/velocity.min.js" type="text/javascript"></script>
        <script src="<%=path%>/dwr/engine.js" type="text/javascript"></script>  
        <script src="<%=path%>/dwr/util.js" type="text/javascript"></script>  
        <script src="<%=path%>/dwr/interface/notify.js"></script>  

        <script> var app = new Object(); app.path = "<%=path%>"; </script>
        <script src="<%=path%>/js/app.common.js" type="text/javascript"></script>
        <script src="<%=path%>/js/app.user.js" type="text/javascript"></script>

        <!--        
        <script>
                //这个方法用来启动该页面的ReverseAjax功能
                dwr.engine.setActiveReverseAjax( true);
                //设置在页面关闭时，通知服务端销毁会话
                dwr.engine.setNotifyServerOnPageUnload( true);

                var tag = "\${uid}";    //自定义一个标签
                notify.onPageLoad(tag);
        
        </script>
        -->
        
    </head>
    
    <body class="page-default" id='lms-main' onload="dwr.engine.setActiveReverseAjax(true);dwr.engine.setNotifyServerOnPageUnload(true);notify.onPageLoad();">
        
        <!--header-->
        <header class="header header-brand header-waterfall ui-header" id="app-header">

            <ul class="nav nav-list pull-left">
                <li>
                    <a href="<%=path%>/">
                        <span class="icon icon-lg">home</span>
                    </a>
                </li>
            </ul>
            
            <span class="header-logo" >NPS系统 | <span id="header-location">主页</span></span>
            
            <ul class="nav nav-list pull-right" id="uheader">
                
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
                            <a class="waves-attach waves-effect sign-out" href="javascript:void(0)">
                                <span class="icon mg-sm-right">exit_to_app</span> 退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>                  
        </header>
        
        <!--app main content-->                
        <div id="app-content" class="container-fuild">
            
            <!--app-nav-btn-->
            <nav class="fbtn-container" id="app-ubtn">
                

                <div class="fbtn-inner">
                    <a class="fbtn btn-grey waves-attach waves-circle waves-light" data-toggle="tab" href="#panel-Index">
                        <span class="fbtn-text fbtn-text-left">个人面板</span><span class="icon">keyboard_return</span>
                    </a>
                </div>

                <div class="fbtn-inner">
                    <a class="fbtn btn-aqua waves-attach waves-circle waves-light waves-effect"  
                       data-toggle="tab" href="#app-managecalc">
                        <span class="fbtn-ori icon">view_list</span><span class="fbtn-text fbtn-text-left">表格管理</span>
                    </a>
                </div>

                <div class="fbtn-inner" id="notify-wrap">
                    <a class="fbtn fbtn-trans waves-attach waves-circle waves-light waves-effect"  
                       data-toggle="tab" href="#app-evolution">
                        <span class="fbtn-ori icon">notifications</span><span class="fbtn-text fbtn-text-left">消息管理</span>
                    </a>
                    <span class="sign-notify true">13</span>
                </div>

                <div class="fbtn-inner">
                    <a class="fbtn fbtn-trans waves-attach waves-circle waves-light" data-toggle="dropdown">
                        <span class="fbtn-ori icon">more_vert</span><span class="fbtn-sub icon">close</span>
                    </a>
                    <div class=" fbtn-dropdown">
                        <a class="fbtn waves-attach waves-circle waves-light" href="javascript:void(0)">
                            <span class="fbtn-text fbtn-text-left">逗你玩儿！</span><span class="icon">mood</span>
                        </a>
                    </div>
                </div>

            </nav>
            
            <!--content-->
            <div class="tab-content" >
                
                <!--Cacl:LibreOffice Cacl                
                    LibreOffice 是一套可与其他主要办公室软件相容的套件，包含6大组件：文本文档【文字处理（word）】，电子表格【计算表（excel）】，演示文稿【简报（powerpoint）】，公式，绘图，资料库【access】，具体名称为：
                        （1）LibreOffice文本文档
                    ---э（2）LibreOffice电子表格 (LibreOffice Cacl)
                        （3）LibreOffice演示文稿
                        （4）LibreOffice公式
                        （5）LibreOffice绘图
                        （6）LibreOffice数据库
                -->
                <jsp:include page="IncludeCaclManage.jsp"/>

                <!--Evolution 
                    是用于 GNU/Linux 和 基于 UNⅨ 的系统的功能完善的个人和工作组信息管理工具，
                    它还是 Gnome桌面 的默认电子邮件客户。
                -->
                <jsp:include page="IncludEvolution.jsp"/>
                
            </div>
            
        </div>


        <!--scrollup btn-->
        <div class="fbtn-container" > 
            <div class="fbtn-inner" id="scrollUp">
                <a class="fbtn fbtn-trans waves-attach waves-circle waves-light waves-effect" >
                    <span class="fbtn-ori icon">keyboard_arrow_up</span><span class="fbtn-text fbtn-text-left">返回顶部</span>
                </a>
            </div>
        </div>

        <!--snackbar-->
        <div id="snackbar"></div>

        <!--modal-->
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
            
        <!--footer-->
        <footer class="ui-footer" id="tree-footer">
            <div class="container">
                <p >
                    <strong>Copyright © 2016 软工一班  llgt · 【 NPS System 】</strong>
                </p>
            </div>
        </footer>
        
        <!-- js -->
        <script src="<%=path%>/lib/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/jquery.scrollUp.min.js" type="text/javascript"></script>
        <script>NProgress.done();</script>
        
        <script>
            
            $('.sign-out').click(function(){
                app.signout();
            });
            
        </script>
        
    </body>  
</html>