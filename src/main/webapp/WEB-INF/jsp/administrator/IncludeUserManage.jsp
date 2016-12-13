<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>

    <!--lib-->    
    <link href="<%=path%>/lib/datagird/dist/bootstrap-table.min.css" rel="stylesheet" type="text/css"/>
    <script src="<%=path%>/lib/datagird/dist/bootstrap-table.min.js" type="text/javascript"></script>
    <script src="<%=path%>/lib/datagird/dist/extensions/export/bootstrap-table-export.min.js" type="text/javascript"></script>
    <script src="<%=path%>/lib/datagird/dist/extensions/toolbar/bootstrap-table-toolbar.min.js" type="text/javascript"></script>
    <script src="<%=path%>/lib/datagird/dist/locale/bootstrap-table-zh-CN.min.js" type="text/javascript"></script>
    <script src="<%=path%>/lib/datagird-export.js" type="text/javascript"></script>
    <link href="<%=path%>/lib/jquery.contextMenu.min.css" rel="stylesheet" type="text/css"/>
    <script src="<%=path%>/lib/jquery.contextMenu.min.js" type="text/javascript"></script>
    
    <!--css-->
    <style>
        .bootstrap-table-toolbar select{
            border: 0;
            border-radius: 2px;
            color: inherit;
            cursor: pointer;
            display: inline-block;
            margin-bottom: 0;
            max-width: 100%;
            padding: 8px;
            position: relative;
            right: 12px;

        }
        
        .bootstrap-table-toolbar select> option{
            border: 0;
            color: inherit;
            cursor: pointer;
            display: block;
            margin-bottom: 0;
            max-width: 100%;
            padding: 8px;

        }
    </style>
    
    <!--tool bar-->
    <div id="toolbar" class="bootstrap-table-toolbar">
        
        <select class="form-control" style="">
            <option value="all">全部导出</option>
            <option value="selected">选择导出</option>
        </select>
        
    </div>
    
    <!--table-->
    <table id='table' data-toggle="table"
           data-url="<%=path%>/admin?target=getallinfo"
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
           data-id-field="id"
           data-page-list="[10, 25, 50, 100, ALL]"
           data-page-size="25"	
           data-click-to-select="true"
           >
        <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="id" data-sortable="ture">User ID</th>
                <th data-field="utype">User Type</th>
                <th data-field="name">User Name</th>
                <th data-field="gender" >User Gender</th>
                <th data-field="brithday" >User Birthday</th>
                <th data-field="email" >User Email</th>
                <th data-field="uwords" >User Introduction</th>
                <th data-field="password">User Password</th>
            </tr>
        </thead>
    </table>
           
    <!--form-->
    <div class="modal fade " id="modal-registerUser"  role="dialog">
        <div class="modal-dialog modal-xs" >
            <div class="modal-content login-form card">

                <form class="form-horizontal tab-content width-control stage-side" method="post" name="form_login" >
                    <!--title-->
                    <div class="" id="account-title">
                        <h1 class="page-header">
                            注册用户
                        </h1>
                    </div>
                    
                    <!--info-->
                    <div  class="tab-pane fade in active" id="login-start">
                        <div>

                            <!-- ID号 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="id">ID号：</label>
                                        <input type="text" id="id" name="id" class="form-control" placeholder="请输入您的ID号 " maxlength="16">
                                    </div>
                                </div>
                                <span id="idMsg" class="text-error"></span>   
                            </div> 

                            <!--<br>-->
                            <!-- 姓名 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="name">姓名：</label>
                                        <input type="text" id="name" name="name" class="form-control" placeholder="请输入您的姓名" maxlength="16" />
                                    </div>
                                </div>
                                <span id="nameMsg" class="text-error"></span>
                            </div>
                            <!--<br>-->

                            <!--性别-->
                            <div class="form-group form-group-label">

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="boy">
                                        <input class="access-hide form-control" id="boy" name="sex" type="radio">男生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="girl">
                                        <input class="access-hide form-control" id="girl" name="sex" type="radio">女生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>
                            </div>
                            <!--<br>-->

                            <!-- 角色 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="role">角色：</label>
                                        <select class="form-control" required="required" name="role" id="role">
                                            <option value="admin" type='hide'>管理员</option>
                                            <option value="user" type='hide'>普通用户</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- 邮箱 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="email">邮箱：</label>
                                        <input type="text" id="email" name="email" class="form-control" >
                                    </div>
                                </div>
                                <span id="emailMsg" class="text-error"></span>
                            </div>
                            <!--<br>-->

                            <!-- 密码 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="password">密码：</label>
                                        <input type="password" name="password" id="password" class="form-control" >
                                    </div>
                                </div>
                                <span id="passwFristMsg" class="text-error"></span>
                            </div>

                            <!--下一步按钮-->
                            <div class="box-small"></div>
                            <div class="form-group">
                                <a id="fornext" onclick="registerUser();" data-toggle="tab" href="#"><div class="btn btn-brand btn-block">注册</div></a>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
        </div>
        
    </div>
           
    <!--js-->       
    <script>
        var $table = $('#table');
        $(function () {
            $('#toolbar').find('select').change(function () {
                $table.bootstrapTable('destroy').bootstrapTable({
                    exportDataType: $(this).val()
                });
            });
        });
    </script>
    <script>
        $(function() {
            $.contextMenu({
                selector: '#table', 
                callback: function(key, options) {
                    var m = "clicked: " + key;
                    //window.console && console.log(m) || alert(m); 
                    switch (key){
                        case "add":{
                            $("#modal-registerUser").modal();
                        }
                        case "delete":{
                                
                            deleteUsers($table.bootstrapTable('getSelections'));
                        }
                    }
                },
                items: {
                    "edit": {name: "编辑", icon: "edit"},
                    "sep1": "---------",
                    "add": {name: "增加", icon: "add"},
                    "import": {name: "批量导入", icon: "imports"},
                    "sep2": "---------",
                    "delete": {name: "删除选中", icon: "delete"}
                }
            });

            $('#table').on('click', function(e){
                
                console.log('clicked', this);
            });
       });
        function registerUser(){
            var id = $("#id").val();
            var name = $("#name").val();
            var gender = $('#boy').is(":checked") ? 'male' : 'female';;
            var role = $("#role").val();
            var email = $("#email").val();
            var password = $("#password").val();
            $.ajax({
                   url: "<%=path%>/admin?target=signup&id=" + id
                           + "&name=" + name
                           + "&gender=" + gender
                           + "&role=" + role
                           + "&email=" + email
                           + "&password=" + password,
                   type: 'post',
                   async: false,
                   success: function (data) {
                        if (data === "ok") {
                            app.msg.snackbar("注册成功");
                            $table.bootstrapTable('destroy').bootstrapTable();
                            $("#password").val("");
                        }else{
                            app.msg.alert("未知错误!请尝试刷新页面...");
                        }
                   },
                   error: function () {
                       app.msg.alert("未知错误...");
                       status = -1;
                   }
               });
        }
        function deleteUsers(users){
            var obj = users;
            console.info(obj);
            console.log(obj.length);
            for(var i=0; i<users.length; i++){
                $.ajax({
                    url: "<%=path%>/admin?target=delete&uid=" + users[i].id,
                    type: 'post',
                    async: false,
                    success: function (data) {
                         if (data === "ok") {
                             app.msg.snackbar(users[i].id + "删除成功");
                             $table.bootstrapTable('destroy').bootstrapTable();
                             $("#password").val("");
                         }else{
                             app.msg.alert("未知错误!请尝试刷新页面...");
                         }
                    },
                    error: function () {
                        app.msg.alert("未知错误...");
                        status = -1;
                    }
                });
            }
        }
    </script>
