package henu.controller.notify;

import henu.dao.vo.Message;
import henu.dao.DaoFactory;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
//import org.directwebremoting.ScriptSessionFilter;
import org.directwebremoting.ScriptSessions;
import org.directwebremoting.ServerContext;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;


/**
 *
 * @author dot
 */
public final class NotifyController {
    
    public static final Map MSGTYPEMAP = new HashMap();
    
    public void initMessageTypeMap(){
        
        MSGTYPEMAP.put(000, "sys");
        MSGTYPEMAP.put(001, "notify-sys");
        MSGTYPEMAP.put(002, "notify-cacl");
        MSGTYPEMAP.put(003, "notify-sys2usr");
        MSGTYPEMAP.put(100, "req");
        MSGTYPEMAP.put(101, "req-mkf");
        MSGTYPEMAP.put(200, "letter");
        MSGTYPEMAP.put(300, "im");
        MSGTYPEMAP.put(901, "bug");
        MSGTYPEMAP.put(901, "feedback");
    }
    
    public NotifyController(){
        initMessageTypeMap();
    }
    
    public String getMessageType(int typecode){
        if(MSGTYPEMAP.containsKey(typecode)){
            return MSGTYPEMAP.get(typecode).toString();
        } else {
            return null;
        }
    }
    
    public boolean collectMessage(String from, String to, String msg, int typecode) {
        System.out.println("NotifyController collectMessage...");
        String type = getMessageType(typecode);
        
        if (isValid(from, to, msg) && type!=null) {
            System.out.println("Message content is legal !\n"
                + "next check the road from " + from + " send "+ type + " message to " + to + " is legal?");
            
            if (hasMessageRole(from, type)) {
                
                System.out.println("Message has right road ! \n" 
                    + "next check the user "+ to + " is online ?" );
                
                Message message = new Message(from, to, msg, new Timestamp(System.currentTimeMillis()).toString(), type);
                return isOnline(to) ? 
                    storeMessage(message, false) && dispatchMessage(message) :
                    storeMessage(message, false);

            } else {
                
                sendErrorInfo("请检查无误后再发送!");
                System.out.println("Message hasn't right road !");
                return false;
            }

        } else {
            sendErrorInfo("请检查无误后再发送!");
            return false;
        }
    }
    
    public boolean hasMessageRole(String from, String type) {
        HttpSession session = OnlineUserMap.getUserSessionByUid(from);
        
        if (session == null) {
            return false;
        }
        
        boolean iSysMsg = "sys".equals(type) || "sys-response".equals(type);

        System.out.println("message's role is checking ...");

        System.out.println("uid is" + from
            + " session's uid is " + session.getAttribute("uid"));

        System.out.println("user type is: " + session.getAttribute("utype"));

        return from.equals(session.getAttribute("uid").toString()) && ((!iSysMsg && "user" == session.getAttribute("utype"))
            || (iSysMsg && "admin".equals(session.getAttribute("utype"))));
    }

    public boolean isOnline(String to) {

        if (OnlineUserMap.isOnline(to)
            && (getPingResponse(to) == true
            ? true : OnlineUserMap.changeRegisterStatus(to, false))) {

            System.err.println("user " + to + " is online ");
            return true;

        } else {

            System.err.println("user " + to + " is offline ");
            return false;
        }
    }

    public boolean getPingResponse(String to) {
        return true;
    }
    
    public boolean storeMessage(Message message, boolean status) {
        System.out.println("NotifyController storeMessage...");
        if(DaoFactory.getMsgDaoInstance().save(message, status)){
            sendSuccessInfo("信息已保存...");
            return true;
                
        } else {
            sendErrorInfo("信息保存失败 !");
            return false;
        }
    }
    
    public boolean dispatchMessage(Message message) {
        System.out.println("NotifyController dispatchMessage...");
        String type = message.getType();

        switch (type) {
            case "im":
            case "letter":
            case "notify-sys2usr":
            case "req-mkf":
                return sendToUser(message);
                
            case "bug":
            case "feedback":
                return sendToSystem(message);

            case "sys":
            case "notify-sys":
            case "notify-cacl":
                return sendSystemNotice(message);

            default:
                return false;
        }
    }

    public boolean sendToUser(final Message message) {
        
        final String from = message.getFrom();
        final String to = message.getTo();
        
        if ("req-mkf".equals(message.getType())) {
            DaoFactory.getLinkerDaoInstance().makeFriend(from, to);
        }
        
        //调用filter功能  
        Browser.withAllSessionsFiltered((ScriptSession session) -> {
            String uid = (String) session.getAttribute("uid");
            if (uid == null) {
                return false;
            } else {
                
                System.out.println("filter uid : " + uid + " ? " + message.getTo() + " is equal ? " + to.equals(message.getTo()));
                return (session.getAttribute("uid")).equals(to);
            }
        }, new Runnable() {

            public ScriptBuffer script = new ScriptBuffer();

            @Override
            public void run() {

                //设置要调用的 js及参数  
                script.appendCall("app.msg.user.receive", JSONObject.fromObject(message).toString());

                Collection<ScriptSession> sessions = Browser
                    .getTargetSessions();

                sessions.stream().forEach((scriptSession) -> {
                    scriptSession.addScript(script);
                });
            }
        });
        
        sendSuccessInfo("信息已发送...");
        return true;
        
    }
    
    public boolean sendToSystem(Message message) {
        return true;
    }
   
    public boolean sendSystemNotice(Message message) {
        return true;
    }
    
    public void sendTest(final Message message) {
        System.out.println("NotifyController is prepare run sendToUser...");

        //ScriptSessions ss = ;
        //Container c = (Container) RoleController.getUserSessionByUid(message.getTo());
        WebContext wctx = WebContextFactory.get();
        ServerContext sctx = ServerContextFactory.get();

        System.out.println(
            "\n=========================\n"
            + "\ndwr infomation :"
            + "\nis empty ? " + Browser.getTargetSessions().isEmpty()
            + "\nsize : " + Browser.getTargetSessions().size()
            + "\ncurrent page is : " + wctx.getCurrentPage()
            + "\ncompare session id : " + wctx.getSession().getId() + " : " + OnlineUserMap.getUserSessionId(message.getFrom())
            + "\nscript session id is : " + wctx.getScriptSession().getId()
            + "\ncurrent page is : " + wctx.getContainer().toString()
            //+ "\nis empty ? " + Browser.getTargetSessions().isEmpty()

            + "\n=========================\n"
        );
        
    }
    
    public void sendErrorInfo(final String error) {
        Browser.withSession(WebContextFactory.get().getScriptSession().getId(), () -> {
            ScriptSessions.addFunctionCall("app.msg.alert", error);
        });
    }

    public void sendSuccessInfo(final String success) {
        Browser.withSession(WebContextFactory.get().getScriptSession().getId(), () -> {
            ScriptSessions.addFunctionCall("app.msg.snackbar", success);
        });
    }
    
    public void onPageLoad() {
        
        ScriptSession scriptSession = WebContextFactory.get().getScriptSession();
        OnlineUserScriptSessionRegister dwrScriptSessionManagerUtil = new OnlineUserScriptSessionRegister();

        try {

            dwrScriptSessionManagerUtil.init();
            System.out.println("init ...");

        } catch (ServletException e) {
        }
    }

    public boolean isValid(String from, String to, String msg) {
        return msg != null && msg.trim().length() > 0;
    }

}
