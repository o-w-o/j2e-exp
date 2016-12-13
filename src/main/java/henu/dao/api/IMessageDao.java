/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henu.dao.api;

import henu.dao.vo.Message;
import java.util.List;

/**
 *
 * @author dot
 */
public interface IMessageDao{
    
    public boolean save(Message message, boolean status);
    
    /**
     * 删除信息
     * @param mid
     * @return
     */
    public boolean delete(String mid);
    
    /**
     * @param mid
     * @param status
     * @return 
     */
    public boolean updateMessageStatus(String mid, boolean status);
    
    /**
     * @param keywords
     * @return
     */
    public boolean findByContent(String keywords);
    
    /**
     * @param uid
     * @return 
     */
    public boolean findById(String uid);
    
    public List<Message> getMessageList(String uid);
}