use j2e;
create table user (
	UID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	UTYPE varchar(20) NOT NULL ,
	UNAME varchar(20) NOT NULL,
	PASSWORD varchar(20) NOT NULL ,
	EMAIL varchar(100) ,
	BIRTHDAY varchar(20) ,
	GENDER varchar(20) ,
	UWORDS varchar(150) ,
	primary key (UID))
    AUTO_INCREMENT=2269396336;
