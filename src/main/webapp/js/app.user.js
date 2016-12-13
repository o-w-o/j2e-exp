/* global app, notify, dwr */

app.msg.user = new Object();

app.msg.user.send = function (message) {
    notify.collectMessage(message.from, message.to, message.msg, message.type);
};

app.msg.user.receive = function (message) {
    message = JSON.parse(message);
    if(message.type==='req-mkf'){
        $('#snackbar').snackbar({
            alive: 15000,
            content: '来自' + message.from + '的好友请求' + '<a data-dismiss="snackbar"">我知道了</a><a class="mg-sm-left" onclick="app.user.contacts.accept('+ message.from  +')">同意</a>'
        });
    }else{
        app.msg.alert(message);
    }
    dwr.util.setValue("chatlog", message, {escapeHtml: false});
    
};

app.hs.user = {
    
    ds2invitecardhs: function (user, eid) {
        var card = document.createElement("div");
        var cardMain = document.createElement("div");
        var cardInner = document.createElement("div");
        var cardAction = document.createElement("div");
        var cardActionBtn = document.createElement("div");
        var cardActionLink = document.createElement("a");

        card.className = "card";
        cardMain.className = "card-main";

        cardInner.className = "card-inner";
        cardInner.innerHTML = '<p class="card-heading">' + user.name + '</p>'
            + '<p><strong>ID: </strong>'
            + user.id
            + '</p><p><strong>邮箱: </strong>'
            + user.email
            + '</p>';

        cardAction.className = "card-action";
        cardActionBtn.className = "card-action-btn pull-right bg-dblue-gold";
        cardActionLink.innerHTML = "加为好友";
        cardActionLink.className = "btn waves-attach";
        cardActionLink.addEventListener('click', function () {
            var message = {
                from: app.user.info.id,
                to: user.id,
                msg: app.user.info.id + '请求加你为好友',
                type: 101
            };
            app.msg.user.send(message);
        });
        cardActionBtn.appendChild(cardActionLink);
        cardAction.appendChild(cardActionBtn);

        cardMain.appendChild(cardInner);
        cardMain.appendChild(cardAction);

        card.appendChild(cardMain);

        document.getElementById(eid).appendChild(card);
    },
}

