<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>

<!--lib-->    
<link href="<%=path%>/lib/jquery.contextMenu.min.css" rel="stylesheet"/>
<link href="<%=path%>/lib/datagird/dist/bootstrap-table.min.css" rel="stylesheet"/>
<script src="<%=path%>/lib/datagird/dist/bootstrap-table.min.js"></script>
<script src="<%=path%>/lib/datagird/dist/extensions/export/bootstrap-table-export.min.js"></script>
<script src="<%=path%>/lib/datagird/dist/extensions/toolbar/bootstrap-table-toolbar.min.js"></script>
<script src="<%=path%>/lib/datagird/dist/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="<%=path%>/lib/datagird-export.js"></script>
<script src="<%=path%>/lib/jquery.contextMenu.min.js"></script>

<style>
    #calc-creator-content > #calc-simple-hbuilder{
        min-height: 840px;
        margin: -4em 4em -8em;
        padding: 4em 4em 8em;
        position: relative;
        box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.56);
        background-color: rgb(255, 255, 255);
    }
    #calc-creator-content .list-group-item {
        margin: 12px 12px;
        padding: 16px;
        list-style: none;
        box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.25);
        min-height: 52px;
    }
    #calc-creator-content .list-group-item .btn-flat{
        margin: -9px;
    }
    
    #cacl-maker{
        display: block;
        position: fixed;
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        overflow: auto;
        background-color: whitesmoke;
        z-index: 100;
    }
    #cacl-maker form{
        width: 500px;
        margin: 0em auto 15em;
        padding: 1em 2em 3em;
        position: relative;
        top: 80px;
        box-shadow: 0 -1px 0 #e5e5e5,0 0 2px rgba(0,0,0,.12),0 2px 4px rgba(0,0,0,.24);
        background-color: #FFF;
        
    }
    .cacl-form-title{
        margin: 1em 0 1.5em;
        font-size: 35px;
    }
    .cacl-form-close {
        position: absolute;
        right: -15px;
        top: -25px;
    }
    .no-scroll{
        overflow: hidden !important;
        height: 100vh;
    }
    
    #cacl-of-viewer.wrap{
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background-color: #FFF;
        z-index: 30;
        border-color: #f50909;
        display: flex;
    }
    #cacl-of-viewer .viewer, #cacl-of-viewer iframe {
        width: 80vw !important;
        height: 80vh;
        margin: auto !important;
        box-shadow: 1px 1px 3px #454545;
        border: none;
    }
    #cacl-of-viewer .btn-close {
        position: absolute;
        right: -13px;
        top: -30px;
    }
    #cacl-of-viewer .viewer{
        position: relative;
    }
</style>

