show tables;


select count(*) from dbbaesong,member where orderStatus='결제완료' and member.mid='admin';

select sum(orderTotalPrice) from dbbaesong,member where member.mid='admin';

select * from dborder;

select bs.orderIdx,oder.* from dborder oder, dbBaesong bs, member mem where mem.mid ='admin' and oder.orderIdx=bs.orderIdx;

SELECT SUM(orderTotalPrice)
FROM dbbaesong, member
WHERE member.mid = 'admin'
    AND orderDate >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH);

/* 대분류 */
create table categoryMain (
  categoryMainCode  char(2) not null,			/* 대분류코드(A,B,C,.... => 영문 대문자 1자 */
  categoryMainName  varchar(20) not null, /* 대분류명(회사명 => 현대/삼성/LG... */
  primary key(categoryMainCode),
  unique key(categoryMainName)
);

/* 중분류 */
create table categoryMiddle (
  categoryMainCode  char(2) not null,				/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2) not null,			/* 중분류코드(01,02,03,.... => 숫자(문자형식) 2자리 */
  categoryMiddleName  varchar(20) not null, /* 중분류명(제품분류명 => 전자제품/의류/신발류/차종.. */
  primary key(categoryMiddleCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode)
);

/* 소분류 */
create table categorySub (
  categoryMainCode  char(1) not null,			/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2) not null,		/* 중분류코드를 외래키로 지정  */
  categorySubCode  char(3) not null,			/* 소분류코드(001,002,003,... =>숫자(문자형식의) 3자리)  */
  categorySubName  varchar(20) not null, 	/* 소분류명(상품구분 => 중분류가 '전자제품'이라면? 냉장고/에어컨/오디오/TV...  */
  primary key(categorySubCode),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode)
);

/* 세분류(상품 테이블) */
create table dbProduct (
  idx   int not null,		/* 상품 고유번호 */
  categoryMainCode  char(2) not null,		/* 대분류코드를 외래키로 지정 */
  categoryMiddleCode  char(2) not null,	/* 중분류코드를 외래키로 지정  */
	productCode  varchar(20) not null,		/* 상품고유코드(대분류코드+중분류코드+소분류코드+상품고유번호) 예: A 05 002 5) */
	productName  varchar(50) not null,		/* 상품명(상품모델명) - 세분류 */
	detail			varchar(100) not null,		/* 상품의 간달설명(초기화면출력에 필요) */
	mainPrice		int not null,							/* 상품의 기본가격 */
	fSName			varchar(200) not null,		/* 상품의 기본사진(1장이상 처리시에는 '/'로 구분 저장한다. */
	content			text not null,						/* 상품의 상세설명 - ckeditor를 이용한 이미지 1장으로 처리한다. */
	primary key(idx),
	unique  key(productCode,productName),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode)
);

/* 상품 옵션 */
create table dbOption (
  idx    int not null auto_increment,	/* 옵션 고유번호 */
  productIdx int not null,				/* product테이블(상품)의 고유번호 - 외래키 지정 */
  optionName varchar(50) not null,/* 옵션 이름 */
  optionPrice int not null default 0, /* 옵션 가격 */
  primary key(idx),
  foreign key(productIdx) references dbProduct(idx)
);

drop table categoryMiddle;
drop table dbProduct;


create table dbCart (
  idx   int not null auto_increment,			/* 장바구니 고유번호 */
  cartDate datetime default now(),				/* 장바구니에 상품을 담은 날짜 */
  mid   varchar(20) not null,							/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디이다. */
  productIdx  int not null,								/* 장바구니에 구입한 상품의 고유번호 */
  productName varchar(50) not null,				/* 장바구니에 담은 구입한 상품명 */
  mainPrice   int not null,								/* 메인상품의 기본 가격 */
  thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionIdx	  varchar(50)	 not null,			/* 옵션의 고유번호리스트(여러개가 될수 있기에 문자열 배열로 처리한다.) */
  optionName  varchar(100) not null,			/* 옵션명 리스트(배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  primary key(idx,mid),
  foreign key(productIdx) references dbProduct(idx) on update cascade on delete restrict
);

drop table dbCart;


select * from dbOrder;




/* 주문 테이블 -  */
create table dbOrder (
  idx         int not null auto_increment, /* 고유번호 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호(새롭게 만들어 주어야 한다.) */
  mid         varchar(20) not null,   /* 주문자 ID */
  productIdx  int not null,           /* 상품 고유번호 */
  orderDate   datetime default now(), /* 실제 주문을 한 날짜 */
  productName varchar(50) not null,   /* 상품명 */
  mainPrice   int not null,				    /* 메인 상품 가격 */
  thumbImg    varchar(100) not null,   /* 썸네일(서버에 저장된 메인상품 이미지) */
  optionName  varchar(100) not null,  /* 옵션명    리스트 -배열로 넘어온다- */
  optionPrice varchar(100) not null,  /* 옵션가격  리스트 -배열로 넘어온다- */
  optionNum   varchar(50)  not null,  /* 옵션수량  리스트 -배열로 넘어온다- */
  totalPrice  int not null,					  /* 구매한 상품 항목(상품과 옵션포함)에 따른 총 가격 */
  status  varchar(50)  not null default '결제완료',			  /* 구매한 옵션 각각의 주문 상태 */
  reviewConfirm  varchar(50)  not null default 'NO',		/* 리뷰 썼는지 여부 기본 : NO */
  primary key(idx, orderIdx),
  foreign key(mid) references member(mid),
  foreign key(productIdx) references dbProduct(idx)  on update cascade on delete cascade
);
drop table dbOrder;
desc dbOrder;
delete from dbOrder;
select * from dbOrder;

drop table dbBaesong;
drop table dbOrder;
/* 머시기 cascade 500번 오류가 뜨면 걍 지우고 다시 만들자. 지울땐 배송-오더 / 만들땐 오더-배송 순서대로 */

/* 배송테이블 */
create table dbBaesong (
  idx     int not null auto_increment,
  oIdx    int not null,								/* 주문테이블의 고유번호를 외래키로 지정함 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호 */
  orderDate datetime not null default now(), /* 주문날짜 */
  orderTotalPrice int     not null,   /* 주문한 모든 상품의 총 가격 */
  mid         varchar(20) not null,   /* 회원 아이디 */
  name				varchar(20) not null,   /* 배송지 받는사람 이름 */
  address     varchar(100) not null,  /* 배송지 (우편번호)주소 */
  tel					varchar(15),						/* 받는사람 전화번호 */
  message     varchar(100),						/* 배송시 요청사항 */
  payment			varchar(10)  not null,	/* 결재도구 */
  payMethod   varchar(50)  not null,  /* 결재도구에 따른 방법(카드번호) */
  orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료->배송중->배송완료->구매완료) 전체적인 배송에 대한 여부! 오더에 있는 status의 큰집합*/
  primary key(idx),
  unique key(orderIdx),
  foreign key(oIdx) references dbOrder(idx) on update cascade on delete cascade
);

