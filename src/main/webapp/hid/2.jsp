<%-- 
    Document   : hid-2
    Created on : 2016-11-13, 10:29:55
    Author     : dot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";

    session.setAttribute("uname", "anonymous");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>NPS HID:2</title>



        <!--进度条-->
        <link href="lib/nprogress.css" rel="stylesheet" type="text/css"/>
        <script src="lib/nprogress.js" type="text/javascript"></script><script>NProgress.start();</script>

        <!-- css -->
        <link href="<%=path%>/lib/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/jquery.fs.boxer.css" rel="stylesheet" />
        <link href="<%=path%>/css/app.css" rel="stylesheet" />
    </head>
    <body>
        <div class="container">
            <div class="h1 text-center">九九乘法表</div>
            <%
                StringBuffer str = new StringBuffer("");
                str.append("<table class='table'>");
                for (int i = 1; i < 10; i++) {
                    str.append("<tr>");
                    for (int k = 1; k < 10; k++) {

                        if (k <= i) {
                            str.append("<td>" + i + "x" + k + "=" + i * k + "</td>");
                        } else {
                            str.append("<td></td>");
                        }
                    }
                    str.append("</tr>");
                }
                str.append("</table>");
                out.print(str.toString());

            %>
        </div>
    </body>
</html>
