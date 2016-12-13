use j2e;
create table cacl (

    CID BIGINT UNSIGNED,
    CTYPE boolean DEFAULT FALSE,/* 类型:公开或私有 */
    CNAME varchar(150) NOT NULL,
    STRUCTURE varchar(500) NOT NULL,
    AUTHOR  int UNSIGNED NOT NULL,
    POSTIME datetime NOT NULL ,
    ENDTIME datetime ,
    foreign key (AUTHOR) references user(UID) on delete cascade on update cascade,
    primary key (CID));
    