drop table dbBaesong;


/* 위시리스트 */
create table wish (
  idx     int not null auto_increment,	/* 좋아요 고유번호 */
  productIdx int  not null,				/* 찜기능 누른 상품 고유번호 */
  productName varchar(100) not null, /* 상품 이름 */
  mid			varchar(20) not null,	/* 찜 누른 사용자의 아이디 */
  wdate datetime default now(), /* 찜기능 누른 날짜 */
  primary key(idx),
  foreign key(productIdx) references dbProduct(idx)
);

drop table wish;


select * from dbOrder where orderDate between '2023-07-01 00:00:00' and '2023-07-04 23:59:59';



/* 반품/환불 */
create table dbOrderCancel(
	idx int not null auto_increment,	/* 취소 고유번호 */
	mid varchar(20) not null,					/* 사용자의 아이디 */
	orderIdx  varchar(15) not null,   /* 주문 고유번호 */
	cancelIdx int not null, 					/* 취소할 오더 한가지의 고유idx */
	cancelDate datetime default now(), /* 취소신청 날짜 */
	cancelMemo varchar(500) not null, /* 취소 메모 */
	cancelStatus varchar(20), 				/* 취소 상태 */
	primary key(idx),
	foreign key(orderIdx) references dbBaesong(orderIdx) on update cascade on delete cascade
);

drop table dbOrderCancel;



/* 리뷰 */
create table dbReview(
	idx int not null auto_increment,
	productIdx int not null, 
	productName varchar(50) not null, 
	mid varchar(20) not null,					/* 사용자의 아이디 */
	title varchar(100) not null,	
	content text not null,
	fSName varchar(200) not null,		/* 상품의 기본사진(1장이상 처리시에는 '/'로 구분 저장한다. */
	score int not null, 
	wDate datetime default now(),
	bestReview char(2) default 'NO', /* 관리자가 베스트 여부 설정기능 */
	blockReview char(2) default 'NO', /* 관리자가 리뷰 차단 */
	reportNum int not null default 0,
	primary key(idx),
	foreign key(productIdx) references dbProduct(idx) on update cascade on delete cascade
);

drop table dbReview;


/* 포인트 적립/사용내역 */
create table dbPoint(
 idx int not null auto_increment,
 mid varchar(20) not null,					/* 사용자의 아이디 */
 orderIdx varchar(20) not null, /* 어떤 주문에 대한 건인지 */
 wDate datetime default now(),
 pointMemo varchar(100) not null, 
 getPoint int default 0,
 usePoint int default 0,
 primary key(idx,mid)
);

drop table dbPoint;

날짜   적립/사용사유  겟포인트  사용포인트
7/12  상품구매      +150
7/15  상품구매              -200
7/16  리뷰적립      +500

create table onedayClass(
	idx int not null auto_increment,
  mid varchar(20) not null,		
  className varchar(100) not null,	
  store varchar(50) not null,	
	wDate datetime default now(),
	memberNum int not null,
	qrCodeName varchar(100) not null,
	primary key(idx,mid)	
);


create table reportReview(
	 idx int not null auto_increment,
	 reviewIdx int not null, /* 신고된 원본 리뷰 번호 */
	 mid varchar(20) not null, /* 신고자 아이디 */
	 reportMemo1 varchar(100) not null, /* 신고 이유 */
	 reportMemo2 varchar(100) not null, /* 신고 이유 */
	 reportDate datetime not null default now(),
	 primary key(idx),
	 foreign key(reviewIdx) references dbReview(idx)
);

drop table reportReview;

/* 회원 배송지 목록 */
create table dbShippingList(
 idx int not null auto_increment,
 shippingName varchar(30) not null, 
 mid varchar(20) not null,
 tel varchar(20) not null,
 address varchar(100) not null,
 email varchar(50) not null,
 primary key (idx),
 foreign key(mid) references member(mid)
);
