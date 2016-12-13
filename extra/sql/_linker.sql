use j2e;
create table linker (
    UID INT UNSIGNED NOT NULL,
    LTYPE varchar(15) DEFAULT 'UNACCEPT', /*类型 [ 个人好友 | 个人群组 ]*/
    LID INT UNSIGNED NOT NULL UNIQUE,
    LNAME varchar(15) NOT NULL,
    TAG varchar(15) /* 标签 */,
    STATUS boolean DEFAULT FALSE,
    foreign key(UID) references user(UID) on delete cascade on update cascade,
    primary key(UID,LID));