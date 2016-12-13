
/* global app, tinymce */

/**
 * View Controller 视图控制器
 * @type Object
 */
app.vc = {};

/**
 * HTML Segment HTML片段
 * @type Object
 */
app.hs = {};

/**
 * 信息模块
 * @type Object
 */
app.msg = {
    /**
     * 警告框
     * @param {String} msg
     * @returns {null}
     */
    alert: function (msg) {
        $('#modal-msg').html(msg);
        $('#modal').modal('show');
        return true;
    },
    /**
     * 确定框
     * @param {String} msg
     * @returns {Boolean}
     */
    comfirm: function (msg) {
        return true;
    },
    /**
     * 提示框
     * @param {String} msg
     * @returns {null}
     */
    snackbar: function (msg) {
        $('#snackbar').snackbar({
            alive: 10000,
            content: msg + '<a data-dismiss="snackbar"">我知道了</a>'
        });
    }
    
};

/**
 * 正则表达验证 组件
 * @type Object
 */
app.regx = {
    password: null,
    cname: null,
    ename: null,
    email: null,
    uid: null,
    trim:function(str){
        var reg = /^\s*|\s*$/g;
        var _str = str.replace(reg, "");
        
        console.log(_str);
        return _str;
    }
};

app.cookie = {
    get : function(attr){
        var arr, reg = new RegExp("(^| )" + attr + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }
};

app.json = {};

app.editor={
    
    configure: function(eid){

        // 编辑器 初始化
        tinymce.init({
            mode : "exact",
            selector: '#' + eid,
            fixed_toolbar_container: 'body',
            theme: 'inlite',
            language: 'zh_CN',
            inline: true,
            plugins: [
                'advlist autolink autosave code link image lists charmap codesample hr anchor',
                'searchreplace visualchars insertdatetime media nonbreaking fullscreen',
                'table contextmenu directionality emoticons template paste preview textcolor textpattern visualblocks'
            ],
            insert_toolbar: 'h1 h2 h3 hr bullist numlist outdent indent  blockquote quickimage codesample insertdatetime template | removeformat',
            selection_toolbar: 'bold italic underline subscript superscript textcolor forecolor backcolor strikethrough | alignleft aligncenter alignright alignjustify  outdent indent | link h1 h2 h3 blockquote codesample media | removeformat | ',
            contextmenu: 'image media codesample | charmap | link anchor | inserttable | cell row column deletetable | visualblocks preview',
            insertdatetime_formats: ["%H:%M:%S %Y-%m-%d", "%H:%M:%S", "%Y-%m-%d", "%I:%M:%S %p", "%D"],
            templates: [
                {title: 'Some title 1', description: 'Some desc 1', content: 'My content'},
                {title: 'Some title 2', description: 'Some desc 2', url: 'development.html'}
            ],
            textpattern_patterns: [
                {start: '*', end: '*', format: 'italic'},
                {start: '**', end: '**', format: 'bold'},
                {start: '#', format: 'h1'},
                {start: '##', format: 'h2'},
                {start: '###', format: 'h3'},
                {start: '####', format: 'h4'},
                {start: '#####', format: 'h5'},
                {start: '######', format: 'h6'},
                {start: '>_ ', format: 'blockquote'},
                {start: '1. ', cmd: 'InsertOrderedList'},
                {start: '* ', cmd: 'InsertUnorderedList'},
                {start: '- ', cmd: 'InsertUnorderedList'}
            ],
            media_live_embeds: true,
            init_instance_callback: function (editor) {
                editor.on('Change', function (e) {
                    cntIsChange = true;
                    hidIsSubmit = false;
                    console.log('Editor contents was changed.');
                    console.log("有未提交内容 !");
                });
            }

        });
    },
    getContent: function(eid){
        return tinymce.get(eid).getContent({
            format: 'raw'
        });
    }
    
};

app.plugin = {
    scrollup:function(){
        //返回顶部 插件 scrollUp 配置
        $(function () {
            $.scrollUp({
                scrollName: 'scrollUp', // Element ID
                scrollDistance: 0, // Distance from top/bottom before showing element (px)
                scrollFrom: 'top', // 'top' or 'bottom'
                scrollSpeed: 300, // Speed back to top (ms)
                easingType: 'linear', // Scroll to top easing (see http://easings.net/)
                animation: 'fade', // Fade, slide, none
                animationSpeed: 200, // Animation speed (ms)
                scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
                scrollTarget: false, // Set a custom target element for scrolling to. Can be element or number
                scrollText: '', // Text for element, can contain HTML
                scrollTitle: false, // Set a custom <a> title if required.
                scrollImg: false, // Set true to use image
                activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
                zIndex: 2000                 // Z-Index for the overlay

            });
        });
    }
};

app.signout = function signOut() {
    $.ajax({
        url: app.path + "/role?target=signOut",
        type: 'post',
        success: function (data) {
            if (data === "ok") {
                app.msg.alert("正在退出...");
            } else {
                app.msg.snackbar("未知错误!请尝试刷新页面...");
            }
        },
        error: function () {
            app.msg.snackbar("未知错误!请尝试关闭浏览器...");
            status = -1;
        }
    });
    window.top.location = app.path + '/';
};