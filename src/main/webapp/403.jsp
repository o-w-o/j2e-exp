<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true" %>
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>403 Error !</title>
        <!-- css -->
        <link href="<%=path%>/lib/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/app.css" rel="stylesheet" />
        <link href="<%=path%>/css/page.css" rel="stylesheet" />
        <link href="<%=path%>/css/tools.css" rel="stylesheet" />
    </head>
    <body class="container-full stage-image" style="background-image: url(<%=path%>/images/bg-status-code.svg)">
        <div class="div-center lms-status-page card">
            <div class="lms-status-code">403</div>
        </div>
    </body>
</html>