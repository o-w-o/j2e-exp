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

import henu.dao.vo.User;
import henu.dao.DaoFactory;
import henu.util.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;

public class AdministerController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    
    private ServletConfig config = null;
    private String encoding = "UTF-8";

    public static final String ANN = "anonymous";
    public static final String USR = "user";
    public static final String ADM = "admin";
    
    public static void main(String[] args) {
        String[] names = new String[10];
        names[0] = "文图拉";
        names[1] = "唐望";
        names[2] = "唐哲那罗";
        names[3] = "文生";
        names[4] = "莉萝";
        names[5] = "桔梗";
        names[6] = "亚瑟王";
        names[7] = "玲";
        names[8] = "九月";
        names[9] = "管理员";
        for (int i = 10; i < 100; i++) {
            int c = (int) (Math.random() * 10);

            User u = new User();

            u.setId("14452020" + i);
            u.setBrithday((int) (Math.random() * 30) + "-" + (int)(Math.random() * 12) + "月-1994");
            u.setEmail("1@2.com");
            u.setGender((int) (Math.random() * 10)/4 == 0 ? "male" : "female");
            u.setName(names[c]);
            u.setPassword("123");
            u.setUtype(c == 9 ? "admin" : "user");
            u.setUwords("Hello world !");
            DaoFactory.getUserDaoInstance().appendUser(u);
        }
    }
    
    public AdministerController(){
        super();
    }
    
    @Override
    public void init(ServletConfig config) throws ServletException{
        super.init();
        this.config = config;
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        
        //获取行动对象
        String target = req.getParameter("target");
        System.out.println(req.getRequestURI());
        if (target != null) {
            switch (target) {
                case "getuinfo": {
                    doUserInfoGet(req, resp);
                    break;
                }
                case "getallinfo": {
                    doAllInfoGet(req, resp);
                    break;
                }
                case "2excel": {
                    do2ExcelGet(req, resp);
                    break;
                } 
            }
        } else {
            switch (req.getRequestURI().replace("/j2e", "")) {
                case "/admin/env": {
                    req.getRequestDispatcher("/WEB-INF/jsp/administrator/EnvInfo.jsp").forward(req, resp);
                    break;
                }
                case "/admin/usr": {
                    req.getRequestDispatcher("/WEB-INF/jsp/administrator/UserManage.jsp").forward(req, resp);
                    break;
                }
                default: {
                    req.getRequestDispatcher("/WEB-INF/jsp/administrator/Index.jsp").forward(req, resp);
                }
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
        
        //获取行动对象
        String target = req.getParameter("target");

        if (target != null) {
            switch (target) {
                case "delete": {
                    doUserDeletePost(req, resp);
                    break;
                }
                case "resetpw": {
                    doPasswordResetPost(req, resp);
                    break;
                }
                case "signup": {
                    doUserSignUpPost(req, resp);
                    break;
                }
                case "autoadd": {
                    doUserAppendPost(req, resp);
                    break;
                }
            }
        }else {
            switch (req.getRequestURI().replace("/j2e", "")) {
                case "/admin/env": {
                    req.getRequestDispatcher("/WEB-INF/jsp/administrator/EnvInfo.jsp").forward(req, resp);
                    break;
                }
                case "/admin/usr": {
                    req.getRequestDispatcher("/WEB-INF/jsp/administrator/UserManage.jsp").forward(req, resp);
                    break;
                }
                default :{
                    
                }
            }
        }
    }

    private void doUserInfoGet(HttpServletRequest req, HttpServletResponse resp) {
        
    }

    private void doAllInfoGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        
        //创建out内置对象
        PrintWriter out = resp.getWriter();
        
        List<User> list = DaoFactory.getUserDaoInstance().getUsersInfo();
        String json = JSONArray.fromObject(list).toString();
        out.print(json);
    }

    private void doPasswordResetPost(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doUserDeletePost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();
        DaoFactory.getUserDaoInstance().deleteUser(req.getParameter("uid"));
        out.print("ok");
        out.close();
        
    }

    private void doUserSignUpPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        
        PrintWriter out = resp.getWriter();
        
        User user = new User();
        user.setId(req.getParameter("id"));
        user.setName(req.getParameter("name"));
        user.setUtype(req.getParameter("role"));
        user.setEmail(req.getParameter("email"));
        user.setPassword(req.getParameter("password"));
        user.setGender(req.getParameter("gender"));
        DaoFactory.getUserDaoInstance().appendUser(user);
        
        if (DaoFactory.getUserDaoInstance().isExist(req.getParameter("id")).equals(req.getParameter("role"))) {
            out.print("ok");
        } else 
            out.print("false");
        out.close();
    }

    private void do2ExcelGet(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void doUserAppendPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        
        //创建out内置对象
        PrintWriter out = resp.getWriter();
        
        out.print("done...");
        out.close();
    }
}
