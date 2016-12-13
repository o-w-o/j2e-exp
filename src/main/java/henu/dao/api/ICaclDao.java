package henu.dao.api;

import henu.dao.vo.Cacl;
import henu.dao.vo.User;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author dot
 */
public interface ICaclDao {
    
    /**
     * 创建表格(结构)
     *
     * @param cacl
     * @return 成功返回 true,否则 false Map<Cacl, TableData>>
     */
    public boolean createCacl(Cacl cacl);
    public boolean recordCaclUser(long tid, long[] users);
    /**
     * 删除表格结构及数据
     * @param tid
     * @return 
     */
    public boolean deleteCacl(String tid);

    public List<Cacl> getCacList(String uid);
    
    public long[] getCaclUserList(String tid);

    public List<Cacl> getFormList(String uid);

    /**
     * 获取 TID 表格
     *
     * @param tid
     * @return
     */
    public Cacl getCacl(String tid);

    /**
     * 追加表格数据
     * @param tid
     * @param uid
     * @param data
     * @return
     */
    public boolean appendUserDate(String tid, String uid, String data);

    /**
     * 删除表格数据
     * @param tid
     * @param uid
     * @return 
     */
    public boolean deleteUserDate(String tid, String uid);

    /**
     * 修改表格数据
     * @param tid
     * @param uid
     * @param data
     * @return
     */
    public boolean alterUserDate(String tid, String uid, String data);
    
    /**
     * 获取某用户表格数据
     * @param tid
     * @param uid
     * @return 
     */
    public String getUserData(String tid, String uid);
    
    /**
     * 获取表格全部数据
     *
     * @param tid
     * @return
     */
    public List<String> getCaclData(String tid);
}
