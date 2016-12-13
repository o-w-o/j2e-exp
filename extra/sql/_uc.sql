use j2e;
create table uc (
    CID BIGINT UNSIGNED NOT NULL,
    UID INT UNSIGNED NOT NULL,
    STATUS BOOLEAN DEFAULT FALSE,
    SUBMITIME DATETIME ,
    foreign key(CID) references cacl(CID) on delete cascade on update cascade,
    foreign key(UID) references user(UID) on delete cascade on update cascade,
    primary key(UID,CID));