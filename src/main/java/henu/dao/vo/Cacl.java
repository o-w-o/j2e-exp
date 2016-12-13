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
package henu.dao.vo;

/**
 *
 * @author dot
 */
public class Cacl {
    
    private long tid;
    private long author;
    private long [] users;
    private boolean type;
    private String name;
    private String postime;
    private String endtime;
    //private boolean status;
    private String structure;

    public Cacl() {
        
    }
    
    public Cacl(long tid, long author, long [] users, boolean type, String name, String postime, String endtime, String structure) {
        this.tid = tid;
        this.author = author;
        this.users = users;
        this.type = type;
        this.name = name;
        this.postime = postime;
        this.endtime = endtime;
        this.structure = structure;
    }

    
    /**
     * @return the tid
     */
    public long getTid() {
        return tid;
    }

    /**
     * @param tid the tid to set
     */
    public void setTid(long tid) {
        this.tid = tid;
    }

    /**
     * @return the author
     */
    public long getAuthor() {
        return author;
    }

    /**
     * @param author the author to set
     */
    public void setAuthor(long author) {
        this.author = author;
    }

    /**
     * @return the users
     */
    public long[] getUsers() {
        return users;
    }

    /**
     * @param users the users to set
     */
    public void setUsers(long[] users) {
        this.users = users;
    }

    /**
     * @return the type
     */
    public boolean getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(boolean type) {
        this.type = type;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the postime
     */
    public String getPostime() {
        return postime;
    }

    /**
     * @param postime the postime to set
     */
    public void setPostime(String postime) {
        this.postime = postime;
    }

    /**
     * @return the endtime
     */
    public String getEndtime() {
        return endtime;
    }

    /**
     * @param endtime the endtime to set
     */
    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    /**
     * @return the structure
     */
    public String getStructure() {
        return structure;
    }

    /**
     * @param structure the structure to set
     */
    public void setStructure(String structure) {
        this.structure = structure;
    }

}
