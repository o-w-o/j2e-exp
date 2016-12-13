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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.sql.Timestamp;
import java.util.logging.Logger;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.apache.commons.lang.ArrayUtils;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import henu.dao.vo.Cacl;
import henu.util.NosqlDB;
import henu.util.SqlDB;
import henu.dao.api.ICaclDao;

/**
 *
 * @author dot
 */
public class CaclDaoImpl implements ICaclDao{
    
    public static void main(String[] args) {}

    @Override
    public boolean createCacl(Cacl cacl) {
        String sql = "insert into cacl (cid, cname, structure, author, postime) values(?, ?,?,?,?)";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);

        int result = 0;
        try {
            ps.setLong(1, cacl.getTid());
            ps.setString(2, cacl.getName());
            ps.setString(3, cacl.getStructure());
            ps.setLong(4, cacl.getAuthor());
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            
        }
        return result > 0 && recordCaclUser(cacl.getTid(), cacl.getUsers());
    }
    
    @Override
    public boolean recordCaclUser(long cid, long users[]){
        
        int result = 0;
        try {
            String sql = "insert into uc (cid, uid) values(?,?)";
            SqlDB.getConnection().setAutoCommit(false);
            PreparedStatement ps = SqlDB.executePreparedStatement(sql);
            
            for (int i = 0; i < users.length; i++) {
                ps.setLong(1, cid);
                ps.setLong(2, users[i]);
                ps.addBatch();
            }
            
            result = ps.executeBatch().length;
            ps.clearBatch();
            SqlDB.close();
        } catch (SQLException ex) {
            
        }

        
        return result==users.length;
    }

    @Override
    public boolean deleteCacl(String cid) {
        
        String sql = "delete from cacl where cid=" + cid;
        int result = SqlDB.executeUpdate(sql);
        SqlDB.close();
        
        Bson bson = null;
        NosqlDB.getCollection(cid).deleteMany(bson);

        return result > 0;    
    }

    @Override
    public Cacl getCacl(String cid) {
        String sql = "select * from cacl where cid=" + cid;

        ResultSet rs = SqlDB.executeQuery(sql);
        Cacl cacl = new Cacl();

        try {
            cacl.setTid(rs.getLong("cid"));
            cacl.setName(rs.getString("cname"));
            cacl.setStructure(rs.getString("structure"));
            cacl.setAuthor(rs.getInt("author"));
            cacl.setType(rs.getBoolean("ctype"));
            cacl.setPostime(rs.getTimestamp("postime").toString());
            cacl.setEndtime(rs.getString("endtime"));
            cacl.setUsers(getCaclUserList(cid));

        } catch (SQLException ex) {
            Logger.getLogger(CaclDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        SqlDB.close();

        return cacl;
    }
    
    @Override
    public List<Cacl> getCacList(String uid) {
        String sql = "select * from cacl where author = " + uid;
        System.out.println(sql);

        ResultSet rs = SqlDB.executeQuery(sql);
        List<Cacl> list = new ArrayList<Cacl>();
        try {
            while (rs.next()) {
                Cacl cacl = new Cacl();
                cacl.setTid(rs.getLong("cid"));
                cacl.setName(rs.getString("cname"));
                cacl.setPostime(rs.getTimestamp("postime").toString());
                cacl.setStructure(rs.getString("structure"));
                cacl.setAuthor(Integer.parseInt(uid));
                cacl.setUsers(getCaclUserList(Long.toString(rs.getLong("cid"))));
                list.add(cacl);
            }
        } catch (SQLException ex) {
            
        }

        SqlDB.close();

        return list;
    }

    @Override
    public long[] getCaclUserList(String cid) {
        String sql = "select uid from uc where cid = " + cid;
        System.out.println(sql);

        ResultSet rs = SqlDB.executeQuery(sql);
        List<Long> arraylist = new ArrayList();
        try {
            while (rs.next()) {
                arraylist.add(rs.getLong("uid"));
                System.out.println("UID: " + rs.getInt("uid"));
            }
        } catch (SQLException ex) {
            
        }
        
        long[] list = ArrayUtils.toPrimitive(arraylist.toArray(new Long[arraylist.size()]));

        SqlDB.close();

        return list;
    }
    
    @Override
    public List<Cacl> getFormList(String uid) {
        String sql = "select * from cacl where cid in (select cid from uc where uid = " + uid + ")";
        System.out.println(sql);

        ResultSet rs = SqlDB.executeQuery(sql);
        List<Cacl> list = new ArrayList<Cacl>();
        try {
            while (rs.next()) {
                Cacl table = new Cacl();
                table.setTid(rs.getLong("cid"));
                table.setAuthor(rs.getInt("author"));
                table.setName(rs.getString("cname"));
                table.setStructure(rs.getString("structure"));
                table.setPostime(rs.getTimestamp("postime").toString());
                list.add(table);
            }
        } catch (SQLException ex) {
            
        }

        SqlDB.close();

        return list;
    }

    @Override
    public boolean appendUserDate(String cid, String uid, String data) {
        MongoCollection<Document> collection = NosqlDB.getCollection(cid);
        
        collection.insertOne(Document.parse(data));
        return  true;
    }

    @Override
    public boolean deleteUserDate(String cid, String uid) {
        MongoCollection<Document> collection = NosqlDB.getCollection(cid);
        
        collection.deleteMany(Filters.eq("uid", uid));
        return true;
    }

    @Override
    public boolean alterUserDate(String cid, String uid, String data) {
        MongoCollection<Document> collection = NosqlDB.getCollection(cid);
        data = data.replace("\'", "\"");
        Bson json = Document.parse(data);

        collection.deleteMany(Filters.eq("uid", uid));
        collection.insertOne((Document) json);
        //collection.updateMany(Filters.eq("uid", uid), json);
        return true;
    }

    @Override
    public String getUserData(String cid, String uid) {
        MongoCollection<Document> collection = NosqlDB.getCollection(cid);
        String json = "";
        FindIterable<Document> findIterable = collection.find(Filters.eq("uid", uid));
        MongoCursor<Document> mongoCursor = findIterable.iterator();

        while (mongoCursor.hasNext()) {
            json += mongoCursor.next().toJson();
        }
        return json;
    }
    
    @Override
    public List  getCaclData(String cid) {
        MongoCollection<Document> collection = NosqlDB.getCollection(cid);
        
        /**
         * 检索所有文档
         * 1. 获取迭代器FindIterable<Document>
         * 2. 获取游标MongoCursor<Document>
         * 3. 通过游标遍历检索出的文档集合 
         *
         */
        List<String> data = new ArrayList();
        FindIterable<Document> findIterable = collection.find();
        MongoCursor<Document> mongoCursor = findIterable.iterator();
        
        while (mongoCursor.hasNext()) {            
            data.add(mongoCursor.next().toJson());
            System.out.println(data);
        }
        
        return data;
    }
    
}
