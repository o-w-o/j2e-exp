/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henu.dao.api;

import henu.dao.vo.Linker;
import java.util.List;

/**
 *
 * @author dot
 */
public interface ILinkerDao {

    public boolean makeFriend(String uid, String lid);
    
    /**
     * 批准交友请求
     *
     * @param uid
     * @param lid
     * @param lname
     * @return 成功返回 true,否则 false
     */
    public boolean approveFriend(String uid, String lid, String lname);

    /**
     * 删除好友
     *
     * @param uid
     * @param lid
     * @return 成功返回 true,否则 false
     */
    public boolean deleteFriend(String uid, String lid);

    /**
     * 获取好友列表
     *
     * @param uid
     * @return
     */
    public List<Linker> getFriendsList(String uid);
    
}
