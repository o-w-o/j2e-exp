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
package henu.dao;

import henu.dao.api.ICaclDao;
import henu.dao.api.IMessageDao;
import henu.dao.api.ILinkerDao;
import henu.dao.api.IUserDao;
import henu.dao.impl.LinkerDaoImpl;
import henu.dao.impl.MessageDaoImpl;
import henu.dao.impl.CaclDaoImpl;
import henu.dao.impl.UserDaoImpl;

/**
 *
 * @author dot
 */
public class DaoFactory {
    
    public static IUserDao getUserDaoInstance(){
        return new UserDaoImpl();
    }
    
    public static ILinkerDao getLinkerDaoInstance(){
        return new LinkerDaoImpl();
    }
    
    public static ICaclDao getCaclDaoInstance(){
        return new CaclDaoImpl();
    }
    
    public static IMessageDao getMsgDaoInstance(){
        return new MessageDaoImpl();
    }
    
}
