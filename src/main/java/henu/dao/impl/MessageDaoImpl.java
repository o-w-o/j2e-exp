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

import henu.dao.vo.Message;
import henu.dao.api.IMessageDao;
import henu.util.SqlDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.json.JSONObject;
/**
 *
 * @author dot
 */
public class MessageDaoImpl implements IMessageDao{
    
    public MessageDaoImpl() {
        
    }
    
    /**
     * The current set of stored messages
     */
    private final LinkedList<Message> messagesQueue = new LinkedList<Message>();

    @Override
    public boolean save(Message message, boolean status) {
        String sql = "insert into message "
            + "( _from, _to, msg, timestamp, mtype, stauts) values"
            + "(?,?,?,?,?,?)";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);
        int result = 0;

        try {
            ps.setLong(1, Long.parseLong(message.getFrom()));
            ps.setLong(2, Long.parseLong(message.getTo()));
            ps.setString(3, message.getMsg());
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            ps.setString(5, message.getType());
            ps.setBoolean(6, message.getStatus());
            
            //ps.setInt(7, Integer.parseInt("144520200" + (int) Math.random()*10));
            //ps.setInt(7, Integer.parseInt(message.getMid()));
            result = ps.executeUpdate();
            System.out.println("result: " + result);
        } catch (NumberFormatException | SQLException e) {
            System.err.println(e.getMessage());
            System.out.println("result: error" + result);
            System.out.println(JSONObject.fromObject(message));
        }

        SqlDB.close();  
        return result>0;
    }

    @Override
    public boolean delete(String mid) {
        String sql = "delete from message where mid=" + mid;

        int result = SqlDB.executeUpdate(sql);

        SqlDB.close();

        return result > 0;
    }

    @Override
    public boolean findByContent(String keywords) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean findById(String uid) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    @Override
    public List<Message> getMessageList(String uid){
        String sql = "select * from message where _from = " + uid + " or _to = " + uid + " order by timestamp";
        System.out.println(sql);

        ResultSet rs = SqlDB.executeQuery(sql);
        List<Message> list = new ArrayList<Message>();
        try {
            while (rs.next()) {
                Message message = new Message();
                message.setFrom(String.valueOf(rs.getLong("_from")));
                message.setTo(String.valueOf(rs.getLong("_to")));
                message.setMid(String.valueOf(rs.getLong("mid")));
                message.setMsg(rs.getString("msg"));
                message.setTimestamp(rs.getString("timestamp"));
                message.setType(rs.getString("mtype"));
                message.setStatus(rs.getBoolean("stauts"));
                list.add(message);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        SqlDB.close();

        return list;
    }

    @Override
    public boolean updateMessageStatus(String mid, boolean status) {
        String sql = "update message set status=? where mid=?";
        PreparedStatement ps = SqlDB.executePreparedStatement(sql);
        int result = 0;
        
        try {
            ps.setBoolean(1, status);
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MessageDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result>0;
    }
    
}
