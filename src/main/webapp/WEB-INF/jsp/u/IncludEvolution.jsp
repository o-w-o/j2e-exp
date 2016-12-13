<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String path = request.getContextPath();%>

<style>
    #app-evolution{
        width: 1200px;
        margin: auto;
        margin-bottom: 170px;
        padding-top: 30px;
    }
    #app-evolution > .card{
        min-height: 1000px;
    }
    /*导航*/
    #app-evolution-nav .tile>.active{
        background-color: rgba(200,200,200,.5);
        margin: 0;
    }
    #app-msg-list,
    #app-msg-outbox #msg-editor,
    #app-msg-nav,
    #app-contacts-nav{
        margin: 2em;
        padding: 1em;
        display: block !important;
        box-shadow: 0 -1px 0 #e5e5e5,0 0 2px rgba(0,0,0,.12),0 2px 4px rgba(0,0,0,.24);
        border-radius: 2px;
        background-color: #FFF;
    }

    #app-msg-list{
        margin: 1em 1em 3em;
        padding: 1em;
        box-shadow: 1px 1px 3px #cbc9c9;
        min-height: 15em;
    }
    [id^="app-msg-"] .doing,
    [id^="app-msg-"] .done{
        display: flex;
        justify-content: space-between;
        margin: .5em;
        padding: 0 2em;
        height: 50px;
        line-height: 50px;
        box-shadow: 1px 1px 3px RGBA(0, 0, 0, 0.3);
        
    }
    .msg-title{
        display: inline-block;
    }
    .msg-content.friend-request{
        float: right;
        display: inline-block;
    }
    .msg-req-action{
        cursor: pointer;
    }
    
    #app-msg-outbox #msg-editor,
    #app-msg-nav,
    #app-contacts-nav{
        margin-top: -25px !important;
    }
    #app-msg-outbox #msg-editor{
        min-height: 450px;
        padding-bottom: 150px;
    }
    #app-msg-outbox #msg-o-btn{
        display: block;
        margin: 2em;
    }
    #app-msg-outbox #msg-addusr-btn{
        position: relative;
        margin-top: -50px;
        top: -50px;
    }
    /*寻人*/
    #result-of-findfriend{
        margin: 2em;
        padding: 45px;
        min-height: 50vh;
    }
    #result-of-findfriend > .card strong{
        font-weight: 800;
    }
    .card-above{
        margin: 2em;
        padding: 1em;
        margin-top: -25px !important;
    }
    .btn-tag{
        box-shadow: none;
        background-color: transparent;
        border-radius: 1.2px;
        margin: 8.5px;
        padding: 6px 15px;
        box-shadow: 0.5px 0.5px 0.5px rgb(236, 236, 236);
    }
    .btn-tag:after{
        box-shadow: 0 3px 9px rgba(236, 236, 236,.4);
    }
    .btn-tag:focus{
        box-shadow: 0.5px 0.5px 0.5px rgba(236, 236, 236,.4);
    }
    
    /*联系人*/
    #app-contacts-nav{
        margin-top: -25px !important;
        margin: 2em;
        padding: 1em;
        display: block !important;
        box-shadow: 0 -1px 0 #e5e5e5,0 0 2px rgba(0,0,0,.12),0 2px 4px rgba(0,0,0,.24);
        border-radius: 2px;
        background-color: #FFF;
    }
    #app-contacts-list .app-c-grp {
        margin: 1em 1em 3em;
        padding: 1em;
        box-shadow: 1px 1px 3px #cbc9c9;
    }
    
    #app-contacts-list .app-c-pal {
        height: 50px;
        box-shadow: 1px 1px 3px RGBA(0, 0, 0, 0.3);
        margin: .5em;
        padding-left: 2em;
        line-height: 50px;
        padding-left: 2em;
    }
    
    /*新建信息*/
    #msg-u-list .app-c-grp{
        margin: 1em auto 3em;
    }
    #msg-u-list .app-c-pal{
        margin: .5em 1em;
        height: 50px;
        padding-left: 2em;
        line-height: 50px;
        padding-left: 2em;
        box-shadow: 0 -1px 0 #e5e5e5,0 0 2px rgba(0,0,0,.12),0 2px 4px rgba(0,0,0,.24);
        border: 1px solid #b9b9b9;
    }
    #msg-u-list .app-c-pal.active{
        background-color: gainsboro;
    }
