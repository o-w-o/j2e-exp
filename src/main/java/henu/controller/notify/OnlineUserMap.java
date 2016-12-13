package henu.controller.notify;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;

/**
 *
 * @author dot
 */
public class OnlineUserMap {
    
    public static  final String ANN = "anonymous";
    public static  final String USR = "user";
    public static  final String ADM = "admin";
    
    /**
     * 匿名用户 Session Map
     */
    public static  Map<String, HttpSession> onlineAnonymousMap = new HashMap();

    /**
     * 已登录用户 Session Map
     */
    public static  Map<String, HttpSession> onlineUserMap = new HashMap<>();

    public static boolean isOnline(String uid) {
        return onlineUserMap.containsKey(uid);
    }

    public static synchronized  boolean registerAnonymous(HttpSession session) {
        if (session != null) {
            onlineAnonymousMap.put(session.getId(), session);
            System.out.println("匿名用户 进入...");
            return true;
        } else {
            return false;
        }
    }

    public static synchronized  boolean clearAnonymous(String sid) {
        if (onlineAnonymousMap.containsKey(sid)) {
            onlineAnonymousMap.remove(sid);
            System.out.println("匿名用户 消除...");
            return true;
        } else {
            return false;
        }
    }

    public static synchronized  boolean registerUser(HttpSession session) {
        if (session != null) {
            if (!isOnline(session.getAttribute("uid").toString())) {
                onlineUserMap.put(session.getAttribute("uid").toString(), session);
                System.out.println("用户 " + session.getAttribute("uid").toString() + "进入...");
            } else {
                //特殊事务启动 : 暂设置为 只允许一个用户登录
                String uid = session.getAttribute("uid").toString();
                HttpSession lastSession = onlineUserMap.get(uid);
                System.out.println("检测到用户" + uid + "多处登录...");

                lastSession.setAttribute("utype", ANN);
                registerAnonymous(lastSession);
                clearUser(uid);
                onlineUserMap.put(session.getAttribute("uid").toString(), session);
            }
            return true;
        } else {
            return false;
        }
    }

    public static synchronized  boolean clearUser(String uid) {
        if (onlineUserMap.containsKey(uid)) {
            onlineUserMap.remove(uid);
            System.out.println("用户 " + uid + "退出...");
            return true;
        } else {
            return false;
        }
    }

    public static HttpSession getUserSession(String sessionId) {
        if (sessionId == null) {
            return null;
        } else {
            return (HttpSession) onlineAnonymousMap.get(sessionId);
        }
    }

    public static String getUserSessionId(String uid) {
        if (onlineUserMap.containsKey(uid)) {
            return onlineUserMap.get(uid).getId();
        } else {
            return null;
        }
    }

    public static boolean changeRegisterStatus(String uid, boolean status) {
        getUserSession(uid).setAttribute("status", status);
        return true;
    }

    public static HttpSession getUserSessionByUid(String uid) {
        return getUserSession(getUserSessionId(uid));
    }
}
