create table redhat_member(
name varchar(30) not null,
uid varchar(30) not null,
passwd varchar(30) not null,
primary key(uid)
)engine=InnoDB default charset=utf8;

insert into redhat_member(name, uid, passwd) values('관리자','admin','admin');
insert into redhat_member values('user1','user1','1234');
insert into redhat_member values('user2','user2','1234');
insert into redhat_member values('user3','user3','1234');
insert into redhat_member values('user4','user4','1234');


create table redhat_message(
mid integer(10),
uid varchar(30),
msg varchar(100),
primary key(mid)
)engine=InnoDB default charset=utf8;


create table enterprise_data(
e_code varchar(10) not null,
e_name varchar(30) not null,
e_family boolean not null,
primary key(e_code)
)engine=InnoDB default charset=utf8;


insert into enterprise_data(e_code, e_name, e_family) values ('017670','에스케이텔레콤',true);
insert into enterprise_data(e_code, e_name, e_family) values ('020560','아시아나항공',true);
insert into enterprise_data(e_code, e_name, e_family) values ('023530','롯데쇼핑',true);
insert into enterprise_data(e_code, e_name, e_family) values ('005930','삼성전자',true);
insert into enterprise_data(e_code, e_name, e_family) values ('035420','네이버',true);
insert into enterprise_data(e_code, e_name, e_family) values ('060000','국민은행',false);
insert into enterprise_data(e_code, e_name, e_family) values ('005830','동부화재해상보험',false);
insert into enterprise_data(e_code, e_name, e_family) values ('003490','대한항공',false);
insert into enterprise_data(e_code, e_name, e_family) values ('032710','신한카드',false);
insert into enterprise_data(e_code, e_name, e_family) values ('051910','LG화학',false);


create table enterprise_scrap(
uid varchar(50) not null,
e_code varchar(50) not null,
e_name varchar(50) not null,
primary key(uid,e_code)
)engine=InnoDB default charset=utf8;


create table enterprise_evaluation(
e_code varchar(10) not null,
total_evaluation integer(10) not null,
female_welfare integer(10) not null,
promotion_chance integer(10) not null,
gender_equal integer(10) not null,
primary key(uid, e_code),
CONSTRAINT foreign key(e_code) references enterprise_data(e_code) ON DELETE CASCADE,
CONSTRAINT foreign key(uid) references redhat_member(uid) ON DELETE CASCADE  

)engine=InnoDB default charset=utf8;


create table enterprise_reply(
e_code varchar(10) not null,
uid varchar(30) not null,
reply_content varchar(50) not null,
current datetime,
primary key(uid,e_code),
CONSTRAINT foreign key(e_code) references enterprise_data(e_code) ON DELETE CASCADE,
CONSTRAINT foreign key(uid) references redhat_member(uid) ON DELETE CASCADE  
)engine=InnoDB default charset=utf8;




