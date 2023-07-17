show tables;

create table kakaoAddress(
	address varchar(50) not null, /* 지점명 */
	latitude double not null, 		/* 위도 */
	longitude double not null  	/* 경도 */
);

drop table kakaoAddress;

create table kakaoAddress(
	lat double not null, 		/* 위도 */
	lng double not null, 	/* 경도 */
	store_name varchar(50) not null, 
	detail_address varchar(100) not null, 
	rode_address varchar(100) not null, 
	store_tel varchar(50) not null 
);

desc kakaoAddress;

select * from kakaoAddress;