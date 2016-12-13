/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henu.util;

/**
 *
 * @author dot
 */
public class StringConvert {
    
    //将ISO-8859-1编码的字符转换为UTF-8编码方式
    public static String IOS2UTF(String s){
        String ns;
        try {
            if(s.equals("") || s==null){
                return "";
            }else{
                s = s.trim();
                ns = new String(s.getBytes("ISO-8859-1"), "UTF-8");
                return ns;
            }
        } catch (Exception e) {
            System.out.println("编码转换错误: " + e.getMessage());
            return "";
        }
    }
    
    //将ISO-8859-1编码的字符转换为UTF-8编码方式
    public static String UTF2IOS(String s) {
        String ns;
        try {
            if (s.equals("") || s == null) {
                return "";
            } else {
                s = s.trim();
                ns = new String(s.getBytes("UTF-8"), "ISO-8859-1");
                return ns;
            }
        } catch (Exception e) {
            System.out.println("编码转换错误: " + e.getMessage());
            return "";
        }
    }
    
    public static String GBK2UTF(String s) {
        String ns;
        try {
            if (s.equals("") || s == null) {
                return "";
            } else {
                s = s.trim();
                ns = new String(s.getBytes("GBK"), "UTF-8");
                return ns;
            }
        } catch (Exception e) {
            System.out.println("编码转换错误: " + e.getMessage());
            return "";
        }
    }
    public static String GB2UTF(String s) {
        String ns;
        try {
            if (s.equals("") || s == null) {
                return "";
            } else {
                s = s.trim();
                ns = new String(s.getBytes("GB2312"), "UTF-8");
                return ns;
            }
        } catch (Exception e) {
            System.out.println("编码转换错误: " + e.getMessage());
            return "";
        }
    }
}
