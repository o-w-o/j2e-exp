<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    
    String tid = request.getParameter("tid");
    String title = request.getParameter("title");
    String structure = request.getParameter("structure");
    String caclDataUrl = path + "/u?target=getcacldata&tid=" + tid;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--进度条-->
        <link href="<%=path%>/lib/nprogress.css" rel="stylesheet" type="text/css"/>
        <script src="<%=path%>/lib/nprogress.js" type="text/javascript"></script>
        <script>NProgress.start();</script>

        <!-- css -->
        <link href="<%=path%>/lib/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/lib/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/app.css" rel="stylesheet" />
        <link href="<%=path%>/lib/jquery.contextMenu.min.css" rel="stylesheet"/>
        <link href="<%=path%>/lib/datagird/dist/bootstrap-table.min.css" rel="stylesheet"/>
        
        <!--lib-->    
        <script src="<%=path%>/lib/jquery.min.js"></script>
        <script src="<%=path%>/lib/vue.min.js"></script>
        
        <style>
            /*            
            #cacl-of-dg{
                display: none;
                height: 0;
                overflow: hidden;
                transition: all .5s;
                
            }
            #cacl-of-dg.activated{
                display: block;
                height: auto;
                overflow: auto;
            }
            */
            #cacl-of-dg {
                padding: 5em 1em !important;
            }
            #cacl-of-dg .fixed-table-toolbar{
                background-color: rgb(255, 255, 255);
                position: fixed;
                right: 0;
                top: 0px;
                height: 56px;
                z-index: 30;
                padding: 0 1em;
                width: 100%;
            }
        </style>
        
    </head>
    <body  class="container mg-hd-top">
        <div id="cacl-of-dg">
            
        <h1 class="cacl-title"><%=title%></h1>
        
        <div id="toolbar" class="bootstrap-table-toolbar">

            <select class="form-control" style="">
                <option value="">请选择</option>
                <option value="all">全部导出</option>
                <option value="selected">选择导出</option>
            </select>

        </div>

        <table id="dg"  
               data-toggle="table"
               data-url="<%=caclDataUrl%>"
               data-toolbar="#toolbar"
               data-search="true"
               data-show-refresh="true"
               data-search-on-enter-key="ture"
               data-checkbox="true"
               data-show-toggle="true"
               data-show-export="true"
               data-minimum-count-columns="2"
               data-show-pagination-switch="true"
               data-pagination="true"
               data-page-list="[10, 25, 50, 100, ALL]"
               data-page-size="10"	
               v-once
               >
            <thead>
                <tr>
                    <th data-checkbox="true"></th>
                    <th v-for="item in thead"
                        v-bind:data-field="item.title" 
                        v-bind:data-sortable="true"
                        
                        >
                        {{item.title}}</th>
                </tr>
            </thead>
        </table>
        </div>
        <!--vue init...-->
        <script>
            var CaclDg = new Vue({
                el:'#cacl-of-dg',
                data:{
                    thead:''
                },
                methods:{
                    
                },
                created: function(){
                    var obj = JSON.stringify(<%=structure%>);
                    this.thead= JSON.parse(obj);
                },
                mounted: function(){
                    console.log(this.thead);
                    //initDg();
                }
            });
        </script>

        <script src="<%=path%>/lib/datagird/dist/bootstrap-table.min.js"></script>
        <script src="<%=path%>/lib/datagird/dist/extensions/export/bootstrap-table-export.min.js"></script>
        <script src="<%=path%>/lib/datagird/dist/extensions/toolbar/bootstrap-table-toolbar.min.js"></script>
        <script src="<%=path%>/lib/datagird/dist/locale/bootstrap-table-zh-CN.min.js"></script>
        <script src="<%=path%>/lib/datagird-export.js"></script>
        <script src="<%=path%>/lib/jquery.contextMenu.min.js"></script>
        <script src="<%=path%>/lib/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/lib/project.min.js" type="text/javascript"></script>
        <!--<script src="<%=path%>/lib/jquery.scrollUp.min.js" type="text/javascript"></script>-->
        <!--datagird init...-->
        <script>
            var $dgThisCacl = $('#dg');
            $(function () {
                $('#toolbar').find('select').change(function () {
                    $dgThisCacl.bootstrapTable('destroy').bootstrapTable({
                        exportDataType: $(this).val(),
                        exportFileName: '<%=title%>'
                    });
                });
            });
            
        </script>
        <script>NProgress.done();</script>
    </body>
</html>
