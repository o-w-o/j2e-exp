package henu.controller.notify;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import org.directwebremoting.Container;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.event.ScriptSessionEvent;
import org.directwebremoting.event.ScriptSessionListener;
import org.directwebremoting.extend.ScriptSessionManager;
import org.directwebremoting.servlet.DwrServlet;
/**
 *
 * @author dot
 */
class OnlineUserScriptSessionRegister  extends DwrServlet{
    private static final long serialVersionUID = -7504612622407420071L;

    @Override
    public void init() throws ServletException {

        Container container = ServerContextFactory.get().getContainer();
        ScriptSessionManager manager = container.getBean(ScriptSessionManager.class);
        ScriptSessionListener listener = new ScriptSessionListener() {
            
            @Override
            public void sessionCreated(ScriptSessionEvent ev) {
                HttpSession session = WebContextFactory.get().getSession();

                String uid = session.getAttribute("uid").toString();
                ev.getSession().setAttribute("uid", uid);
                System.out.println("a script session is created! [attr :"+ uid +"]");
            }

            @Override
            public void sessionDestroyed(ScriptSessionEvent ev) {
                System.out.println("a script session is distroyed");
            }
            
        };
        manager.addScriptSessionListener(listener);
    } 
}