</style>

<div id="app-evolution" class="container tab-pane fade">
    <!--导航-->
    <nav class="col-md-3">
        <ul class="nav width-control" id="app-evolution-nav">
            
            <li class="tile">
                <a class="btn btn-flat active" data-toggle="evtab" data-action="inbox" data-pane="#app-msg-inbox"
                   v-on:click="toggleToBox('received')"
                   >收件箱</a>
            </li>
            <li class="tile">
                <a class="btn btn-flat" data-toggle="evtab" data-action="sentbox" data-pane="#app-msg-inbox"
                   v-on:click="toggleToBox('sent')"
                   >已发送</a>
            </li>
            <li class="tile">
                <a class="btn btn-flat" data-toggle="evtab" data-action="outbox" data-pane="#app-msg-outbox">新建</a>
            </li>
            
            <hr>
            <li class="tile">
                <a class="btn btn-flat" data-toggle="evtab" data-action="contacts" data-pane="#app-contacts">联系人</a>
            </li>
            <li class="tile">
                <a class="btn btn-flat" data-toggle="evtab" data-action="finduser" data-pane="#app-find-user">寻人</a>
            </li>
            
            
        </ul>
    </nav>
    
    <!--消息-->
    <div class="col-md-9">
        <div class="col-md-11 col-md-offset-1 card sample-height tab-content" id="app-evolution-content">
            
            <!--消息中心-->
            <div id="app-msg-inbox" data-status="true" class="width-control tab-pane fade in active">
                <nav id="app-msg-nav" class="nav">
                    <a class="btn btn-tag" v-on:click="toggleToTag('all')">全部</a>
                    <a class="btn btn-tag" v-on:click="toggleToTag('notify')">通知</a>
                    <a class="btn btn-tag" v-on:click="toggleToTag('req')">请求</a>
                    <a class="btn btn-tag" v-on:click="toggleToTag('letter')">信件</a>
                    <ul class="nav nav-list margin-no pull-right">
                        <li class="dropdown">
                            <a class="dropdown-toggle text-black waves-attach" data-toggle="dropdown"><span class="icon">more_vert</span></a>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li>
                                    <a class="waves-attach" href="javascript:void(0)" v-on:click="set()"><span class="icon margin-right-sm">loop</span>&nbsp;刷新</a>
                                </li>
                                <li>
                                    <a class="waves-attach" href="javascript:void(0)"><span class="icon margin-right-sm">replay</span>&nbsp;Sample</a>
                                </li>
                                <li>
                                    <a class="waves-attach" href="javascript:void(0)"><span class="icon margin-right-sm">shuffle</span>&nbsp;Sample Long Long Long Text!</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>
                <div id="app-msg-list">
                    <app-box-received v-show="recorder.box.received.activated">
                        <div
                            v-for="msg in box.received.data"  
                            v-bind:data-tag="msg.type"
                            >

                            <div v-if="msg.type === 'req-mkf'" 
                                 v-bind:class=' msg.status ? "done" : "doing"'
                                 >

                                <div class='msg-title'>来自 {{ msg.from }} 的好友请求</div>
                                <a class="msg-req-action" v-on:click="accept(msg.from)">同意</a>
                            </div>

                            <div v-else-if=" msg.type.indexOf('notify') >  0 ">
                                {{msg.msg}}
                            </div>
                            <div v-else>
                                为什么默认出来了~~
                            </div>
                        </div>
                    </app-box-received >
                    
                    <app-box-sent v-show="recorder.box.sent.activated">
                        <div
                            v-for="msg in box.sent.data"  
                            v-bind:data-tag="msg.type"
                            >

                            <div v-if="msg.type === 'req-mkf'" 
                                 v-bind:class=' msg.status ? "done" : "doing"'
                                 >

                                <div class='msg-title'>发送给 {{ msg.to }} 的好友请求</div>
                                <div v-if="msg.from === app.user.info.id"><a class="msg-req-action" v-on:click="accept(msg.from)">加自己为好友</a></div>
                            </div>

                            <div v-else-if=" msg.type.indexOf('notify') >  0 ">
                                {{msg.msg}}
                            </div>
                            <div v-else>
                                为什么默认出来了~~
                            </div>
                        </div>
                    </app-box-sent>
                    
                </div>
            </div>
            
            <!--发送信息-->
            <div id="app-msg-outbox" class="width-control tab-pane fade">
                <div id="msg-editor" class="card-above editor">
                    
                </div>

                <div class="fbtn btn-aqua" id="msg-addusr-btn" onclick="callUserEvent();">
                    <span class="icon icon-lg">person_add</span>
                </div>
                <div class="btn btn-aqua" id="msg-o-btn">
                    发送
                </div>
                <div class="fbtn" id="msg-x-btn" onclick="">
                    ×
                    <!--<span class="icon icon-lg">cancel</span>-->
                </div>
            </div>

            <!--我的好友-->
            <div id="app-contacts" class="width-control tab-pane">
                <div id="app-contacts-nav" class="nav nav-pills">
                    
                    <ul class="nav nav-list margin-no pull-right">
                        <li class="dropdown">
                            <a class="dropdown-toggle text-black waves-attach" data-toggle="dropdown"><span class="icon">more_vert</span></a>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li>
                                    <a class="waves-attach" href="javascript:void(0)"><span class="icon margin-right-sm">loop</span>&nbsp;Sample1</a>
                                </li>
                                <li>
                                    <a class="waves-attach" href="javascript:void(0)"><span class="icon margin-right-sm">replay</span>&nbsp;Sample2</a>
                                </li>
                                <li>
                                    <a class="waves-attach" href="javascript:void(0)"><span class="icon margin-right-sm">shuffle</span>&nbsp;Sample Long Long Long Text!</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div id="app-contacts-list"></div>
            </div>
            
            <!--查找用户-->
            <div id="app-find-user" class="width-control tab-pane fade">
                <div class="card card-above">
                    <div class="form-horizontal tab-content width-control stage-side ">
                        <!-- 学号 -->
                        <div class="form-group form-group-brand form-group-label">
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="floating-label" for="fid">ID号：</label>
                                    <input type="text" id="fid" name="fid" class="form-control" placeholder="请输入您的ID号 " maxlength="16" oninput="findUser()"  onkeydown="findUserKeyListener(event)">
                                </div>
                            </div> 
                        </div>
                        <div class="form-group">
                            <div class="btn btn-aqua width-control" onclick="findUser()">查找</div>
                        </div>
                    </div>
                </div>

                <!--按钮-->
                <div class="form-group">
                    <div id="chatlog" hidden="hidden"></div>
                    <div class="box-small row" id="result-of-findfriend"></div>
                </div>
            </div>
            
        </div>
    </div>
    
