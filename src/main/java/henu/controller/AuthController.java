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
package henu.controller;

import henu.controller.notify.OnlineUserMap;
import henu.dao.api.IUserDao;
import henu.dao.DaoFactory;
import henu.util.SignRegisterUtils;
import henu.util.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * @author dot
 */
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static final String ANN = "anonymous";
    public static final String USR = "user";
    public static final String ADM = "admin";
    
    /**
     * @see HttpServlet #HttpServlet()
     */
    public AuthController(){
        super();
    }

    @Override
    public void init(ServletConfig config) throws ServletException{
        super.init();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.service(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        
        //获取行动对象
        String target = req.getParameter("target");
        
        if (target != null) {
            switch (target) {
                case "test": {
                    doTestGet(req, resp);
                    break;
                }
            }
        } else {
            
        }
    }
    
    protected void doTestGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        
        try ( 
            PrintWriter out = resp.getWriter()) {
            out.print(StringConvert.UTF2IOS("Hi doUserGet() 中文测试 !"));
        }
        
    }
    
    /**
     * doPost() 方法用于处理客户端POST方式的HTTP请求
     * @see HttpServlet#doPost(HttpServletRequest req, HttpServletResponse resp)
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
       
        String target = req.getParameter("target");
        
        if (target != null) {
            switch (target) {
                case "signIn":{
                    doSignInPost(req,resp);
                    break;
                }
                case "signOut":{
                    doSignOutPost(req, resp);
                    break;
                }
            }
        }
    }
    
    protected void doSignInPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uid = req.getParameter("uid");
        String password = req.getParameter("password");
        System.out.print(uid + " " + password);
        try ( 
            PrintWriter out = resp.getWriter()) {
            IUserDao user = DaoFactory.getUserDaoInstance();
            HttpSession httpSession = req.getSession();
            
            switch (user.isExist(uid)){
                case USR:{
                    if(user.signIn(uid, password)){
                        
                        httpSession.setAttribute("utype", USR);
                        httpSession.setAttribute("status", true);
                        httpSession.setAttribute("uid", uid);
                        
                        SignRegisterUtils.setCookie(resp, "uid", uid, -1);
                        OnlineUserMap.registerUser(httpSession);
                        System.out.println("用户: " + uid + "登录成功 !");
                        out.print("ok");
                    }else {
                        out.print("false");
                    }
                    break;
                }
                case ADM:{
                    if (user.signIn(uid, password)) {
                        
                        httpSession.setAttribute("utype", ADM);
                        httpSession.setAttribute("status", true);
                        httpSession.setAttribute("uid", uid);
                        
                        SignRegisterUtils.setCookie(resp, "uid", uid, -1);
                        
                        OnlineUserMap.registerUser(httpSession);
                        System.out.println("管理员: " + uid + "登录成功 !");
                        out.print("ok");
                    } else {
                        out.print("false");
                    }
                    break;
                }
                default:out.print("false");
            }
        }
    }

    protected void doSignOutPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        
        try ( 
            //创建out内置对象
            PrintWriter out = resp.getWriter()) {
            HttpSession session = req.getSession();
            out.print("ok");
            
            OnlineUserMap.clearUser(req.getSession().getAttribute("uid").toString());
            System.out.println("用户: " + session.getAttribute("uid") + "退出成功 !");
            session.invalidate();
        }
    }
    
}


