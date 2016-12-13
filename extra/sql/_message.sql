use j2e;
create table message (
	MID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	MSG varchar(1000) NOT NULL ,
	MTYPE varchar(20) NOT NULL ,
	STAUTS boolean NOT NULL DEFAULT FALSE,
    _FROM int UNSIGNED NOT NULL,
    _TO int UNSIGNED NOT NULL,
	TIMESTAMP datetime NOT NULL ,
    foreign key(_FROM) references user(UID) on delete cascade on update cascade,
    foreign key(_TO) references user(UID) on delete cascade on update cascade,
	primary key (MID));
