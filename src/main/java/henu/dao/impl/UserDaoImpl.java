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
package henu.dao.impl;

import henu.dao.DaoFactory;
import henu.dao.vo.User;
import henu.dao.api.IUserDao;
import henu.util.SqlDB;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dot
 */
public class UserDaoImpl implements IUserDao {
    
    public static final String ANN = "anonymous";
    public static final String USR = "user";
    public static final String ADM = "admin";

    public static void main(String[] args) {
        DaoFactory.getUserDaoInstance().isExist("2269396338");
    }
    
    @Override
    public boolean signUp(User user) {
        

        return false;
    }

    @Override
    public boolean signIn(String uid, String password) {
        
        String sql = "select * from user where uid='" + uid + "'and password='" + password + "'";
        ResultSet resultSet = SqlDB.executeQuery(sql);

        try {
            if (resultSet.next()) {
                System.out.println("用户: " + resultSet.getLong("UID") + " 信息验证通过");
                return true;
            }
        } catch (SQLException ex) {

        }
        System.out.println(sql);
        SqlDB.close();

        return false;
    }

    @Override
    public boolean signOut(String uid, String password) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean appendUser(User user) {

        String sql = "insert into user (uid, gender, utype, email, birthday, uwords, password, uname) values(?,?,?,?,?,?,?,?)";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);

        int result = 0;
        try {
            ps.setInt(1, Integer.parseInt(user.getId()));
            ps.setString(2, user.getGender());
            ps.setString(3, user.getUtype());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getBrithday()==null?" ":user.getBrithday());
            ps.setString(6, user.getUwords()==null?" ":user.getUwords());
            ps.setString(7, user.getPassword());
            ps.setString(8, user.getName());
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result > 0;
    }

    @Override
    public boolean deleteUser(String uid) {
        String sql = "delete from user where uid=" + uid;

        int result = SqlDB.executeUpdate(sql);

        SqlDB.close();

        return result > 0;
    }

    /**
     * @param user
     * @param uid
     * @return
     */
    @Override
    public boolean updateUserPassword(String uid, User user) {
        String sql = "update user set password=? where uid=?";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);
        int result = 0;

        try {
            ps.setString(1, user.getPassword());
            ps.setString(2, uid);
            result = ps.executeUpdate();
            System.out.println("result: " + result);
        } catch (Exception e) {
        }

        SqlDB.close();
        return result>0;
    }

    @Override
    public boolean updateUserBasicInfo(String uid, User user) {

        String sql = "update user set uname=?, gender=?, email=?, birthday=?, uwords=? where uid=?";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);

        int result = 0;
        try {
            ps.setString(1, user.getName());
            ps.setString(2, user.getGender());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getBrithday());
            ps.setString(5, user.getUwords());
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result>0;
    }

    @Override
    public boolean updateUserType(String uid, User user) {
        String sql = "update user set utype=? where uid=?";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);
        int result = 0;

        try {
            ps.setString(1, user.getUtype());
            ps.setString(2, uid);
            result = ps.executeUpdate();
            System.out.println("result: " + result);
        } catch (Exception e) {
        }

        SqlDB.close();
        return result>0;
    }

    @Override
    public User getUser(String uid, boolean isPublic) {
        String sql = "select * from user where uid=" + uid;

        ResultSet rs = SqlDB.executeQuery(sql);
        User user = new User();
        if (isPublic == true) {
            try {
                if (rs.next()) {
                    user.setId(String.valueOf(rs.getLong("UID")));
                    user.setName(rs.getString("uname"));
                    user.setGender(rs.getString("gender"));
                    user.setEmail(rs.getString("email"));
                    user.setUwords(rs.getString("uwords"));
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                user.setBrithday(rs.getString("birthdy"));
                user.setUtype(rs.getString("utype"));
                user.setUwords(rs.getString("uwords"));
                user.setEmail(rs.getString("email"));
                user.setGender(rs.getString("gender"));
                user.setName(rs.getString("uname"));
                user.setPassword("***");
                user.setId(Long.toString(rs.getLong("UID")));
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        SqlDB.close();

        return user;
    }

    @Override
    public List<User> getUsersInfo() {
        String sql = "select * from user where utype='user' order by uid";
        List<User> list = new ArrayList<User>();

        ResultSet rs = SqlDB.executeQuery(sql);
        try {
            while (rs.next()) {
                User user = new User();
                user.setBrithday(rs.getString("birthday"));
                user.setUtype(rs.getString("utype"));
                user.setUwords(rs.getString("uwords"));
                user.setEmail(rs.getString("email"));
                user.setGender(rs.getString("gender"));
                user.setName(rs.getString("uname"));
                user.setPassword("***");
                user.setId(Long.toString(rs.getLong("UID")));
                printUserInfo(user);
                list.add(user);
            }
        } catch (Exception e) {
        }

        SqlDB.close();
        return list;
    }

    private int setUserInfoByRs(PreparedStatement ps, User user, String type) {
        int result = 0;
        try {
            ps.setString(1, user.getName());
            ps.setString(2, user.getGender());
            ps.setString(3, user.getUtype());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getBrithday());
            ps.setString(6, user.getUwords());
            ps.setString(7, user.getPassword());
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    private String printUserInfo(User u){
        String str = "name:" + u.getName() +
            "\n gender:" + u.getGender() +
            "\n uwords: " + u.getUwords()
            ; 
        return str;
    }

    @Override
    public String isExist(String uid) {
        String sql = "select * from user where uid=" + uid;
        ResultSet resultSet = SqlDB.executeQuery(sql);

        try {
            if (resultSet.next()) {
                System.out.println("存在用户: " + resultSet.getLong("UID"));
                return resultSet.getString("UTYPE");
            }
        } catch (SQLException ex) {
        }

        SqlDB.close();
        System.out.println(sql);
        System.out.println("用户 " + uid + " 不存在");
        return ANN;
    }

    @Override
    public List<User> findUsers(String uid) {
        String sql = "select * from user where uid like '" + uid + "%'";
        System.out.println(sql);

        ResultSet rs = SqlDB.executeQuery(sql);
        List<User> list = new ArrayList<User>();
        try {
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("uid"));
                user.setName(rs.getString("uname"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                user.setUwords(rs.getString("uwords"));
                printUserInfo(user);
                list.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        SqlDB.close();

        return list;
    }
}
