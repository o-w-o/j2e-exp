package henu.controller.notify;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author dot
 */
public class OnlineUserMapListener implements HttpSessionListener{
    
    
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        OnlineUserMap.registerAnonymous(se.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        
        try {
            String uid = se.getSession().getAttribute("uid").toString();

            if (OnlineUserMap.isOnline(uid)) {
                OnlineUserMap.clearUser(uid);
            }
        } catch (Exception e) {
            System.out.println("henu.controller.app.OnlineUserListener.sessionDestroyed() 删除 在线用户 失败");
        }
        try {
            String sid = se.getSession().getId();

            OnlineUserMap.clearAnonymous(sid);
        } catch (Exception e) {
            System.out.println("henu.controller.app.OnlineUserListener.sessionDestroyed() 删除 匿名用户 失败");
        }
    }
    
    
}