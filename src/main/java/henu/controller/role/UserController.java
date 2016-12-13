/*
 * Copyright (C) 2016 dot
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package henu.controller.role;

import henu.dao.vo.Cacl;
import henu.dao.DaoFactory;
import henu.util.IDUtils;
import henu.util.JSONUtils;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.eclipse.jetty.util.ajax.JSON;

public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ServletConfig config = null;

    public UserController() {
        super();
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init();
        this.config = config;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //获取行动对象
        String target = req.getParameter("target");

        if (target != null) {
            switch (target) {
                case "me": {
                    doMeGet(req, resp);
                    break;
                }
                case "table": {
                    doTableGet(req, resp);
                    break;
                }
                case "getcontacts": {
                    doContactsGet(req, resp);
                    break;
                }
                case "getmsglist": {
                    doMsgListGet(req, resp);
                    break;
                }
                case "findfriend": {
                    doFindFriendGet(req, resp);
                    break;
                }
                case "getcaclist": {
                    doCacListGet(req, resp);
                    break;
                }
                case "getformlist": {
                    doFormListGet(req, resp);
                    break;
                }
                case "getcacldetail": {
                    doCaclDetailGet(req, resp);
                    break;
                }
                case "getcacldata": {
                    doCaclDataGet(req, resp);
                    break;
                }
            }
        } else {
            switch (req.getRequestURI().replace("/j2e", "")) {
                case "/u/cacl": {
                    req.getRequestDispatcher("/WEB-INF/jsp/u/ThisCacl.jsp").forward(req, resp);
                    break;
                }
                default: {
                    req.getRequestDispatcher("/WEB-INF/jsp/u/Index.jsp").forward(req, resp);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String target = req.getParameter("target");

        if (target != null) {
            
            resp.addHeader("Cache-Control", "no-cache");
            resp.setContentType("text/json");
            
            switch (target) {
                case "me": {
                    doMePost(req, resp);
                    break;
                }
                case "table": {
                    doTablePost(req, resp);
                    break;
                }
                case "friend": {
                    doFriendPost(req, resp);
                    break;
                }
                case "acceptitmfreq": {
                    doAcceptItMfReqPost(req, resp);
                    break;
                }
                case "declineitmfreq": {
                    doDeclineItMfReqPost(req, resp);
                    break;
                }
                case "postcacl": {
                    doCaclPost(req, resp);
                    break;
                }
                case "postcacldata": {
                    doCaclDataPost(req, resp);
                    break;
                }
            }
        } else {

            req.getRequestDispatcher("/WEB-INF/jsp/u/Index.jsp").forward(req, resp);
        }
    }

    private void doMeGet(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doMePost(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doTableGet(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doTablePost(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doContactsGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();

        out.print(
            JSONUtils.setStatusCode(200,
                JSONArray.fromObject(
                    DaoFactory.getLinkerDaoInstance().getFriendsList(
                        req.getSession().getAttribute("uid").toString()
                    )
                ).toString()
            )
        );

        out.close();
    }

    private void doFriendPost(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doMsgListGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        PrintWriter out = resp.getWriter();

        out.print(
            //StringConvert.IOS2UTF(
            JSONArray.fromObject(
                DaoFactory.getMsgDaoInstance().getMessageList(
                    req.getSession().getAttribute("uid").toString()
                )
            ).toString()
            //)
        );

        out.close();

    }

    private void doFindFriendGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        PrintWriter out = resp.getWriter();

        out.print(
            JSONArray.fromObject(
                DaoFactory.getUserDaoInstance().findUsers(req.getParameter("uid"))).toString()
        );
        out.close();
    }

    private void doAcceptItMfReqPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        PrintWriter out = resp.getWriter();

        String gname = null == req.getParameter("gname") ? "我的好友" : req.getParameter("gname");

        boolean status = DaoFactory.getLinkerDaoInstance().approveFriend(
                req.getSession().getAttribute("uid").toString(), req.getParameter("fid"), gname
        );

        if (status) {
            out.print(
                JSONUtils.setStatusCode(200, ("\"添加好友成功~\"")));
        } else {
            out.print(
                JSONUtils.setStatusCode(300, ("\"出错了!或许您已添加过该好友了!\"")));
        }

        out.close();
    }

    private void doDeclineItMfReqPost(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doCacListGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        PrintWriter out = resp.getWriter();

        out.print(
            JSONArray.fromObject(
                DaoFactory.getCaclDaoInstance().getCacList(
                    req.getSession().getAttribute("uid").toString()
                )
            ).toString()
        );

        out.close();
    }

    private void doFormListGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();

        out.print(
            JSONArray.fromObject(
                DaoFactory.getCaclDaoInstance().getFormList(
                    req.getSession().getAttribute("uid").toString()
                )
            ).toString()
        );

        out.close();
    }

    private void doCaclDetailGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();

        out.print(
            JSONArray.fromObject(
                DaoFactory.getCaclDaoInstance().getCacl(
                    req.getParameter("tid")
                )
            ).toString()
        );

        out.close();
    }

    private void doCaclDataGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();

        out.print(
            JSONArray.fromObject(
                DaoFactory.getCaclDaoInstance().getCaclData(
                    req.getParameter("tid")
                )
            ).toString()
        );

        out.close();
    }

    private void doCaclPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();

        Map caclMap =  (Map) JSON.parse(req.getParameter("data"));
        System.out.println(JSONArray.fromObject(caclMap));
        
        Cacl cacl = new Cacl();
        cacl.setName(caclMap.get("name").toString());
        cacl.setStructure(caclMap.get("structure").toString());
        
        Object[] usersobj = (Object[]) caclMap.get("users");
        long[] users = new long[usersobj.length];
        
        for (int i = 0; i < usersobj.length; i++) {
            users[i] = Long.parseLong(usersobj[i].toString());
            System.out.println(usersobj[i]);
            
        }
        
        long tid = IDUtils.getId();
        cacl.setTid(tid);
        cacl.setUsers(users);
        
        cacl.setAuthor(Long.parseLong(req.getSession().getAttribute("uid").toString()));
        System.out.println(JSONArray.fromObject(cacl));
        System.out.println(JSONArray.fromObject(caclMap.get("users")));

        out.print(
            JSONArray.fromObject(
                DaoFactory.getCaclDaoInstance().createCacl(cacl)
            ).toString()
        );

        out.close();
    }

    private void doCaclDataPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();
        
        out.print(
            JSONArray.fromObject(
                DaoFactory.getCaclDaoInstance().appendUserDate(
                    req.getParameter("tid"), req.getSession().getAttribute("uid").toString(), req.getParameter("data")
                )
            ).toString()
        );

        out.close();
    }
}
