/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henu.util;

import com.mongodb.BasicDBObject;
import com.mongodb.CommandResult;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;

/**
 *
 * @author dot
 */
public class NosqlDB {
    
    private static final String ADDRESS = "localhost";
    private static final int PORT = 27017;
    private static final String USERNAME = "";
    private static final String PASSWORD = "";
    private static final String RESOURCE_FILE = "mongodb.cfg.properties";
    private static final String DBNAME = "test";
    
    public static MongoDatabase getMongoDataBase(){
        try {
            // 连接到 mongodb 服务
            MongoClient mongoClient = new MongoClient(ADDRESS, PORT);

            // 连接到数据库
            MongoDatabase mongoDatabase = mongoClient.getDatabase(DBNAME);
            System.out.println("Connect to database successfully");
            return mongoDatabase;

        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        
        return null;
    }
    
    public static MongoDatabase getMongoDataBaseByAuth() {

        try {

            //连接到MongoDB服务 如果是远程连接可以替换“localhost”为服务器所在IP地址  
            //ServerAddress()两个参数分别为 服务器地址 和 端口 
            ServerAddress serverAddress = new ServerAddress(ADDRESS, PORT);
            List<ServerAddress> addrs = new ArrayList<ServerAddress>();
            addrs.add(serverAddress);

            //MongoCredential.createScramSha1Credential()三个参数分别为 用户名 数据库名称 密码  
            MongoCredential credential = MongoCredential.createScramSha1Credential(USERNAME, DBNAME, PASSWORD.toCharArray());
            List<MongoCredential> credentials = new ArrayList<MongoCredential>();
            credentials.add(credential);

            //通过连接认证获取MongoDB连接  
            MongoClient mongoClient = new MongoClient(addrs, credentials);

            // 连接到数据库
            MongoDatabase mongoDatabase = mongoClient.getDatabase(DBNAME);
            System.out.println("Connect to database successfully");
            
            return mongoDatabase;
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }    
        
        return null;
    }
    
    public static boolean createCollection(String collectionName) {
        MongoDatabase db = getMongoDataBase();

        try {
            db.createCollection(collectionName);
            return true;
        } catch (Exception e) {

        }
        return false;
    }
    
    public static MongoCollection<Document> getCollection(String collectionName){
        
        try{
            
            MongoDatabase db = getMongoDataBase();

            MongoCollection<Document> collection = db.getCollection(collectionName);
            System.out.println("集合 " + collectionName + " 选择成功!");
            return collection;
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
        return null;
    }
    
    
    public static void delete(){
        
    }
}
