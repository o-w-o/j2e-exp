/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henu.dao.api;

import henu.dao.vo.User;
import java.util.List;
import java.util.Map;

/**
 *
 * @author dot
 */
public interface IUserDao {
    
    public String isExist(String uid);
        
    /**
     * 用户注册
     * @param user
     * @return 
     */
    public boolean signUp(User user);
    
    /**
     * 用户登录
     * @param uid
     * @param password
     * @return 成功返回 true,否则 false
     */
    public boolean signIn(String uid, String password);
    
    /**
     * 用户退出
     * @param uid
     * @param password
     * @return 成功返回 true,否则 false
     */
    public boolean signOut(String uid, String password);

    /**
     * 
     * @param user
     * @return 
     */
    public boolean appendUser(User user);
    
    /**
     * 删除用户
     * @param uid
     * @return 
     */
    public boolean deleteUser(String uid);
    
    /**
     * 更新用户信息
     * @param uid
     * @param user
     * @return 
     */
    
    public boolean updateUserPassword(String uid, User user);
    
    public boolean updateUserBasicInfo(String uid, User user);
    
    public boolean updateUserType(String uid, User user);
    
    /**
     * 获取某人详细信息
     * @param uid
     * @param isPublic
     * @return 
     */
    public User getUser(String uid, boolean isPublic);
    
    public List<User> findUsers(String uid);
    
    public List<User> getUsersInfo();
    
}