</div>

<script>
    var Evolution = new Vue({
        el:'#app-evolution',
        data:{
            box :{
                received :{
                    isActivated : true,
                    data:[]
                },
                sent :{
                    isActivated : false,
                    data:[]
                },
                maker :{
                    isActivated : false,
                    data:[]
                }
            },
            
            tag :{
                
            },
            
            message :{
                from: app.user.info.id,
                to: '',
                msg: '',
                type: 000
            },
            
            recorder :{
                box:{
                    received :{
                        activated :true
                    },
                    sent:{
                        activated :false
                    },
                    
                    activated:'recevied'
                },
                tag:{
                    activated :'all' //notify letter req
                }
            }
            
        },
        methods:{
            set : function(){
                app.user.messages.set();
                var data = app.user.messages.data;
                this.box.received.data = [];
                this.box.sent.data = [];
                var from = this.box.received.data;
                var to = this.box.sent.data;
                for (var i = 0; i < data.length; i++) {
                    if (data[i].from === app.user.info.id) {
                        to.push(data[i]);
                    } else {
                        from.push(data[i]);
                    }
                    console.log(data[i].from +  "\n ------------- \n" + app.user.info.id);
                }  
            },
            accept :function(from){
              app.user.contacts.accept(from);
            },
            
            send :function(){
                
            },
            
            receive :function(){
                
            },
            
            dispatch2sent :function(){
                
            },
            
            dispatch2received :function(){
                
            },
            
            refresh :function(){
                
            },
            toggleToBox :function(box){
                if(this.recorder.box.activated!==box){
                    this.recorder.box.activated = box;
                    app.msg.snackbar(box + " ? " + this.recorder.box.activated);
                    if(box==='received'){
                        this.recorder.box.received.activated = true;
                        this.recorder.box.sent.activated = false;
                    } else {
                        this.recorder.box.received.activated = false;
                        this.recorder.box.sent.activated = true;
                    }
                }
            },
            toggleToTag :function(tag){
                if(this.recorder.tag.activated===tag){
                    return ;
                } else {
                    this.recorder.tag.activated = tag;
                    $('[data-tag]').hide();
                }
                switch (tag) {
                    case 'notify':{
                        $('[data-tag^="notify"]').fadeIn();
                        break;
                    }
                    case 'letter':{
                        $('[data-tag^="letter"]').fadeIn();
                        break;
                    }
                    case 'req':{
                        $('[data-tag^="req"]').fadeIn();
                        break;
                    }
                    default:{
                        $('[data-tag]').fadeIn();    
                    }
                }
            }
                
        },
        
        //初始化 
        //数据:信息,联系人
        created: function(){
            this.set();
        }
    });