<div id="app-managecalc" class="container tab-content tab-pane fade in active sample-height" style="margin-bottom: 35em;"> 
    <!--表格控制台-->
    <div id="panel-caclIndex" class="container app-content card tab-pane fade in active">

        <nav class="tab-nav tab-nav-brand margin-top-no" id="tid-nav">
            <ul class="nav nav-brand">
                <li class="active">
                    <a data-toggle="tab" href="#cacl-manager"> 表格管理 </a>
                </li>
                <li>
                    <a data-toggle="tab" href="#form-manager" ondblclick="updataResource()"> 表单填写 </a>
                </li>
                <li>
                    <a data-toggle="tab" href="#calc-builder" > 新建 </a>
                </li>
                <li>
                    <!--data-toggle="tab" href="#tid-settings"--> 
                    <a onclick="app.msg.alert('开发中~~')"> 设置 </a>
                </li>
            </ul>
        </nav>
        
        <div class="tab-content" id="tid-content">
            
            <!--表格管理-->
            <div class="tab-pane fade in active" id="cacl-manager">
                <table id='cacl-of-cacl' data-toggle="table"></table>
            </div>
            
            <!--可写表单-->
            <div class="tab-pane fade " id="form-manager">
                <table id='cacl-of-form' data-toggle="table"></table>
            </div>
            
            <!--创建表格-->
            <div class="tab-pane fade" id="calc-builder" >
                
                <!--引导-->
                <nav class="col-md-4 divider-right" id="cacl-hbuilder-nav">

                    <!--类型选择 指引-->
                    <div class="tile-wrap" id="js--next-build">
                        <div class="tile">
                            <div class="tile-inner">
                                <span class=" label label-brand mg-sm-right">第一步:</span>&nbsp;<div class="btn btn-flat">选择类型</div>
                            </div>
                        </div>
                        <div class="tile tile-collapse active">
                            <div data-parent="#cacl-hbuilder-nav" data-target="#cacl-createdType-1" data-toggle="tile">
                                <div class="tile-side pull-left">
                                    <div class="avatar avatar-sm">
                                        1
                                    </div>
                                </div>
                                <div class="tile-inner">
                                    <div class="text-overflow">简单表单</div>
                                </div>
                            </div>
                            <div class="tile-active-show collapse in" id="cacl-createdType-1">
                                <div class="tile-sub">
                                    <p>
                                        创建一个简单的表单(只含有简单的输入单元)用来进行信息收集.
                                    </p>
                                </div>
                                <div class="tile-footer">
                                    <div class="tile-footer-btn pull-right">
                                        <a class="btn btn-flat waves-attach waves-effect" id="cc-next-build" href="javascript:void(0)"
                                           v-on:click="toggleToDot(1)"
                                           ><span class="icon">check</span>&nbsp;选择</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tile tile-collapse">
                            <div data-parent="#cacl-hbuilder-nav" data-target="#cacl-createdType-2" data-toggle="tile">
                                <div class="tile-side pull-left">
                                    <div class="avatar avatar-sm avatar-orange">
                                        2
                                    </div>
                                </div>
                                <div class="tile-inner">
                                    <div class="text-overflow">复杂表单</div>
                                </div>
                            </div>
                            <div class="tile-active-show collapse" id="cacl-createdType-2">
                                <div class="tile-sub">
                                    <p>
                                        <!--<small></small>-->
                                        创建带有多选框,下拉菜单等的表单
                                    </p>
                                </div>
                                <div class="tile-footer">
                                    <div class="tile-footer-btn pull-right">
                                        <a class="btn btn-flat waves-attach waves-effect" href="javascript:void(0)"><span class="icon">error_outline</span>&nbsp;DEVELOPING</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tile tile-collapse">
                            <div data-parent="#cacl-hbuilder-nav" data-target="#cacl-createdType-3" data-toggle="tile">
                                <div class="tile-side pull-left">
                                    <div class="avatar avatar-sm avatar-green">
                                        3
                                    </div>
                                </div>
                                <div class="tile-inner">
                                    <div class="text-overflow">试卷</div>
                                </div>
                            </div>
                            <div class="tile-active-show collapse" id="cacl-createdType-3">
                                <div class="tile-sub">
                                    <p>
                                        创建并发布试卷!
                                    </p>
                                </div>
                                <div class="tile-footer">
                                    <div class="tile-footer-btn pull-right">
                                        <a class="btn btn-flat waves-attach waves-effect" href="javascript:void(0)"><span class="icon">error_outline</span>&nbsp;DEVELOPING</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tile">
                            <div class="tile-inner">
                                <span class=" label label-brand mg-sm-right">下一步:</span>&nbsp;<div class="btn btn-flat">构建</div>
                            </div>
                        </div>
                    </div>
                    
                    <!--表格构建 指引-->
                    <div class="tile-wrap" id="js--next-create" hidden="">
                        <div class="tile">
                            <div class="tile-inner">
                                <span class=" label label-brand mg-sm-right">上一步:</span>&nbsp;返回 <div class="btn btn-flat" id="cc-last-select">选择类型</div>
                            </div>
                        </div>
                        <hr>
                        <div class="tile">
                            <div class="tile-inner">
                                构建
                            </div>
                        </div>
                        <div class="tile">
                            <div class="tile-inner">
                                <span class=" label label-brand mg-sm-right">1:</span>&nbsp;构建表结构
                                <button class="btn btn-flat pull-right" v-on:click="previewCacl()">预览<span class="icon">keyboard_arrow_right</span></button>
                            </div>
                        </div>

                        <div class="tile">
                            <div class="tile-inner">
                                <span class=" label label-brand mg-sm-right">2:</span>&nbsp;指定用户
                                <button class="btn btn-flat pull-right" v-show='proc.dots[1].activated' v-on:click="toggleToDot(2)">指定<span class="icon">keyboard_arrow_right</span></button>
                                <button class="btn btn-flat pull-right" v-show='proc.dots[2].activated' v-on:click="toggleToDot(1)">继续编辑<span class="icon">keyboard_arrow_right</span></button>
                            </div>
                        </div>

                        <hr>
                        <div class="tile">
                            <div class="tile-inner">
                                <div class="btn btn-aqua btn-block" 
                                     v-bind:class="{disabled: !isReadyPost}"
                                     v-on:click="postCacl()">发布</div>
                            </div>
                        </div>
                        
                    </div>
                    
                </nav>
                
                <!--展示/操作-->
                <div id="calc-creator-content" class="col-md-8">
                    <div id="calc-simple-hbuilder" hidden="">
                        
                        <!--构建器-->
                        <input v-if="proc.dots[1].activated" v-on:keyup.entry="updateCaclName(col)" type="text" v-model="cacl.name" class="form-control input-lg" placeholder="请输入表格名">
                        
                        <ul v-if="proc.dots[1].activated" class="list-group">
                            <!-- contenteditable="true" -->
                            <li class="list-group-item" 
                                v-for="(col, index) in cols">
                                {{col.title}}
                                <button class="btn btn-flat pull-right" v-on:click="deleteCol(index)">删除</button>
                            </li>
                        </ul>
                        <form v-if="proc.dots[1].activated" v-on:submit.prevent="addCol(col)">
                            <div class="form-group form-group-brand col-md-10">
                                <input type="text" v-model="col.title" class="form-control" placeholder="添加新列">
                            </div>
                            <div class="form-group col-md-2">
                                <button class="btn btn-brand pull-right" type="submit">添加</button>
                            </div>
                        </form>
                        
                        <!--添加好友-->
                        <div v-if="proc.dots[2].activated" class="pos-cc-box">
                            <app-c-contact>
                                <app-c-grp-wrap 
                                    v-for="(group, key) in contacts" 
                                    v-bind:id="'gid-'+ group.id"
                                    >
                                    
                                    <app-c-grp
                                        v-on:click='toggleSeletedStatus("group", group)' 
                                        v-bind:key="group.id"
                                        v-bind:class="{selected: group.selected}"
                                        >
                                        
                                        {{group.id}}
                                    </app-c-grp>
                                    <app-c-pal
                                        v-for="(user, _key) in group.data" class='btn' 
                                        v-bind:id="'lid-'+ user.lid"
                                        v-bind:key="user.lid"
                                        v-bind:class="{selected: user.selected}"
                                        v-on:click='toggleSeletedStatus("pal", group.data[_key], group );' 
                                        >
                                        
                                        {{user.lname}} - {{user.lid}} - {{user.selected}}
                                    </app-c-pal>
                                </app-c-grp-wrap>
                            </app-c-contact>
                        </div>
                        
                    </div>
                </div>
                
            </div>
            
        </div>
       
        
    </div>

    <!--表格填写-->
    <div id="cacl-maker" class="card" hidden v-show="activated">
        
        <form>
            
            <div class="fbtn cacl-form-close" V-on:click="closeCaclMaker()">
                <span class="icon icon-lg">close</span>
            </div>
            
            <div class="cacl-form-title">{{name}}</div>
            <div class="form-group form-group-label row"
                 v-for="(col, index) in structure"
                 >
                <div class="col-md-12">
                    <label class="floating-label" for="id">{{col.title}}</label>
                    <input type="text" class="form-control"
                           v-model="col.data"
                           v-on:blur="checkDataValid(index)" >
                </div>
            </div>
            <div class="form-group form-group-label row">
                <div class="col-md-12">
                    <a class="btn btn-aqua btn-block" style="margin-top: 4em;"
                       v-bind:class="{disabled: !isReadySubmit}"
                       v-on:click="submitForm()"
                       >提交</a>
                </div>
            </div>
        </form>
        
    </div>

    <!--表格查看-->
    <div id="cacl-of-viewer" class="wrap" v-show="isActivated">
        <div class="viewer">
            <div class="fbtn btn-close" v-on:click="close()"><span class="icon icon-lg">close</span></div>
            <iframe v-bind:src="src" ></iframe>
        </div>
    </div>

    <script>
        
        $(document).ready(function(){
          $('#cc-next-build').click(function(e){
            e.preventDefault();
            $('#js--next-build').slideUp(300).fadeOut();
            $('#js--next-create').fadeIn();
            $('#calc-simple-hbuilder').fadeToggle();
          });
          $('#cc-last-select').click(function(e){
            e.preventDefault();
            $('#js--next-create').fadeOut();
            $('#js--next-build').slideToggle(300);
            $('#calc-simple-hbuilder').fadeToggle();
          });
        });
        var caclFactory = new Vue({
            el: '#calc-builder',
            data: {
                /**
                 * [0]第一块儿 选择类型 
                 * [1]第二块儿 构造 
                 * [2]第三块儿 选择用户 
                 * [3]最后 发布
                 * @returns {void}
                 */
                proc: {
                    dots: [
                        {
                            key: 'select-cacl-type',
                            activated: true
                        },
                        {
                            key: 'create-cacl-structure',
                            activated: false
                        },
                        {
                            key: 'select-cacl-users',
                            activated: false
                        },
                        {
                            key: 'post-cacl',
                            activated: false
                        }
                    ],
                    activeDot: 0
                },
                cols: [],
                col: {
                    title: ''
                },
                contacts: [],
                calledUsers: [],
                cacl: {
                    name: '',
                    structure: [],
                    users: [],
                    postime: '',
                    endtime: ''
                },
                isReadyPost: false
            },
            methods: {
                toggleToDot: function (index) {
                    this.hideDot(this.proc.dots[this.proc.activeDot]);
                    this.showDot(this.proc.dots[index]);
                    this.proc.activeDot = index;
                },
                showDot: function (v) {
                    v.activated = true;
                },
                hideDot: function (v) {
                    v.activated = false;
                },
                addCol: function (col) {
                    var isExist = false;

                    if (col.title !== '' && col.title !== null) {
                        for (var i = 0; i < this.cols.length; i++) {
                            isExist = col.title === this.cols[i].title ? true : false;
                        }
                        if (!isExist) {
                            this.cols.push(col);
                        } else {
                            app.msg.alert("列名不能重复");
                        }
                    } else {
                        app.msg.alert("列名不能为空");
                    }
                    //app.msg.alert(JSON.stringify(this.cols));
                    //console.info(this.cols);
                    this.col = {title: ''};
                    this.updateIsReadyPostStatus();

                },
                updateCol: function (e, index) {
                    //console.info(e);
                    //this.cols[index].title = e.value;
                },
                deleteCol: function (index) {
                    this.cols.splice(index, 1);
                    this.updateIsReadyPostStatus();
                },
                callUser: function () {
                    this.proc.dots[1].activated = false;
                    this.proc.dots[2].activated = true;
                },
                toggleSeletedStatus: function (type, data, parent) {
                    switch (type) {
                        case 'group' :
                        {
                            this.toggleUserByGroup(data.selected, data);
                            break;
                        }
                        case 'pal' :
                        {
                            this.toggleUser(data.selected, data, parent);
                            break;
                        }
                        default:{
                            for(var i=0; i<this.contacts.length; i++){
                                this.toggleUserByGroup(true, this.contacts[i]);
                            }    
                        }
                    }
                    this.updateIsReadyPostStatus();
                },
                toggleUser: function (selected, user, group) {

                    var index = this.calledUsers.indexOf(user.lid);
                    console.log(index);
                    if (selected && index > -1) {
                        this.calledUsers.splice(index, 1);
                        user.selected = false;

                        if (group.selected) {
                            group.selected = false;
                        }

                        app.msg.snackbar('删除' + user.lid);

                    } else {
                        this.calledUsers.push(user.lid);
                        app.msg.snackbar('添加' + user.lid);
                        user.selected = true;

                    }

                    console.log(this.calledUsers);

                },
                toggleUserByGroup: function (selected, data) {

                    console.info(data);
                    var users = data.data;
                    console.info(users);

                    if (!selected) {

                        for (var i = 0; i < users.length; i++) {
                            if (!users[i].selected) {
                                this.toggleUser(false, users[i], data);
                            }
                        }
                        data.selected = true;

                    } else {
                        for (var i = 0; i < users.length; i++) {
                            if (users[i].selected) {
                                this.toggleUser(true, users[i], data);
                            }
                        }
                        data.selected = false;
                    }

                    console.info(this.calledUsers);
                },
                previewCacl: function () {

                },
                updateIsReadyPostStatus: function () {
                    this.isReadyPost = this.calledUsers.length > 0 && this.cols.length > 0;
                },
                postCacl: function () {
                    this.cacl.users = this.calledUsers;
                    this.cacl.structure = JSON.stringify(this.cols);
                    if(this.isReadyPost)
                        if(app.user.calcs.post(JSON.stringify(this.cacl))){
                            for(var i=0; i<this.calledUsers.length; i++){

                                var message = {
                                    from: app.user.info.id,
                                    to: this.calledUsers[i],
                                    msg: app.user.info.id + ' 邀请你帮他填写一个问卷~~ 点击可写问卷里的刷新按钮即可获得 ',
                                    type: 703
                                };

                                app.msg.user.send(message);
                            }
                            this.clearCaclBuilder();
                        }


                },
                clearCaclBuilder:function(){

                    //app.msg.alert(JSON.stringify(this.cacl));

                    this.toggleToDot(1);
                    this.toggleSeletedStatus();

                    this.cols = [];
                    this.calledUsers = [];

                    this.cacl = {
                        name: '',
                        structure: [],
                        users: [],
                        postime: '',
                        endtime: ''
                    };
                    this.isReadyPost = false;
                }

            },
            created: function () {
                app.user.contacts.set();
                this.contacts = app.user.contacts.data;
                //alert(JSON.stringify(this.users));
            }
        });
        
    </script>
    
    <script>    
            
        var CaclMaker = new Vue({
            el:'#cacl-maker',
            data:{
                tid:0,
                name:'',
                structure :[],
                activated :false,
                isReadySubmit:false
            },
            methods:{
                setCaclMaker :function(id, n, s){
                    this.tid = id;
                    this.name = n;
                    this.structure = [];
                    for(var i=0; i<s.length; i++){
                        var tmp = {
                            title :s[i].title,
                            data :'',
                            isValid:false
                        };
                        this.structure.push(tmp);
                    }
                    
                    CaclMaker.activated = true;
                    $('body').toggleClass('no-scroll');
                    
                    console.info(this.structure);
                },
                closeCaclMaker:function(){
                    
                    CaclMaker.activated = false;
                    $('body').toggleClass('no-scroll');
                },
                checkDataValid:function(index){
                    
                    if(!(app.regx.trim(this.structure[index].data) === '')){
                        this.structure[index].isValid = true;
                    } else {
                        this.structure[index].isValid = false;
                    }
                    //console.log(this.structure[index].data);
                    this.updateReadyStatus();
                },
                updateReadyStatus :function(){
                    var isReady = true;
                    
                    for(var i=0; i<this.structure.length; i++){
                        if(!this.structure[i].isValid){
                            isReady = false;
                            this.isReadySubmit = false;
                            
                            console.log('pos ' + i + ' is ' + this.structure[i].isValid);
                            break;
                        }
                    }
                    if(isReady){
                        console.log('is ready ? ' + isReady)
                        this.isReadySubmit = true;
                    }
                },
                submitForm :function(){
                    if(this.isReadySubmit){
                        var data = '{';
                        for(var i=0; i<this.structure.length; i++){
                            if(i===this.structure.length-1){
                                data += '"' +this.structure[i].title + '":"' +this.structure[i].data + '"';
                            } else {
                                data += '"' +this.structure[i].title + '":"' +this.structure[i].data + '",';
                            }
                        };
                        data += '}';
                        console.log(data);
                        console.log(this.tid,JSON.stringify(JSON.parse(data)));
                        app.user.calcs.submit(this.tid, JSON.stringify(JSON.parse(data)));
                    }else{
                        app.msg.snackbar("请检查无误后提交!");
                    }
                }
            },
            watch:{
                structure :function(val, _val){
                    console.log('new: %s, old: %s', val, _val);
                }
            }
        });
        var CaclViewer = new Vue({
            el:'#cacl-of-viewer',
            data:{
                tid:0,
                structure:[],
                src:'',
                isActivated:false
            },
            methods:{
                open: function(){
                    this.isActivated=true;
                    $('body').toggleClass('no-scroll');
                },
                close:function(){
                    this.src = '';
                    this.isActivated=false;
                    $('body').toggleClass('no-scroll');
                },
                setSrc:function(tid, title, structure){
                    if(tid !== this.tid)
                        this.src = "<%=path%>/u/cacl?tid=" + tid + "&title=" +  title + "&structure=" + JSON.stringify(structure);
                    this.open();
                }
            }
        });
        
        window.caclEditEvent = {
            'click .edit': function (e, value, row, index) {
                alert('You click row: ' + JSON.stringify(row));
            }
            
        };
        
        window.caclViewEvent = {
        
            'click .viewdg': function (e, value, row, index) {
                console.log(JSON.parse(row.structure));
                CaclViewer.setSrc(row.tid, row.name,  JSON.parse(row.structure));
            }
        };
        
        window.formFillOutEvent = {
        
            'click .fillout': function (e, value, row, index) {
                console.log(JSON.parse(row.structure));
                CaclMaker.setCaclMaker(row.tid, row.name, JSON.parse(row.structure));
            }
        };
        
        window.caclUndefinedEvent = {
        
            'click .delete': function (e, value, row, index) {
                console.log('fn is undefined ...');
            },
            'click .viewdf': function (e, value, row, index) {
                console.log('fn is undefined ...');
            }
        };
        
        !(function (){
            
            var $dgCacls = $('#cacl-of-cacl');
            
            var $dgForms = $('#cacl-of-form');
            
            $dgCacls.bootstrapTable({
                columns: [{
                        field: 'status',
                        checkbox: "true",
                        align: 'center'
                    }, {
                        field: 'tid',
                        title: '表格ID',
                        sortable: true,
                        editable: true,
                        align: 'center'
                    }, {
                        field: 'name',
                        title: '表格名',
                        sortable: true,
                        align: 'center'
                    }, {
                        field: 'postime',
                        title: '发布时间',
                        align: 'center'
                    }, {
                        field: 'cacledit',
                        title: '编辑',
                        align: 'center',
                        events: caclEditEvent,
                        formatter: operateEditFormatter
                    }, {
                        field: 'caclview',
                        title: '查看',
                        align: 'center',
                        events: caclViewEvent,
                        formatter: operateDgViewFormatter
                    }, {
                        field: 'cacldelete',
                        title: '删除',
                        align: 'center',
                        events: caclUndefinedEvent,
                        formatter: operateDeleteFormatter
                }],
            
                url: app.path + "/u?target=getcaclist",
                search: "true",
                showRefresh: "true",
                searchOnEnterKey: "ture",
                checkbox: "true",
                minimumCountColumns: "2",
                pagination: "true",
                idField: "tid",
                pageList: "[10, 25, 50, 100, ALL]",
                pageSize: "10"
                
                //showToggle:"true",
                //showExport:"true",
                //showPaginationSwitch:"true",
            });
       
            $dgForms.bootstrapTable({
                columns: [{
                        field: 'status',
                        checkbox: "true",
                        align: 'center'
                    }, {
                        field: 'tid',
                        title: '表格ID',
                        sortable: true,
                        editable: true,
                        align: 'center'
                    }, {
                        field: 'name',
                        title: '表格名',
                        sortable: true,
                        align: 'center'
                    }, {
                        field: 'author',
                        title: '作者',
                        align: 'center'
                    }, {
                        field: 'postime',
                        title: '发布时间',
                        align: 'center'
                    }, {
                        field: 'fromfillout',
                        title: '填写',
                        align: 'center',
                        events: formFillOutEvent,
                        formatter: operateFillOutFormatter
                    }, {
                        field: 'formview',
                        title: '查看',
                        align: 'center',
                        events: caclUndefinedEvent,
                        formatter: operateFormViewFormatter
                    }, {
                        field: 'formdelete',
                        title: '删除',
                        align: 'center',
                        events: caclUndefinedEvent,
                        formatter: operateDeleteFormatter
                }],
            
                url: app.path + "/u?target=getformlist",
                search: "true",
                showRefresh: "true",
                searchOnEnterKey: "ture",
                checkbox: "true",
                minimumCountColumns: "2",
                pagination: "true",
                idField: "tid",
                pageList: "[10, 25, 50, 100, ALL]",
                pageSize: "10"
                
                //showToggle:"true",
                //showExport:"true",
                //showPaginationSwitch:"true",
            });
            
            setTimeout(function () {
                $dgCacls.bootstrapTable('resetView');
                $dgForms.bootstrapTable('resetView');
            }, 200);
            
            $dgCacls.on('check.bs.table uncheck.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
                    // save your data, here just save the current page
                    selections = getIdSelections($dgCacls);
                    // push or splice the selections if you want to save all data selections
                });
                
            $dgCacls.on('expand-row.bs.table', function (e, index, row, $detail) {
                if (index % 2 == 1) {
                    $detail.html('Loading from ajax request...');
                    $.get('LICENSE', function (res) {
                        $detail.html(res.replace(/\n/g, '<br>'));
                    });
                }
            });
            
            $dgCacls.on('all.bs.table', function (e, name, args) {
                console.log(name, args);
            });
            
            $dgForms.on('check.bs.table uncheck.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
                    $remove.prop('disabled', !$dgForms.bootstrapTable('getSelections').length);

                    // save your data, here just save the current page
                    selections = getIdSelections($dgForms);
                    // push or splice the selections if you want to save all data selections
                });
                
            $dgForms.on('expand-row.bs.table', function (e, index, row, $detail) {
                if (index % 2 == 1) {
                    $detail.html('Loading from ajax request...');
                    $.get('LICENSE', function (res) {
                        $detail.html(res.replace(/\n/g, '<br>'));
                    });
                }
            });
            
            $dgForms.on('all.bs.table', function (e, name, args) {
                console.log(name, args);
            });
        })();
    
        function getIdSelections(dg) {
            return $.map(dg.bootstrapTable('getSelections'), function (row) {
                return row.id;
            });
        }

        function responseHandler(res) {
            $.each(res.rows, function (i, row) {
                row.state = $.inArray(row.id, selections) !== -1;
            });
            return res;
        }

        function detailFormatter(index, row) {
            var html = [];
            $.each(row, function (key, value) {
                html.push('<p><b>' + key + ':</b> ' + value + '</p>');
            });
            return html.join('');
        }

        function operateEditFormatter(value, row, index) {
            return [
                '<a class="edit" href="javascript:void(0)" title="编辑">',
                '<span class="icon icon-lg">edit</span>',
                '</a>  '
            ].join('');
        }

        function operateDgViewFormatter(value, row, index) {
            return [
                '<a class="viewdg" href="javascript:void(0)" title="查看">',
                '<i class="icon icon-lg">visibility</i>',
                '</a>'
            ].join('');
        }
        
        function operateFormViewFormatter(value, row, index) {
            return [
                '<a class="viewdf" href="javascript:void(0)" title="查看">',
                '<i class="icon icon-lg">visibility</i>',
                '</a>'
            ].join('');
        }

        function operateDeleteFormatter(value, row, index) {
            return [
                '<a class="delete" href="javascript:void(0)" title="查看">',
                '<i class="icon icon-lg">delete_sweep</i>',
                '</a>'
            ].join('');
        }
        
        function operateFillOutFormatter(value, row, index) {
            return [
                '<a class="fillout" href="javascript:void(0)" title="编辑">',
                '<span class="icon icon-lg">edit</span>',
                '</a>  '
            ].join('');
        }
    
    </script>
    
</div>