app.user = {
    
    path:{
        /**
         * 信箱
         * <br>[0] 获取信件列表
         * <br>[1] 待建设...
         * @type Array
         */
        msg:[
            app.path + "/u?target=getmsglist"
        ],
        /**
         * 联系人
         * <br>[0] 获取好友列表
         * <br>[1] 查找好友
         * <br>[2] 同意好友请求
         * <br>[3] !拒绝好友请求
         * <br>[4] !好友分组
         * <br>[5] !好友备注
         * @type Array
         */
        contacts:[
            app.path + "/u?target=getcontacts",
            app.path + "/u?target=findfriend",
            app.path + "/u?target=acceptitmfreq"
        ],
        /**
         * 表格
         * <br>[0] 新建表格
         * <br>[1] 可管理表格
         * <br>[2] 可填写表格
         * <br>[3] 获取表格详情
         * <br>[4] 获取表格数据
         * <br>[5] 提交表格数据
         * @type Array
         */
        cacl:[
            app.path + "/u?target=postcacl",        //新建表格
            app.path + "/u?target=getcaclist",      //可管理表格
            app.path + "/u?target=getformlist",     //可填写表格
            app.path + "/u?target=getcacldetail",   //获取表格详情
            app.path + "/u?target=getcacldata",     //获取表格数据
            app.path + "/u?target=postcacldata"     //提交表格数据
        ]
    },
    
    info:{
        id:0,
        name:""
    },
    
    messages:{
        
        data: {},
        
        set:function(){
            $.ajax({
                url: app.user.path.msg[0],
                type: 'get',
                async: false,
                dataType: "json",
                success: function (data) {
                    app.user.messages.data = data;
                },
                error: function () {
                    app.msg.alert("获取信件消息列表失败...");
                    status = -1;
                }
            });
        },
        
        delete:function(mid){
            
        }
        
    },
    
    calcs: {
        
        post: function (json) {
            app.user.calcs.isPosted = false;
            $.ajax({
                url: app.user.path.cacl[0] + '&data=' + json,
                type: 'post',
                async: false,
                dataType: "json",
                success: function (data) {
                    app.user.calcs.isPosted = true;
                    app.msg.snackbar("表格发布成功 ! ");
                },
                error: function () {
                    app.msg.alert("表格发布失败...");
                }
            });
            return app.user.calcs.isPosted;
        },
        isPosted:false,
        submit: function(tid, data) {
            app.user.calcs.iSubmited = false;
            $.ajax({
                url: app.user.path.cacl[5] + '&tid=' + tid + '&data=' + data,
                type: 'post',
                async: false,
                dataType: "json",
                success: function (data) {
                    app.user.calcs.iSubmited = true;
                    app.msg.snackbar("表单提交成功 ! ");
                },
                error: function(){
                    app.msg.alert("表单提交失败...");
                }
            });
            return app.user.calcs.iSubmited;
        },
        iSubmited:false,
        getData: function(tid){
            return $.getJSON(app.user.path.cacl[4] + '&tid=' + tid);
        },
        delete:function(){
            
        }
    },
    
    thiscalc:{
        tid: 0,
        data: {}
    },
    
    contacts:{
        
        data:[],
        set:function(){
            $.ajax({
                url: app.user.path.contacts[0],
                type: 'get',
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.code === "200") {
                        app.user.contacts.data = [];
                        var data = data.data;
                        var groups = app.user.contacts.data;
                        var gnums = 0;
                        var lastgid;
                        
                        for (var i = 0; i < data.length; i++) {
                            //console.log(gnums);
                            //console.log(groups);

                            if (gnums === 0) {

                                lastgid = data[i].tag;

                                var group = {
                                    id: data[i].tag,
                                    data: [],
                                    sign:false,
                                    selected:false
                                };

                                gnums++;
                                

                                var pal = {
                                    lid: data[i].lid,
                                    lname: data[i].lname,
                                    sign: false,
                                    selected: false
                                };
                                
                                group.data.push(pal);
                                groups.push(group);
                                //console.log(groups[0]);

                            } else if ((data[i].tag !== lastgid)) {

                                lastgid = data[i].tag;

                                var group = {
                                    id: data[i].tag,
                                    data: [],
                                    sign:false,
                                    selected:false
                                };

                                gnums++;
                                
                                var pal = {
                                    lid:data[i].lid,
                                    lname:data[i].lname,
                                    sign:false,
                                    selected:false
                                };
                                
                                group.data.push(pal);
                                groups.push(group);

                            } else {
                                
                                var pal = {
                                    lid: data[i].lid,
                                    lname: data[i].lname,
                                    sign: false,
                                    selected: false
                                };
                                
                                groups[gnums - 1].data.push(pal);
                            }
                        }
                        
                    } else {
                        app.msg.alert("好友列表获取失败!请尝试刷新页面...");
                    }
                },
                error: function () {
                    app.msg.alert("未知错误!或许页面已过期...");
                    status = -1;
                }
            });
        },
        accept:function(fid){
            $.ajax({
                url: app.user.path.contacts[2] + "&fid=" + fid,
                type: 'post',
                async: true,
                dataType: "json",
                success: function (data) {
                    if (data.code==="200") {
                        app.msg.snackbar(data.data);
                    } else {
                        app.msg.alert(data.data);
                    }
                },
                error: function () {
                    app.msg.alert("未知错误!或许页面已过期...");
                    status = -1;
                }
            });
        },
        decline:function(){
            
        }
    },
    
    thiscontact:{
        
        set:function(fid){
            
        },
        
        fobj: {
            uid: 00000,
            uname: "system",
            gname: "系统",
            detial: {
                gender: "",
                email: "",
                words: "I am the honor !"
            },
            msg: {
                x:{},
                o:{}
            }
        }
        
    },
    
    search:{
        stranger: function(uid, eid){
            $.ajax({
                url: app.user.path.contacts[1] + "&uid=" + $("#fid").val(),
                type: 'get',
                async: false,
                dataType: "json",
                success: function (data) {
                    var users = data;
                    document.getElementById(eid).innerHTML = "";

                    for (var i = 0; i < users.length && i < 10; i++) {
                        app.hs.user.ds2invitecardhs(users[i], eid);
                    }
                },
                error: function () {
                    app.msg.alert("未知错误...");
                    status = -1;
                }
            });
        }
    }
    
};

app.user.init = function(){
    app.user.info.id = app.cookie.get("uid");
    app.plugin.scrollup();
};

app.user.init();