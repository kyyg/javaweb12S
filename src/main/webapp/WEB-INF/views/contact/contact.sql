/* inquiry2 */
show tables;

/* 제휴 문의 */
CREATE TABLE contact (
	idx INT NOT NULL AUTO_INCREMENT,						/* 고유번호 */
	mid VARCHAR(20) NOT NULL,										/* 아이디 */
	title VARCHAR(100) NOT NULL,								/* 1:1 문의 제목 */
	part VARCHAR(20) NOT NULL,									/* 분류(카테고리) */
	wDate DATETIME NOT NULL DEFAULT now(),			/* 문의쓴 날짜 */
	content TEXT NOT NULL,											/* 문의 내역 */
	fName varchar(100),													/* 문의시에 올린 사진이나 문서파일 */
	fSName varchar(200),												/* 문의시에 올린 서버에 저장된 사진이나 문서파일 - 여기선 사진,압축파일만 올리도록처리함 */
	reply varchar(10) DEFAULT '답변대기중',				/* 답변 여부(답변대기중/답변완료) */
	PRIMARY KEY (idx),													  /* 주키 : 고유번호 */
  FOREIGN KEY (mid) REFERENCES member(mid) 	/* 외래키 : 회원 아이디 */
);
desc contact;

/*제휴 문의 답변글 */
CREATE TABLE contactReply (
	reIdx 		  INT NOT NULL AUTO_INCREMENT,
	contactIdx 	INT NOT NULL ,
	reWDate 		DATETIME NOT NULL DEFAULT now(),
	reContent	  TEXT NOT NULL,
	PRIMARY KEY (reIdx),
  FOREIGN KEY (contactIdx) REFERENCES contact(idx)
);

desc contactReply;
drop table contact;

select * from contact;

select * from contactReply;
select * from contactReply where inquiryIdx = 1;

