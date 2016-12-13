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
package henu.util;

import java.net.NetworkInterface;
import java.nio.charset.Charset;
import java.util.Enumeration;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import sun.misc.CRC16;
/**
 *
 * @author dot
 */
public class IDUtils {
    
    public static final String CLUSTER_APPID_KEY = "cluster.appid";
    private static final Charset UTF8 = Charset.forName("utf-8");
    private static final Pattern PATTERN = Pattern.compile("([0-9]{1})_([0-9]{1,2})");
    private static final AtomicInteger ATOMICID = new AtomicInteger(1);
    private static final int APP_ID_INC = 1000000;
    private static int _ID = 101 * APP_ID_INC;

    static{
        //初始化appId,默认没有配置，为mac地址crc16计算值
        initId(null);
    }
    /*
     *根据配置的ID，做解析，配置示例：
     *appId=IdcId_HostId，
     *例如：appId=1_01,appId=1_02;appId=2_01,appId=2_02;
     * */
    public static void initId(String cfgId) {
        _ID = parseId(cfgId);
        if (0 == _ID) {
            _ID = generateRandId();
        }
        //Logger.warn("IdGenerator: APP-ID: %d", _ID);
    }

    private static int parseId(String cfgAppId) {
        try {
            if (null == cfgAppId) {
                return 0;
            }

            Matcher matcher = PATTERN.matcher(cfgAppId);
            if (matcher.find()) {
                String idcId = matcher.group(1);
                int nIdcId = Integer.parseInt(idcId);
                String hostId = matcher.group(2);
                int nHostId = Integer.parseInt(hostId);
                int appId = nIdcId * 100 + nHostId;
                return appId * APP_ID_INC;
            }
        } catch (Exception e) {
            //ignore
        }
        return 0;
    }

    private static int generateRandId() {
        String mac = UUID.randomUUID().toString();
        try {
            String tmpMac = getMacAddress();
            if (null != tmpMac) {
                mac = tmpMac;
            }
        } catch (Exception e) {
            //ignore
        }
        int tmpRst = getChecksum(mac);
        if (tmpRst < 999 && tmpRst > 0) {
            return tmpRst * APP_ID_INC;
        }
        //大于999，取余数
        int mod = tmpRst % 999;
        if (mod == 0) {
            //不允许取0
            mod = 1;
        }
        return mod * APP_ID_INC;
    }

    private static String getMacAddress() throws Exception {
        Enumeration<NetworkInterface> ni = NetworkInterface.getNetworkInterfaces();
        while (ni.hasMoreElements()) {
            NetworkInterface netI = ni.nextElement();
            if (null == netI) {
                continue;
            }
            byte[] macBytes = netI.getHardwareAddress();
            if (netI.isUp() && !netI.isLoopback() && null != macBytes && macBytes.length == 6) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0, nLen = macBytes.length; i < nLen; i++) {
                    byte b = macBytes[i];
                    //与11110000作按位与运算以便读取当前字节高4位  
                    sb.append(Integer.toHexString((b & 240) >> 4));
                    //与00001111作按位与运算以便读取当前字节低4位  
                    sb.append(Integer.toHexString(b & 15));
                    if (i < nLen - 1) {
                        sb.append("-");
                    }
                }
                return sb.toString().toUpperCase();
            }
        }
        return null;
    }

    /**
     * 获取对应的CRC16校验码
     * @param input 待校验的字符串
     * @return 返回对应的校验和
     */
    private static int getChecksum(String input) {
        if (null == input) {
            return 0;
        }
        byte[] data = input.getBytes(UTF8);
        CRC16 crc16 = new CRC16();
        for (byte b : data) {
            crc16.update(b);
        }
        return crc16.value;
    }

    /**
     * 获取随机数,加大随机数位数，是为了防止高并发，且单个并发中存在循环获取ID的场景
     * 如果您的应用并发有200以上，且每个并发中都存在循环调用获取ID的场景，可能会发生ID冲突
     * 对应的解决方法是：在循环逻辑中加入休眠1-5ms的逻辑
     * @return
     */
    private static int getRandNum() {
        int num = ATOMICID.getAndIncrement();
        if (num >= 999999) {
            ATOMICID.set(0);
            return ATOMICID.getAndIncrement();
        }
        return num;
    }
    
    public static Long getId() {
       
        long id = getBasicId();
        return Long.valueOf(id);
    }

    public static long getBasicId() {
        return (System.currentTimeMillis() / 1000) * 1000000000 + _ID + getRandNum();
    }
    
    public static String getUUID() {
        UUID uuid = UUID.randomUUID();
        String str = uuid.toString();
        String uuidStr = str.replace("-", "");
        return uuidStr;
    }
}