</script>

<script>
    
    var activeEvPane = "inbox";
    
    !(function(){
        $('[data-toggle="evtab"]').click(function(e){
            
            var evPane = $(this).attr("data-action");
            //app.msg.snackbar($(this).attr("data-action"));
             
            if(activeEvPane !== evPane) {
                activeEvPane = evPane;
                //app.msg.snackbar($(this).attr("data-pane"));
                
                $('#app-evolution-nav .active').toggleClass('active');
                $(this).toggleClass('active');
                
                $('#app-evolution-content .active').toggleClass('in active');
                $($(this).attr("data-pane")).toggleClass("in active");
                
                switch (evPane){

                    case "finduser":{
                        findUserEvent();   
                        break;
                    }
                }
            }
            
            switch (evPane){
                case "finduser":{
                    findUserEvent();   
                    break;
                }
            }

        });
    })();
    
    function callUserEvent(){
        
        $('#modal-callUser').modal();
        document.getElementById('msg-u-list').innerHTML = '';
        app.vc.user.contacts.init('msg-u-list');
        $('#msg-u-list .app-c-pal').click(function(){
            $(this).toggleClass('active');
            updateCalledUsersNum();
        });
        
        function updateCalledUsersNum (){
           document.getElementById('called-user-num').innerHTML = $('#msg-u-list .active').length;
        }
        
        
    }  
    
    function findUserEvent(){
        
        
    }
    
    function findUserKeyListener(e) {
        var keynum;

        if (window.event){ keynum = e.keyCode; } else if (e.which){  keynum = e.which; }
        if (keynum === 13) {
            findUser();
        }
    };    
    
    function findUser(){
        var len = $("#fid").val().length;
        
        if(len>7 && len<12){
            app.user.search.stranger($("#fid").val(), "result-of-findfriend" );
    
        }
    }
    
    app.editor.configure("msg-editor");
    
</script>
    