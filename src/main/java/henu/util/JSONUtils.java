/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henu.util;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author dot
 */
public class JSONUtils {
    public static String setStatusCode(int statusCode, String data) {
        
        return "{\"code\":\"" + statusCode + "\",\"data\":"+ data + "}";
    }
    public static Map toMap(String from, Object to) {
        
        Map toMap = new HashMap();
        toMap.put(from, to);
        return (Map) to;
    }
}
