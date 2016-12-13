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

import henu.dao.api.ILinkerDao;
import henu.dao.vo.Linker;
import henu.dao.vo.User;
import henu.dao.DaoFactory;
import henu.util.SqlDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import net.sf.json.JSONArray;


/**
 *
 * @author dot
 */
public class LinkerDaoImpl implements ILinkerDao{
    
    public static void main(String[] args) {
        String uid = "2269396337";
        String lid;
        String tag;
        
        for (int i = 60; i < 68; i++) {
            lid = "14452020" + i;
            tag = "呵呵哒";
            System.out.println(DaoFactory.getLinkerDaoInstance().approveFriend(uid, lid, tag));
        }
    }

    @Override
    public boolean makeFriend(String uid, String lid) {
        
        if (uid.equals(lid)) {
            return false;
        }
        
        User user = DaoFactory.getUserDaoInstance().getUser(lid, true);
        System.out.println(JSONArray.fromObject(user));
        if (user.getId() != null) {

            String sql = "insert into linker "
                    + "(uid, lid, lname) values"
                    + "(?,?,?)";
            PreparedStatement ps = SqlDB.executePreparedStatement(sql);
            int result = 0;

            try {
                ps.setLong(1, Long.parseLong(uid));
                ps.setLong(2, Long.parseLong(lid));
                ps.setString(3, user.getName());
                result = ps.executeUpdate();
                System.out.println("result: " + result);
            } catch (NumberFormatException | SQLException e) {
            }

            SqlDB.close();
            System.out.println(sql + " " + result);
            return result > 0;
            
        } else {
            return false;
        }
    }
    
    @Override
    public boolean approveFriend(String uid, String lid, String tag) {
        User user = DaoFactory.getUserDaoInstance().getUser(uid, true);
        System.out.println(JSONArray.fromObject(user));
        if (user.getId()!=null) {
            
            String sql = "update linker set status=?, ltype=?, tag=?, lname=? where uid=" + lid + " and lid=" + uid ;
            PreparedStatement ps = SqlDB.executePreparedStatement(sql);
            int result = 0;

            try {
                ps.setBoolean(1, true);
                ps.setString(2, "one");
                ps.setString(3, tag);
                ps.setString(4, user.getName());
                result = ps.executeUpdate();
                System.out.println("result: " + result);
            } catch (NumberFormatException | SQLException e) {
            }
            
            SqlDB.close();
            System.out.println(sql + " " + result);
            return result > 0 && appendFriend(uid, lid, "我的好友");
        } else {
            return false;
        }
        
    }
    
    public boolean appendFriend(String uid, String lid, String tag){
        
        User linker = DaoFactory.getUserDaoInstance().getUser(lid, true);
        String sql = "insert into linker (uid, lid, lname, status, ltype, tag) values "
                + "(?,?,?,?,?,?)";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);
        int result = 0;
        
        try {
            ps.setLong(1, Long.parseLong(uid));
            ps.setLong(2, Long.parseLong(lid));
            ps.setString(3, linker.getName());
            ps.setBoolean(4, true);
            ps.setString(5, "one");
            ps.setString(6, tag);
            result += ps.executeUpdate();
            System.out.println("result: " + result);
        } catch (NumberFormatException | SQLException e) {
        }

        SqlDB.close();
        System.out.println(sql + " " + result);
        return result > 0;
    }
    
    @Override
    public boolean deleteFriend(String uid, String lid) {
        String sql = "delete from linker where uid=" + uid + "&& lid=" + lid;

        int result = SqlDB.executeUpdate(sql);

        SqlDB.close();

        return result > 0;
    }

    @Override
    public List<Linker> getFriendsList(String uid) {
        String sql = "select * from linker where status=true and uid=" + uid + " and ltype='one'  order by tag";
        List<Linker> list = new ArrayList<Linker>();

        ResultSet rs = SqlDB.executeQuery(sql);
        try {
            while (rs.next()) {
                Linker friend = new Linker();
                friend.setUid(rs.getString("uid"));
                friend.setLid(rs.getString("lid"));
                friend.setLname(rs.getString("lname"));
                friend.setTag(rs.getString("tag"));
                list.add(friend);
            }
        } catch (Exception e) {
        }

        SqlDB.close();
        return list;    
    }
    
}
